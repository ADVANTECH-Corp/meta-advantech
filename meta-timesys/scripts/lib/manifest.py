#!/usr/bin/env python
# Copyright (C) 2018 Timesys Corporation

import curses
from _curses import error as CursesError
from datetime import datetime
import json
import os
import sys


class ImageManifest(object):
    manifest_version = "1.6"

    def __init__(self, broot, target=None, outfile=None):
        sys.path.insert(0, os.path.join(broot, 'lib'))
        import bb
        import bb.tinfoil
        from lib import utils  # needs bitbake lib dir in path, too
        from lib import backport
        self.bb = bb
        self.bb.tinfoil = bb.tinfoil
        self.utils = utils
        self.generatePkgDepTreeData = backport.generatePkgDepTreeData
        self.target = target
        self.outfile = outfile
        self.tf = self.setup_tinfoil(tracking=True)
        self.images = sorted(self.utils.get_images_from_cache(self.tf.cooker))

    def validate_target(self):
        if not self.utils.is_valid_image(self.tf.cooker, self.target):
            return False
        return True

    def set_target(self, img):
        self.target = img
        self.validate_target()

    def shutdown(self):
        if self.tf:
            self.tf.shutdown()

    def _generate_depgraph(self):
        return self.tf.cooker.generatePkgDepTreeData([self.target], 'build')

    def setup_tinfoil(self, tracking=False):
        tinfoil = self.bb.tinfoil.Tinfoil(tracking=tracking)
        options = self.bb.tinfoil.TinfoilConfigParameters(parse_only=True, dry_run=True)
        tinfoil.config.setConfigParameters(options)
        tinfoil.cooker.featureset.setFeature(self.bb.cooker.CookerFeatures.HOB_EXTRA_CACHES)

        tinfoil.prepare()

        # this part is from bitbake/lib/bblayers:
        tinfoil.bblayers = (tinfoil.config_data.getVar('BBLAYERS', True) or "").split()
        layerconfs = tinfoil.config_data.varhistory.get_variable_items_files(
            'BBFILE_COLLECTIONS', tinfoil.config_data)
        tinfoil.cooker.bbfile_collections = {
            layer: os.path.dirname(os.path.dirname(path))
            for layer, path in layerconfs.iteritems()}

        # on this instance, use backported generatePkgDepTreeData()
        tinfoil.cooker.generatePkgDepTreeData = \
            self.generatePkgDepTreeData.__get__(tinfoil.cooker, tinfoil.cooker.__class__)

        return tinfoil

    def generate(self):
        distro = self.tf.config_data.get('DISTRO_CODENAME') or \
                 self.tf.config_data.get('DISTRO_NAME')

        layer_info = {lyr['name']: self.layer_dict(lyr)
                      for lyr in self.utils.get_layer_info(self.tf.cooker)}

        whitelist = self.utils.get_cve_whitelist(self.tf.cooker)

        manifest = dict(date=datetime.utcnow().isoformat(),
                        distro=distro,
                        distro_version=self.tf.config_data.get('DISTRO_VERSION'),
                        image=self.target,
                        layers=layer_info,
                        machine=self.tf.config_data.get('MACHINE'),
                        packages=dict(),
                        manifest_version=self.manifest_version,
                        whitelist=whitelist)

        latest_versions, preferred_versions = self.bb.providers.findProviders(
                                                  self.tf.config_data,
                                                  self.tf.cooker_data,
                                                  self.tf.cooker_data.pkg_pn)
        depgraph = self._generate_depgraph()
        if not depgraph:
            self.shutdown()
            raise(Exception('Failed to parse recipes'))

        for p in depgraph['pn']:
            if p.endswith('-native'):
                continue

            pref = preferred_versions[p]
            realfn = self.bb.cache.Cache.virtualfn2realfn(pref[1])
            preffile = realfn[0]
            # We only display once per recipe, we should prefer non extended
            # versions of the recipe if present (so e.g. in OpenEmbedded, openssl
            # rather than nativesdk-openssl which would otherwise sort first).
            if realfn[1] and realfn[0] in self.tf.cooker_data.pkg_fn:
                continue

            lyr = self.utils.get_file_layer(self.tf.cooker, preffile)
            p_version = str("%s" % (pref[0][1]))
            info = layer_info.get(lyr)
            branch = info.get('branch', 'UNKNOWN')
            manifest['packages'][p] = dict(version=p_version,
                                           layer=lyr,
                                           branch=branch)

            appendfiles = self.tf.cooker.collection.get_file_appends(preffile)
            recipe_info = self.bb.cache.Cache.loadDataFull(pref[1], appendfiles,
                                                           self.tf.config_data)

            cve_product = recipe_info.get('CVE_PRODUCT')
            if not cve_product and self.utils.is_kernel(self.tf.cooker, p):
                cve_product = 'linux_kernel'
            if cve_product:
                manifest['packages'][p]['cve_product'] = cve_product
            cve_version = p_version.split("+git")[0]
            if cve_version != p_version:
                manifest['packages'][p]['cve_version'] = cve_version

            patches = self.utils.get_patch_list(recipe_info)
            if patches:
                manifest['packages'][p]['patches'] = patches

            # Recipes like glibc have a version number but really build at
            # some revision past it from git
            srcrev = recipe_info.getVar('SRCREV', True)
            if srcrev != 'INVALID':
                manifest['packages'][p]['srcrev'] = srcrev

        s = json.dumps(manifest, indent=2, sort_keys=True)
        if self.outfile:
            with open(self.outfile, "w") as f:
                f.write(s)
            print('Done. Wrote manifest to "%s"' % self.outfile)
        return s

    def layer_dict(self, lyr):
        # Keep a subset of all the layer info
        return dict(remote=lyr['remote'], rev=lyr['revision'],
                    branch=lyr['branch'], path=lyr['path'])


