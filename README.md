# ▶ pipewire-gin

While plumbing @pipewire on #fedora I discovered this cool #gnome-shell extension [argos](https://extensions.gnome.org/extension/1176/argos/) and distilled some gin.

First devil's drops of pipewire-gin extension of argos extension of gnome extension of my desktop extension of life extension 🍾

- The best thing about it - very easy to customise 🏆
- It is possible to make it static and update content on "open", etc
- Current version could be usefull for developers, it will refresh hw_params of selected /proc/asound playback device every 1s or whatever it is set to, to 'real-time' monitor format and sample rate
- Could this provide easy acces to chaging default params "on the go"?
- Not quite sure yet howto pw-cli set-param to node 0 to change default.clock.rate = "48000" and default.clock.allowed-rates = "[ 48000 ]", (frames, buffers etc)

---
## ⚔ Install
If argos extension is runining and you are happy with the content of [asla.1s.sh](https://github.com/soholt/pipewire-gin/blob/main/alsa.1s.sh):
```
curl https://raw.githubusercontent.com/soholt/pipewire-gin/main/alsa.1s.sh -O ~/.config/argos/alsa.1s.sh && chmod +x ~/.config/argos/alsa.1s.sh
 - or -
wget https://raw.githubusercontent.com/soholt/pipewire-gin/main/alsa.1s.sh -P ~/.config/argos && chmod +x ~/.config/argos/alsa.1s.sh
```
---

On Fedora:
```
sudo dnf install gnome-shell-extension-argos gnome-shell-extension-prefs git
# go to step1 of follow below

```

On Ubuntu:
```
sudo apt install gnome-shell-extension-prefs git
```
To install argos extension from f35, git clone https://github.com/soholt/pipewire-gin and run ./f35/install.sh if you trust or follow instructions(I am keeping it here for myself)
Original extension does not work on 21.10(or younger desktops), download it from [f35 direct dl](https://kojipkgs.fedoraproject.org//packages/gnome-shell-extension-argos/3/7.20211027git2eb03a7.fc35/src/gnome-shell-extension-argos-3-7.20211027git2eb03a7.fc35.src.rpm) or [select f35 from the list](https://src.fedoraproject.org/rpms/gnome-shell-extension-argos), extract it til you find `argos@pew.worldwidemann.com` folder and copy it to ~/.local/share/gnome-shell/extensions or run `./f35/install.sh` to copy argos from Fedora 35..

---

Logout/login and enable argos extension using extension prefs
```
git clone https://github.com/soholt/pipewire-gin
cd pipewire-gin && ./install.sh
gnome-shell-extension-prefs
```

---
Sreenshots: 

---
## ♔ Support [ ☆ ⚛ ☠ ☕](https://ko-fi.com/ginsoholt)

---
## ⚜ Develop

For additional HW info aplay -l, aplay -L, arecord -l, arecord -L or the good old 🙀 cat /proc/asound/*/?, pyalsa also available
```
aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: CS4206 Analog [CS4206 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 1: CS4206 Digital [CS4206 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: HDMI [HDA ATI HDMI], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
```


---
fi