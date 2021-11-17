#!/bin/python3
# By trial & error; 2021 Gintaras Valatka
# Pull fixes via https://github.com/soholt/pipewire-gin

# Fedora sudo dnf install (python-alsa?)
# Ubuntu sudo apt install python3-pyalsa
#  
from pyalsa import alsacard #, alsamixer, alsacontrol

print("pyalsa")
print("---")

l = alsacard.card_list()
print("Cards:")

dev = []
for i in l:
    name = alsacard.card_get_name(i)
    #long_name = alsacard.card_get_longname(i)
    print("Dev:", name)

'''    
m = alsamixer.Mixer()
mm = m.list()
print("mm", mm)

c = alsacontrol.Control()
cc = c.card_info()
print("cc", cc)
'''
