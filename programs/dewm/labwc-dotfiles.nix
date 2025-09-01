
{ pkgs, lib, config, ...}: 
let cfg = config.labwc-dotfiles; in {
  options = {
    labwc-dotfiles.enable = lib.mkEnableOption "Enable Module";
  };

  config = lib.mkIf cfg.enable {
home.file.".config/labwc/rc.xml".text = '' <?xml version="1.0"?>
<!--
  This is a very simple config file with many options missing. For a complete
  set of options with comments, see docs/rc.xml.all
-->
<labwc_config>
  <theme>
    <name>Dracula</name>
    <cornerRadius>0</cornerRadius>
    <font name="sans" size="10"/>
  </theme>
  <keyboard>
    <default/>
    <!-- Use a different terminal emulator -->
    <keybind key="W-Return">
      <action name="Execute" command="foot"/>
    </keybind>
    <!--
      Remove a previously defined keybind
      A shorter alternative is <keybind key="W-F4" />
    -->
    <keybind key="C-l">
      <action name="GoToDesktop" to="left" wrap="yes"/>
    </keybind>
    <keybind key="C-r">
      <action name="GoToDesktop" to="right" wrap="yes"/>
    </keybind>
  </keyboard>
  <mouse>
    <default/>
    <!-- Show a custom menu on desktop right click -->
    <context name="Root">
      <mousebind button="Right" action="Press">
        <action name="ShowMenu" menu="some-custom-menu"/>
      </mousebind>
      <mousebind button="Right" action="Press">
        <action name="Execute" command="bash -c 'wofi --show=drun -p Program'"/>
      </mousebind>
      <mousebind button="Middle" action="Press">
        <action name="Execute" command="bash -c 'killall wofi'"/>
      </mousebind>
    </context>
  </mouse>
  <libinput>
    <device>
      <naturalScroll>no</naturalScroll>
    </device>
  </libinput>
</labwc_config>
 '';
home.file.".config/labwc/environment".text = '' 
 XDG_CURRENT_DESKTOP=wlroots
XKB_DEFAULT_LAYOUT=us,ru
XCURSOR_THEME=Qogir
XCURSOR_SIZE=24
 XKB_DEFAULT_OPTIONS=grp:alt_shift_toggle
 MOZ_ENABLE_WAYLAND=1
'';
home.file.".config/labwc/autostart".text = ''
swaybg  >/dev/null 2>&1 &
sfwbar >/dev/null 2>&1 &
lavalauncher >/dev/null 2>&1 &
kanshi >/dev/null 2>&1 &
dunst >/dev/null 2>&1 &
 '';
home.file.".config/labwc/menu.xml".text = ''
 <?xml version="1.0" encoding="UTF-8"?>

<openbox_menu>
<!-- Note: for localization support of menu items "client-menu" has to be removed here -->
<menu id="client-menu">
  <item label="Minimize">
    <action name="Iconify" />
  </item>
  <item label="Maximize">
    <action name="ToggleMaximize" />
  </item>
  <item label="Fullscreen">
    <action name="ToggleFullscreen" />
  </item>
  <item label="Roll up/down">
    <action name="ToggleShade" />
  </item>
  <item label="Decorations">
    <action name="ToggleDecorations" />
  </item>
  <item label="Always on Top">
    <action name="ToggleAlwaysOnTop" />
  </item>
  <!--
    Any menu with the id "workspaces" will be hidden
    if there is only a single workspace available.
  -->
  <menu id="workspaces" label="Workspace">
    <item label="Move left">
      <action name="SendToDesktop" to="left" />
    </item>
    <item label="Move right">
      <action name="SendToDesktop" to="right" />
    </item>
    <separator />
    <item label="Always on Visible Workspace">
      <action name="ToggleOmnipresent" />
    </item>
  </menu>
  <item label="Close">
    <action name="Close" />
  </item>
</menu>

<menu id="root-menu">
  <item label="Web browser">
    <action name="Execute" command="firefox" />
  </item>
  <item label="Terminal">
    <action name="Execute" command="alacritty" />
  </item>
  <item label="Reconfigure">
    <action name="Reconfigure" />
  </item>
  <item label="Exit">
    <action name="Exit" />
  </item>
  <item label="Poweroff">
    <action name="Execute" command="systemctl -i poweroff" />
  </item>
  <item label="reboot">
    <action name="Execute" command="systemctl -i reboot" />
  </item>
</menu>

</openbox_menu>
 '';
home.file.".config/labwc/themerc".text = '' # general
border.width: 1
padding.height: 3

# The following options has no default, but fallbacks back to
# font-height + 2x padding.height if not set.
# titlebar.height:

# window border
window.active.border.color: #8B00FF
window.inactive.border.color: #9400D3

# ToggleKeybinds status indicator
window.active.indicator.toggled-keybind.color: #7b00ff

# window titlebar background
window.active.title.bg.color: #6e6b68
window.inactive.title.bg.color: #b5b4b3

# window titlebar text
window.active.label.text.color: #000000
window.inactive.label.text.color: #000000
window.label.text.justify: left

# window buttons
window.active.button.unpressed.image.color: #000000
window.inactive.button.unpressed.image.color: #000000

# Note that "menu", "iconify", "max", "close" buttons colors can be defined
# individually by inserting the type after the button node, for example:
#
#     window.active.button.iconify.unpressed.image.color: #333333

# menu
menu.overlap.x: 0
menu.overlap.y: 0
menu.width.min: 20
menu.width.max: 200
menu.items.bg.color: #fcfbfa
menu.items.text.color: #000000
menu.items.active.bg.color: #e1dedb
menu.items.active.text.color: #000000
menu.items.padding.x: 7
menu.items.padding.y: 4
menu.separator.width: 1
menu.separator.padding.width: 6
menu.separator.padding.height: 3
menu.separator.color: #888888

# on screen display (window-cycle dialog)
osd.bg.color: #dddda6
osd.border.color: #000000
osd.border.width: 1
osd.label.text.color: #000000

osd.window-switcher.width: 600
osd.window-switcher.padding: 4
osd.window-switcher.item.padding.x: 10
osd.window-switcher.item.padding.y: 1
osd.window-switcher.item.active.border.width: 2

osd.workspace-switcher.boxes.width: 20
osd.workspace-switcher.boxes.height: 20
 '';

home.file.".config/sfwbar/config".text = '' panel {
  position = top
  layer = top
  theme = "black"

  modules-left = [ "workspaces" ]
  modules-center = [ "clock" ]
  modules-right = [ "wifi" "bluetooth" "notifications" ]
}

clock {
  format = "%H:%M"
}

wifi {
  format-connected = "  %essid% (%signal%%)"
  format-disconnected = "睊 Disconnected"
}

bluetooth {
  format-connected = " %name%"
  format-off = " Off"
}

notifications {
  backend = "dunst"
  clear-all = 1
}
 '';
home.file.".config/lavalauncher/config.conf".text = '' bar {
  position = left
  exclusive-zone = true
  autohide = false
  icon-size = 48
}

button {
  image = /usr/share/icons/hicolor/48x48/apps/firefox.png
  command = firefox
}

button {
  image = /usr/share/icons/hicolor/48x48/apps/alacritty.png
  command = alacritty
}

button {
  image = /usr/share/icons/hicolor/48x48/apps/nemo.png
  command = nemo
}

button {
  image = /usr/share/icons/hicolor/48x48/apps/vesktop.png
  command = vesktop
}
 '';
home.file.".config/kanshi/config".text = ''
   profile {
	output DVI-D-1 enable mode 1360x768 position 1452,0
	output HDMI-A-1 mode 1366x768 position 87,678 } '';
  };
  }
