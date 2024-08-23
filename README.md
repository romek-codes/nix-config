# nix-config

## Keybindings:
| Keybinding | Action |
| ---------- | ------ |
| META + P | Launch program |
| META + C | Color picker, automatic copy to clipboard |
| META + A | Take screenshot of selected area |
| META + Space | Switch keyboard layout |
| META + CTRL + L | Lock screen |
| META + TAB | Switch between windows |
| META + S | Take screenshot of entire screen |
| META + Return | Open terminal |
| META + Q | Close active window |
| META + V | Toggle floating mode for active window |
| META + SHIFT + F | Toggle fullscreen mode |
| META + . | Switch to next workspace |
| META + , | Switch to previous workspace |
| META + CTRL + F | Toggle file manager |
| META + CTRL + S | Toggle music player |
| META + F | Toggle centered layout |
| META + H/L | Navigate through windows in centered layout |
| META + K/J | Navigate through windows in centered layout (alternate) |
| META + 1-0 | Switch to workspace 1-10 |
| META + SHIFT + 1-0 | Move active window to workspace 1-10 |
| ALT + R | Enter resize mode (use H/J/K/L to resize, CTRL+C to exit) |


# Notes

To disable and enable device run: 
```cyme```
Example output:
```1   5 󰍽 0x046d 0x0823 HD Webcam B910                E431D620     480.0 Mb/s```
Then to enable and disable:
```sudo usb_modeswitch -v 0x046d -p 0x0823 --reset-usb```

Will be looking for a simpler solution, but it works I guess.