class MenuSelect(object):
    def __init__(self, title, options):
        self.title = title
        self.options = options
        self.selected = None
        self.highlighted = 0
        self.max_row = 10
        self.top_line = 0
        self.down_keys = [curses.KEY_DOWN, curses.KEY_RIGHT]
        self.up_keys = [curses.KEY_UP, curses.KEY_LEFT]
        self.select_keys = [ord('\n'), ord(' ')]

    def show_menu(self):
        curses.wrapper(self._get_selection)

    def _pad_options(self, max_width):
        for i, o in enumerate(self.options):
            self.options[i] = '{option:^{mw}.{mw}}'.format(option=o.strip(),
                                                           mw=max_width)

    def _print_option(self, n, y_offset, win=None):
        if win is None:
            win = self.screen

        y = y_offset + n

        if n == self.highlighted:
            style = curses.A_REVERSE
        else:
            style = curses.A_NORMAL

        self._print_middle(win,
                           0, win.getmaxyx()[1],
                           y, self.options[n+self.top_line],
                           style)

        # incase setting cursor invisible failed, keep it at beginning of
        # highlighted line
        hi_y = y_offset + self.highlighted
        win.move(hi_y, ((win.getmaxyx()[1] - len(self.options[n])) // 2) - 1)

    def _print_middle(self, win, start_x, width, start_y, s, style):
        if win is None:
            win = self.screen

        y, x = win.getyx()
        if start_x != 0:
            x = start_x
        if start_y != 0:
            y = start_y
        if width == 0:
            width = 80

        length = len(s)
        temp = (width - length) // 2
        x = start_x + temp
        win.addstr(y, x, s, style)
        win.refresh()

    # move cursor/highlight and scroll window by m lines
    def _move(self, m):
        up = m < 0
        down = not up
        new_line = self.highlighted + m

        # for scrolling, we change what the top line is, but on what condition
        # depends on what is highlighted and which key is pressed
        if up and (self.highlighted == 0) and (self.top_line != 0):
            self.top_line += m
            return
        elif (down and (new_line == self.max_row)
                   and ((self.top_line + self.max_row) != len(self.options))):
            self.top_line += m
            return

        # move cursor (without scrolling list)
        if up and (self.top_line != 0 or self.highlighted != 0):
            self.highlighted = new_line
        elif (down
              and ((self.top_line + self.highlighted + 1) != len(self.options))
              and (self.highlighted != self.max_row)):
            self.highlighted = new_line

    def _draw_win(self, win):
        win.erase()

        # titles
        self._print_middle(win, 0, self.win_w, 1,
                           '{t:^.{mw}}'.format(t=self.title['title'],
                                               mw=self.win_w),
                           curses.A_BOLD)
        self._print_middle(win, 0, self.win_w, 2,
                           '{t:^.{mw}}'.format(t=self.title['subtitle'],
                                               mw=self.win_w),
                           curses.A_NORMAL)
        win.hline(3, 1, curses.ACS_HLINE, self.win_w - 2)

        # option drawing / highlighting and keypress handling
        # self.options = self.options[:win_h - 7]
        top = self.top_line
        bottom = self.top_line + self.max_row
        for i in range(bottom - top):
            self._print_option(i, 5, win)
        win.refresh()

    def _get_selection(self, screen):
        self.screen = screen
        if curses.has_colors():
            curses.init_pair(1, curses.COLOR_BLACK, curses.COLOR_BLUE)
            curses.init_pair(2, curses.COLOR_BLACK, curses.COLOR_WHITE)
            self.screen.bkgd(' ', curses.color_pair(1))

        try:
            curses.curs_set(0)  # Hide cursor if term supports it
        except CursesError:
            pass

        # Set up the selection window
        self.max_y, self.max_x = self.screen.getmaxyx()
        if self.max_y < 16:
            raise Exception('Window is too small! (must be >= 16 lines)')
        self.win_w = 75 if self.max_x >= 80 else self.max_x - 2
        self.win_h = 16
        start_row = (self.max_y // 2) - (self.win_h // 2)
        start_col = (self.max_x // 2) - (self.win_w // 2)

        # pad options with spaces & center
        self._pad_options(int(0.8 * self.win_w))

        # shadow under the menu
        if curses.has_colors():
            shadow = self.screen.subwin(self.win_h, self.win_w,
                                        start_row+1, start_col+1)
            shadow.bkgd(' ', curses.color_pair(0))

        win = self.screen.subwin(self.win_h, self.win_w, start_row, start_col)
        if curses.has_colors():
            win.bkgd(' ', curses.color_pair(2))
        else:
            win.bkgd(' ', curses.A_REVERSE)

        # footer
        copyright = ('Copyright (C) Timesys Corporation 2018 -- '
                     'https://www.timesys.com')
        self._print_middle(self.screen, 0,
                           self.max_x, self.max_y - 3,
                           '{c:^.{mw}}'.format(c=copyright, mw=self.win_w),
                           curses.A_BOLD)

        key = None
        while key not in self.select_keys:
            self._draw_win(win)

            key = self.screen.getch()
            if key in self.down_keys:
                self._move(1)
            elif key in self.up_keys:
                self._move(-1)

        # when select key pressed, store highlighted option
        self.selected = self.options[self.top_line + self.highlighted].strip()


if __name__ == '__main__':
    # expects bitbake dir, target image, output filename
    broot = sys.argv[1]
    target = sys.argv[2]
    ofile = sys.argv[3]

    try:
        im = ImageManifest(broot, target, ofile)
        if not im.validate_target():
            imagelist = '\n'.join(im.images)
            im.tf.logger.error('Unable to find image: %s\n' % target)
            im.tf.logger.error('Please select an image from the following '
                               'list:\n\n%s\n', imagelist)
            sys.exit(1)

        im.generate()
        im.shutdown()
    except Exception as e:
        print('Error: %s' % e)
