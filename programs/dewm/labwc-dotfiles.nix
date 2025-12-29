
{ pkgs, lib, config, ...}: 
let cfg = config.labwc-dotfiles; in {
  options = {
    labwc-dotfiles.enable = lib.mkEnableOption "Enable Module";
  };

  config = lib.mkIf cfg.enable {
home.file.".config/labwc/rc.xml.all".text = ''
<?xml version="1.0"?>

<!--
  This file contains all supported config elements & attributes with
  default values.

  Values for [yes|no] can be replaced by [true|false], [on|off] or [1|0].
-->

<labwc_config>

  <core>
    <decoration>server</decoration>
    <maximizedDecoration>titlebar</maximizedDecoration>
    <gap>0</gap>
    <adaptiveSync>no</adaptiveSync>
    <allowTearing>no</allowTearing>
    <autoEnableOutputs>yes</autoEnableOutputs>
    <reuseOutputMode>no</reuseOutputMode>
    <xwaylandPersistence>no</xwaylandPersistence>
    <primarySelection>yes</primarySelection>
  </core>

  <placement>
    <policy>cascade</policy>
    <!--
      When <placement><policy> is "cascade", the offset for cascading new
      windows can be overwritten like this:
      <cascadeOffset x="40" y="30" />
    -->
  </placement>

  <!-- <font><theme> can be defined without an attribute to set all places -->
  <theme>
    <name></name>
    <icon></icon>
    <fallbackAppIcon>labwc</fallbackAppIcon>
    <titlebar>
      <layout>icon:iconify,max,close</layout>
      <showTitle>yes</showTitle>
    </titlebar>
    <cornerRadius>8</cornerRadius>
    <keepBorder>yes</keepBorder>
    <dropShadows>no</dropShadows>
    <dropShadowsOnTiled>no</dropShadowsOnTiled>
    <font place="ActiveWindow">
      <name>sans</name>
      <size>10</size>
      <slant>normal</slant>
      <weight>normal</weight>
    </font>
    <font place="InactiveWindow">
      <name>sans</name>
      <size>10</size>
      <slant>normal</slant>
      <weight>normal</weight>
    </font>
    <font place="MenuHeader">
      <name>sans</name>
      <size>10</size>
      <slant>normal</slant>
      <weight>normal</weight>
    </font>
    <font place="MenuItem">
      <name>sans</name>
      <size>10</size>
      <slant>normal</slant>
      <weight>normal</weight>
    </font>
    <font place="OnScreenDisplay">
      <name>sans</name>
      <size>10</size>
      <slant>normal</slant>
      <weight>normal</weight>
    </font>
  </theme>

  <windowSwitcher show="yes" style="classic" preview="yes" outlines="yes" allWorkspaces="no">
    <fields>
      <field content="icon" width="5%" />
      <field content="desktop_entry_name" width="30%" />
      <field content="title" width="65%" />
      <!--
        Just as for window-rules, you can use 'identifier' or
        'trimmed_identifier' to show the app_id for native wayland clients or
        WM_CLASS for XWayland clients.

        <field content="trimmed_identifier" width="65%" />
      -->
    </fields>
  </windowSwitcher>

  <!--
    Many other kinds of content are supported in the window switcher like below.
    Some contents are fixed-length and others are variable-length.
    See "man 5 labwc-config" for details.

    <windowSwitcher show="yes" preview="no" outlines="no" allWorkspaces="yes">
      <fields>
        <field content="workspace" width="5%" />
        <field content="state" width="3%" />
        <field content="type_short" width="3%" />
        <field content="output" width="9%" />
        <field content="identifier" width="30%" />
        <field content="title" width="50%" />
      </fields>
    </windowSwitcher>

    custom format - (introduced in 0.7.2)
    It allows one to replace all the above "fields" with one line, using a
    printf style format. For field explanations, see "man 5 labwc-config".

    The example below would print "foobar", then type of window (wayland, X),
    then state of window (M/m/F), then output (shows if more than 1 active),
    then workspace name, then identifier/app-id, then the window title.
    It uses 100% of OSD window width.

    <windowSwitcher show="yes" preview="no" outlines="no" allWorkspaces="yes">
      <fields>
        <field content="custom" format="foobar %b %3s %-10o %-20W %-10i %t" width="100%" />
      </fields>
    </windowSwitcher>
  -->

  <!-- edge strength is in pixels -->
  <resistance>
    <screenEdgeStrength>20</screenEdgeStrength>
    <windowEdgeStrength>20</windowEdgeStrength>
    <!-- resistance for maximized/tiled windows -->
    <unSnapThreshold>20</unSnapThreshold>
    <!-- resistance for vertically/horizontally maximized windows -->
    <unMaximizeThreshold>150</unMaximizeThreshold>
  </resistance>

  <resize>
    <!-- Show a simple resize and move indicator -->
    <popupShow>Never</popupShow>
    <!-- Let client redraw its contents while resizing -->
    <drawContents>yes</drawContents>
    <!-- Borders are effectively 8 pixels wide regardless of visual appearance -->
    <minimumArea>8</minimumArea>

    <!--
      Set cornerRange to a positive value to increase the size of corner
      regions for mouse actions and diagonal window resizing. When omitted,
      the default size of the corner region is half of the titlebar height.

      <cornerRange>8</cornerRange>
    -->
  </resize>

  <focus>
    <followMouse>no</followMouse>
    <followMouseRequiresMovement>yes</followMouseRequiresMovement>
    <raiseOnFocus>no</raiseOnFocus>
  </focus>

  <snapping>
    <!-- Set range to 0 to disable window snapping completely -->
    <range>10</range>
    <cornerRange>50</cornerRange>
    <overlay enabled="yes">
      <delay inner="500" outer="500" />
    </overlay>
    <topMaximize>yes</topMaximize>
    <notifyClient>always</notifyClient>
  </snapping>

  <!--
    Workspaces can be configured like this:
    <desktops>
      <popupTime>1000</popupTime>
      <names>
        <name>Workspace 1</name>
        <name>Workspace 2</name>
        <name>Workspace 3</name>
        <name>Workspace 4</name>
      </names>
    </desktops>

    Or it can also be configured like this:
    <desktops number="4" />

    Or like this:
    <desktops>
      <popupTime>500</popupTime>
      <number>5</number>
      <prefix>ws</prefix>
    </desktops>

    Or:
    <desktops number="4" popupTime="500" prefix="ws" />

    popupTime defaults to 1000 so could be left out.
    Set to 0 to completely disable the workspace OSD.

    prefix defaults to "Workspace" when using number instead of names.

    Use GoToDesktop left | right to switch workspaces.
    Use SendToDesktop left | right to move windows.
    See man labwc-actions for further information.
  -->
  <desktops>
    <popupTime>1000</popupTime>
    <names>
      <name>Default</name>
    </names>
  </desktops>

  <!--
    <margin> can be used to reserve space where new/maximized/tiled
    windows will not be placed. Clients using layer-shell protocol reserve
    space automatically, so <margin> is only intended for other, specialist
    cases.

    If output is left empty, the margin will be applied to all outputs.

    <margin top="" bottom="" left="" right="" output="" />
  -->

  <!-- Percent based regions based on output usable area, % char is required -->
  <!--
    <regions>
      <region name="top-left"     x="0%"  y="0%"  height="50%"  width="50%"  />
      <region name="top"          x="0%"  y="0%"  height="50%"  width="100%" />
      <region name="top-right"    x="50%" y="0%"  height="50%"  width="50%"  />
      <region name="left"         x="0%"  y="0%"  height="100%" width="50%"  />
      <region name="center"       x="10%" y="10%" height="80%"  width="80%"  />
      <region name="right"        x="50%" y="0%"  height="100%" width="50%"  />
      <region name="bottom-left"  x="0%"  y="50%" height="50%"  width="50%"  />
      <region name="bottom"       x="0%"  y="50%" height="50%"  width="100%" />
      <region name="bottom-right" x="50%" y="50%" height="50%"  width="50%"  />
    </regions>
  -->

  <!--
    Keybind actions are specified in labwc-actions(5)
    The following keybind modifiers are supported:
      W - window/super/logo
      A - alt
      C - ctrl
      S - shift

    Use <keyboard><default /> to load all the default keybinds (those listed
    below). If the default keybinds are largely what you want, a sensible
    approach could be to start the <keyboard> section with a <default />
    element, and then (re-)define any special binds you need such as launching
    your favourite terminal or application launcher. See rc.xml for an example.
  -->
  <keyboard>
    <!--
      # Numlock is not set by default
      <numlock>on|off</numlock>
    -->
    <layoutScope>global</layoutScope>
    <repeatRate>25</repeatRate>
    <repeatDelay>600</repeatDelay>
    <keybind key="A-Tab">
      <action name="NextWindow" />
    </keybind>
    <keybind key="A-S-Tab">
      <action name="PreviousWindow" />
    </keybind>
    <keybind key="W-Return">
      <action name="Execute" command="lab-sensible-terminal" />
    </keybind>
    <keybind key="A-F4">
      <action name="Close" />
    </keybind>
    <keybind key="W-a">
      <action name="ToggleMaximize" />
    </keybind>
    <keybind key="W-Left">
      <action name="SnapToEdge" direction="left" />
    </keybind>
    <keybind key="W-Right">
      <action name="SnapToEdge" direction="right" />
    </keybind>
    <keybind key="W-Up">
      <action name="SnapToEdge" direction="up" />
    </keybind>
    <keybind key="W-Down">
      <action name="SnapToEdge" direction="down" />
    </keybind>
    <keybind key="A-Space">
      <action name="ShowMenu" menu="client-menu" atCursor="no" />
    </keybind>
    <keybind key="XF86_AudioLowerVolume">
      <action name="Execute" command="amixer sset Master 5%-" />
    </keybind>
    <keybind key="XF86_AudioRaiseVolume">
      <action name="Execute" command="amixer sset Master 5%+" />
    </keybind>
    <keybind key="XF86_AudioMute">
      <action name="Execute" command="amixer sset Master toggle" />
    </keybind>
    <keybind key="XF86_MonBrightnessUp">
      <action name="Execute" command="brightnessctl set +10%" />
    </keybind>
    <keybind key="XF86_MonBrightnessDown">
      <action name="Execute" command="brightnessctl set 10%-" />
    </keybind>
  <!-- SnapToRegion via W-Numpad -->
  <!--
    <keybind key="W-KP_7">
      <action name="SnapToRegion" region="top-left" />
    </keybind>
    <keybind key="W-KP_8">
      <action name="SnapToRegion" region="top" />
    </keybind>
    <keybind key="W-KP_9">
      <action name="SnapToRegion" region="top-right" />
    </keybind>
    <keybind key="W-KP_4">
      <action name="SnapToRegion" region="left" />
    </keybind>
    <keybind key="W-KP_5">
      <action name="SnapToRegion" region="center" />
    </keybind>
    <keybind key="W-KP_6">
      <action name="SnapToRegion" region="right" />
    </keybind>
    <keybind key="W-KP_1">
      <action name="SnapToRegion" region="bottom-left" />
    </keybind>
    <keybind key="W-KP_2">
      <action name="SnapToRegion" region="bottom" />
    </keybind>
    <keybind key="W-KP_3">
      <action name="SnapToRegion" region="bottom-right" />
    </keybind>
  -->
  <!-- keybind for client-list-combined-menu - will center in middle of screen -->
  <!--
    <keybind key="W-Space">
      <action name="ShowMenu" menu="client-list-combined-menu" />
      <position>
        <x>center</x>
        <y>center</y>
      </position>
    </keybind>
  -->
  </keyboard>

  <!--
    Multiple <mousebind> can exist within one <context>
    Multiple <actions> can exist within one <mousebind>

    Use <mouse><default /> to load all the default mousebinds (those listed
    below). If the default mousebinds are largely what you want, a sensible
    approach could be to start the <mouse> section with a <default />
    element, and then (re-)define any special binds you need such as launching
    a custom menu when right-clicking on your desktop. See rc.xml for an
    example.
  -->
  <mouse>

    <!-- time is in ms -->
    <doubleClickTime>500</doubleClickTime>

    <context name="Frame">
      <mousebind button="W-Left" action="Press">
        <action name="Focus" />
        <action name="Raise" />
      </mousebind>
      <mousebind button="W-Left" action="Drag">
        <action name="Move" />
      </mousebind>
      <mousebind button="W-Right" action="Press">
        <action name="Focus" />
        <action name="Raise" />
      </mousebind>
      <mousebind button="W-Right" action="Drag">
        <action name="Resize" />
      </mousebind>
    </context>

    <context name="Border">
      <mousebind button="Left" action="Press">
        <action name="Focus" />
        <action name="Raise" />
      </mousebind>
      <mousebind button="Left" action="Drag">
        <action name="Resize" />
      </mousebind>
    </context>

    <context name="TitleBar">
      <mousebind button="Left" action="Press">
        <action name="Focus" />
        <action name="Raise" />
      </mousebind>
      <mousebind button="Right" action="Click">
        <action name="Focus" />
        <action name="Raise" />
      </mousebind>
      <mousebind direction="Up" action="Scroll">
        <action name="Unshade" />
        <action name="Focus" />
      </mousebind>
      <mousebind direction="Down" action="Scroll">
        <action name="Unfocus" />
        <action name="Shade" />
      </mousebind>
    </context>

    <context name="Title">
      <mousebind button="Left" action="Drag">
        <action name="Move" />
      </mousebind>
      <mousebind button="Left" action="DoubleClick">
        <action name="ToggleMaximize" />
      </mousebind>
      <mousebind button="Right" action="Click">
        <action name="ShowMenu" menu="client-menu" />
      </mousebind>
    </context>

    <context name="Maximize">
      <mousebind button="Left" action="Click">
        <action name="ToggleMaximize" />
      </mousebind>
      <mousebind button="Right" action="Click">
        <action name="ToggleMaximize" direction="horizontal" />
      </mousebind>
      <mousebind button="Middle" action="Click">
        <action name="ToggleMaximize" direction="vertical" />
      </mousebind>
    </context>

    <context name="WindowMenu">
      <mousebind button="Left" action="Click">
        <action name="ShowMenu" menu="client-menu" atCursor="no" />
      </mousebind>
      <mousebind button="Right" action="Click">
        <action name="ShowMenu" menu="client-menu" atCursor="no" />
      </mousebind>
    </context>

    <context name="Icon">
      <mousebind button="Left" action="Click">
        <action name="ShowMenu" menu="client-menu" atCursor="no" />
      </mousebind>
      <mousebind button="Right" action="Click">
        <action name="ShowMenu" menu="client-menu" atCursor="no" />
      </mousebind>
    </context>

    <context name="Shade">
      <mousebind button="Left" action="Click">
        <action name="ToggleShade" />
      </mousebind>
    </context>

    <context name="AllDesktops">
      <mousebind button="Left" action="Click">
        <action name="ToggleOmnipresent" />
      </mousebind>
    </context>

    <context name="Iconify">
      <mousebind button="Left" action="Click">
        <action name="Iconify" />
      </mousebind>
    </context>

    <context name="Close">
      <mousebind button="Left" action="Click">
        <action name="Close" />
      </mousebind>
    </context>

    <context name="Client">
      <mousebind button="Left" action="Press">
        <action name="Focus" />
        <action name="Raise" />
      </mousebind>
      <mousebind button="Middle" action="Press">
        <action name="Focus" />
        <action name="Raise" />
      </mousebind>
      <mousebind button="Right" action="Press">
        <action name="Focus" />
        <action name="Raise" />
      </mousebind>
    </context>

    <context name="Root">
      <mousebind button="Left" action="Press">
        <action name="ShowMenu" menu="root-menu" />
      </mousebind>
      <mousebind button="Right" action="Press">
        <action name="ShowMenu" menu="root-menu" />
      </mousebind>
      <mousebind button="Middle" action="Press">
        <action name="ShowMenu" menu="root-menu" />
        <!-- openbox default, swap with above line to activate -->
        <!-- <action name="ShowMenu" menu="client-list-combined-menu" /> -->
      </mousebind>
      <mousebind direction="Up" action="Scroll">
        <action name="GoToDesktop" to="left" wrap="yes" />
      </mousebind>
      <mousebind direction="Down" action="Scroll">
        <action name="GoToDesktop" to="right" wrap="yes" />
      </mousebind>
    </context>

  </mouse>

  <!--
    A touch configuration can be bound to a specific device. If device
    name is left empty, the touch configuration applies to all touch
    devices or functions as a fallback. Multiple touch configurations
    can exist.
    See the libinput device section for obtaining the device names.

    Direct cursor movement to a specified output. If the compositor is
    running in nested mode, this does not take effect.

    If mouseEmulation is enabled, all touch up/down/motion events are
    translated to mouse button and motion events.
  -->
  <touch deviceName="" mapToOutput="" mouseEmulation="no"/>

  <!--
    The tablet cursor movement can be restricted to a single output.
    If output is left empty or the output does not exists, the tablet
    will span all outputs.

    The tablet orientation can be changed in 90 degree steps, thus
    *rotate* can be set to [0|90|180|270]. Rotation will be applied
    after applying tablet area transformation.

    The active tablet area can be specified by setting the *top*/*left*
    coordinate (in mm) and/or *width*/*height* (in mm). If width or
    height are omitted or default (0.0), width/height will be set to
    the remaining width/height seen from top/left.

    The tablet can be forced to always use mouse emulation. This prevents
    tablet specific restrictions, e.g. no support for drag&drop, but also
    omits tablet specific features like reporting pen pressure.

    Pen buttons emulate regular mouse buttons. The pen *button* can be any
    of [Stylus|Stylus2|Stylus3] and can be mapped to mouse buttons
    [Right|Middle|Side]. Tablet pad buttons [Pad|Pad2|Pad3|..|Pad9] also
    emulate regular mouse buttons and can be mapped to any mouse button.
    When using mouse emulation, the pen tip [tip] and the stylus buttons
    can be set to any available mouse button [Left|Right|Middle|..|Task].
  -->
  <tablet mapToOutput="" rotate="0" mouseEmulation="no">
    <!-- Active area dimensions are in mm -->
    <area top="0.0" left="0.0" width="0.0" height="0.0" />
    <map button="Tip" to="Left" />
    <map button="Stylus" to="Right" />
    <map button="Stylus2" to="Middle" />
  </tablet>

  <!--
    All tablet tools, except of type mouse and lens, use absolute
    positioning by default. The *motion* attribute allows to set tools
    to relative motion instead. When using relative motion,
    *relativeMotionSensitivity* controls the speed of the cursor. Using
    a value lower than 1.0 decreases the speed, using a value greater than
    1.0 increases the speed of the cursor.
  -->
  <tabletTool motion="absolute" relativeMotionSensitivity="1.0" />

  <!--
    The *category* attribute is optional and can be set to touch, touchpad,
    non-touch, default or the name of a device. You can obtain device names by
    running *libinput list-devices* as root or member of the input group.

    Tap is set to *yes* by default. All others are left blank in order to use
    device defaults.

    All values are [yes|no] except for:
      - pointerSpeed [-1.0 to 1.0]
      - accelProfile [flat|adaptive]
      - tapButtonMap [lrm|lmr]
      - clickMethod [none|buttonAreas|clickfinger]
      - sendEventsMode [yes|no|disabledOnExternalMouse]
      - calibrationMatrix [six float values split by space]
      - scrollFactor [float]
   
    The following <libinput>...</libinput> block may not be complete for
    your requirements. Default values are device specific. Only set an option
    if you require to override the default. Valid values must be inserted.

  -->

  <libinput>
    <device category="default">
      <naturalScroll></naturalScroll>
      <leftHanded></leftHanded>
      <pointerSpeed></pointerSpeed>
      <accelProfile></accelProfile>
      <tap>yes</tap>
      <tapButtonMap></tapButtonMap>
      <tapAndDrag></tapAndDrag>
      <dragLock></dragLock>
      <threeFingerDrag></threeFingerDrag>
      <middleEmulation></middleEmulation>
      <disableWhileTyping></disableWhileTyping>
      <clickMethod></clickMethod>
      <scrollMethod></scrollMethod>
      <sendEventsMode></sendEventsMode>
      <calibrationMatrix></calibrationMatrix>
      <scrollFactor>1.0</scrollFactor>
    </device>
  </libinput>

  <!--
    # Window Rules
    #   - Criteria can consist of 'identifier', 'title', 'sandboxEngine' or
    #     'sandboxAppId'. AND logic is used when multiple options are specified.
    #   - 'identifier' relates to app_id for native Wayland windows and
    #     WM_CLASS for XWayland clients.
    #   - Criteria can also contain `matchOnce="true"` meaning that the rule
    #     must only apply to the first instance of the window with that
    #     particular 'identifier' or 'title'.
    #   - Matching is case-insensitive and is performed using shell wildcard
    #     patterns (see glob(7)) so '\*' (not between brackets) matches any string
    #     and '?' matches any single character.

    <windowRules>
      <windowRule identifier="*"><action name="Maximize"/></windowRule>
      <windowRule identifier="foo" serverDecoration="yes"/>
      <windowRule title="bar" serverDecoration="yes"/>
      <windowRule identifier="baz" title="quax" serverDecoration="yes"/>
    </windowRules>

    # Example below for `lxqt-panel` and `pcmanfm-qt \-\-desktop`
    # where 'matchOnce' is used to avoid applying rule to the panel
    # configuration window with the same 'app_id'.

    <windowRules>
      <windowRule identifier="lxqt-panel" matchOnce="true">
        <skipTaskbar>yes</skipTaskbar>
        <action name="MoveTo" x="0" y="0" />
        <action name="ToggleAlwaysOnTop"/>
      </windowRule>
      <windowRule title="pcmanfm-desktop*">
        <skipTaskbar>yes</skipTaskbar>
        <skipWindowSwitcher>yes</skipWindowSwitcher>
        <fixedPosition>yes</fixedPosition>
        <action name="MoveTo" x="0" y="0" />
        <action name="ToggleAlwaysOnBottom"/>
      </windowRule>
      <windowRule identifier="org.qutebrowser.qutebrowser">
        <action name="ResizeTo" width="1024" height="800" />
        <action name="AutoPlace"/>
      </windowRule>
    </windowRules>
  -->

  <menu>
    <ignoreButtonReleasePeriod>250</ignoreButtonReleasePeriod>
    <showIcons>yes</showIcons>
  </menu>

  <!--
    Magnifier settings
    'width' sets the width in pixels of the magnifier window.
    'height' sets the height in pixels of the magnifier window.
    'initScale' sets the initial magnification factor at boot.
    'increment' sets the amount by which the magnification factor
      changes when 'ZoomIn' or 'ZoomOut' are called.
    'useFilter' sets whether to use a bilinear filter on the magnified
      output or simply to take nearest pixel.
  -->
  <magnifier>
    <width>400</width>
    <height>400</height>
    <initScale>2.0</initScale>
    <increment>0.2</increment>
    <useFilter>true</useFilter>
  </magnifier>

</labwc_config>
'';
home.file.".config/labwc/rc.xml".text = '' 
  <?xml version="1.0"?>
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
