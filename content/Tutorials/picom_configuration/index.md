+++
date = '2026-03-18T16:06:39+01:00'
draft = false
title = 'Picom Configuration'
categories = ["Notes", "Reference"]
tags = ["notes"]
+++


Here is a comprehensive list of many configuration parameters for picom (a popular X11 compositor) — note: the available parameters may differ slightly between versions/forks (for example, the official version vs forks with extra features). Use this as a reference and always check your version’s man-page or sample config. ([picom.app][1])

---

### General / Backend / Process behaviour

| Parameter                                                  | Description                                                                        |
| ---------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `backend`                                                  | Choose rendering backend: `"xrender"`, `"glx"`, `"xr_glx_hybrid"` etc. ([Gist][2]) |
| `config`                                                   | Path to config file (when launching via CLI) ([Linux Command Library][3])          |
| `daemon`                                                   | Whether to fork into background after initialization ([config.phundrak.com][4])    |
| `vsync`                                                    | Enable VSync to reduce tearing ([Gist][2])                                         |
| `dbus`                                                     | Enable D-Bus control interface ([config.phundrak.com][4])                          |
| `glx-no-stencil`, `glx-copy-from-front`, `glx-swap-method` | GLX-specific tuning options ([Gist][2])                                            |

---

### Shadows

| Parameter                                   | Description                                               |
| ------------------------------------------- | --------------------------------------------------------- |
| `shadow`                                    | Enable window shadows ([Gist][5])                         |
| `shadow-radius`                             | Blur radius of shadows (in pixels) ([Gist][5])            |
| `shadow-opacity`                            | Opacity (0.0-1.0) of shadows ([Gist][5])                  |
| `shadow-offset-x`, `shadow-offset-y`        | Horizontal/vertical offsets of shadows ([Gist][5])        |
| `shadow-red`, `shadow-green`, `shadow-blue` | Colour channels of shadow tint (0.0-1.0) ([Gist][5])      |
| `shadow-exclude`                            | Rules to exclude certain windows from shadows ([Gist][5]) |
| `xinerama-shadow-crop`                      | Crop shadows to monitor when using Xinerama ([Gist][5])   |

---

### Fading / Transitions

| Parameter                       | Description                                                            |
| ------------------------------- | ---------------------------------------------------------------------- |
| `fading`                        | Enable fading of windows (on open/close or opacity change) ([Gist][5]) |
| `fade-in-step`, `fade-out-step` | Increment/decrement per step of fade (opacity change) ([Gist][5])      |
| `no-fading-openclose`           | Disable fading on open/close events ([Linux Command Library][3])       |

---

### Opacity / Dim / Inactive Windows

| Parameter          | Description                                                          |
| ------------------ | -------------------------------------------------------------------- |
| `inactive-opacity` | Opacity for inactive windows (0.0-1.0) ([Linux Command Library][3])  |
| `active-opacity`   | Opacity for active (focused) windows ([Gist][2])                     |
| `opacity-rule`     | Specific rules mapping windows to an opacity value ([picom.app][1])  |
| `inactive-dim`     | Dim factor for inactive windows (makes them darker) ([picom.app][1]) |

---

### Rounded Corners / Borders

| Parameter                 | Description                                                                              |
| ------------------------- | ---------------------------------------------------------------------------------------- |
| `corner-radius`           | Radius (in pixels) for rounding window corners ([freakybyte.github.io][6])               |
| `rounded-corners-exclude` | Rules to exclude certain windows from having rounded corners ([freakybyte.github.io][6]) |
| `round-borders`           | (Some forks) number of pixels for border rounding ([Gist][5])                            |
| `round-borders-exclude`   | Rules to exclude windows from border rounding ([Gist][5])                                |

---

### Blur / Background Blur

| Parameter                 | Description                                                                                         |
| ------------------------- | --------------------------------------------------------------------------------------------------- |
| `blur-background`         | Whether to blur backgrounds of windows (semi-transparent/ARGB) ([config.phundrak.com][4])           |
| `blur-background-frame`   | Whether to blur when the frame (decoration) is transparent/varying ([config.phundrak.com][4])       |
| `blur-background-fixed`   | Use fixed strength blur rather than varying by opacity ([config.phundrak.com][4])                   |
| `blur-method`             | Method for blur: `"none"`, `"box"`, `"gaussian"`, `"dual_kawase"`, `"kernel"` etc. ([picom.app][1]) |
| `blur-size`               | Kernel size for blur (integer, depends on method) ([config.phundrak.com][4])                        |
| `blur-deviation`          | Deviation for gaussian blur method (float) ([config.phundrak.com][4])                               |
| `blur-strength`           | Strength for dual_kawase or other blur methods (integer) ([config.phundrak.com][4])                 |
| `blur-kern`               | Explicit kernel definition for “kernel” method (string) ([picom.app][1])                            |
| `blur-background-exclude` | Rules to prevent blur in certain windows ([config.phundrak.com][4])                                 |

---

### Window Rules / Matching / Conditions

| Parameter                | Description                                                                                         |
| ------------------------ | --------------------------------------------------------------------------------------------------- |
| `rules`                  | New-style list of rules `{ match = "..."; key = value; ... }` to apply on windows. ([picom.app][1]) |
| `invert-color-include`   | (Experimental) windows to invert colours ([picom.app][1])                                           |
| `crop-shadow-to-monitor` | Crop shadows for windows to monitor area via RandR ([picom.app][1])                                 |

---

### Other Miscellaneous Parameters

| Parameter                                    | Description                                                                                                |
| -------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `inactive-opacity-override`                  | Override opacity setting for inactive windows even if WM hints set something else ([picom.app][1])         |
| `mark-wmwin-focused`, `mark-ovredir-focused` | Options for how to detect active/focused windows via window manager hints ([picom.app][1])                 |
| `unredir-if-possible`                        | Unredirect full-screen/full-window windows for performance (depends on driver) ([freakybyte.github.io][6]) |
| `xdisplay-name`, `refresh-rate` (deprecated) | X display and refresh rate options (note: `refresh-rate` is deprecated) ([Reddit][7])                      |

---

### Example snippet of config

```conf
backend = "glx";
vsync = true;
shadow = true;
shadow-radius = 10;
shadow-opacity = 0.25;
corner-radius = 8;
rounded-corners-exclude = [ "class_g = 'Polybar'", "name = 'Notification'" ];
blur-method = "dual_kawase";
blur-strength = 4;
blur-background = true;
blur-background-exclude = [ "window_type = 'dock'", "_GTK_FRAME_EXTENTS@:c" ];
fading = true;
fade-in-step = 0.08;
fade-out-step = 0.08;
rules = (
  { match = "class_g = 'Firefox'"; opacity = 0.9; },
  { match = "name = 'Dialog'"; shadow = false; }
);
```

---

### Notes & Caveats

* Some parameters may only apply to **forks** of picom (e.g., ones that added rounded-corners, dual_kawase blur, etc). Always check version / manpages.
* Some features (especially blur, rounded corners) may cause performance issues depending on GPU/driver. Users on Reddit report slowdowns. ([Reddit][8])
* If you mis-configure the config file (syntax errors, unsupported options) picom might fail to start or silently disable features.
* There’s overlap/legacy options: older “inactive-opacity / active-opacity” vs new “rules” based approach — mixing both may produce unexpected results. ([picom.app][1])
* If you rely on a **nested window manager** (like i3, dwm etc) and especially tiling, ensure that your settings (unredir-if-possible, vsync, backend) match your GPU/driver setup.

---

If you like, I can **send you a full commented `picom.conf` template** (one with all major parameters commented out + explanations) tailored for use with dwm/tiling WM, so you can pick what you like. Would you like that?

[1]: https://picom.app/?utm_source=chatgpt.com "picom(1)"
[2]: https://gist.github.com/scheckley/b91d7b50c7f372ba7107baf01127da3a?utm_source=chatgpt.com "picom default config · GitHub"
[3]: https://linuxcommandlibrary.com/man/picom?utm_source=chatgpt.com "picom man | Linux Command Library"
[4]: https://config.phundrak.com/picom?utm_source=chatgpt.com "Picom (deprecated) | Phundrak's Dotfiles"
[5]: https://gist.github.com/girogio/9b3f489fd4babada00f1257847c0481b?utm_source=chatgpt.com "picom.conf · GitHub"
[6]: https://freakybyte.github.io/dotfiles/desktopenvironment/picom/index.html?utm_source=chatgpt.com "Picom :: Reitis Punktdateien"
[7]: https://www.reddit.com/r/linuxquestions/comments/tto2mq?utm_source=chatgpt.com "picom issues with libconfig"
[8]: https://www.reddit.com/r/archlinux/comments/16gm4jy?utm_source=chatgpt.com "Why does picom drop my fps on my 144hz monitor from 144 to 100-105?"

