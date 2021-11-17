#!/usr/bin/python3
#--!/usr/bin/env python3
# By trial & error; 2021 Gintaras Valatka
# Pull fixes via https://github.com/soholt/pipewire-gin

import os, sys #, json

path = "/proc/asound"
cardsPath = path + "/cards"

cards = []
cardsRaw = []
if os.path.isfile(cardsPath):
    with open(cardsPath) as f:
        cardsRaw = f.read().splitlines()

    for line in cardsRaw:
        _i = line.find("[")
        _o = line.find("]")
        if _i > -1:
            cards.append(line[_i+1:_o].strip())
else:
    print("no cards found")
    sys.exit(0)
#print("cards", cards)

name = cards[0] # first card
selected = ".config/argos/alsa.selected"
if os.path.isfile(selected):
    f = open(selected ,"r")
    name = f.readlines()[0].strip()
    f.close()

if name in cards:
    pass # card exists
else:
    name = cards[0] #"card0"

card = path + "/" + name + "/pcm0p/sub0/hw_params"

data = []
dataRaw = []
if os.path.isfile(card):
    with open(card) as f:
        dataRaw = f.read().splitlines()
    for _name in dataRaw:
        data.append(_name.strip())
#settings = os.popen("cat " + cards).read().strip()
#print("settings", settings)

ch = "0"
bits = "0"
rate = "0"

if len(data) > 1:
    fmt = data[1].replace("format: ", "")
    ch = data[3].split()[1]
    rate = data[4].split()[1]
    print(name, fmt + "@" + rate + "x" + ch + "ch")
else:
    print(name, "closed")

print("---")

#print("isfile", card, os.path.isfile(card))
for dat in data:
    print(dat)

# todo extract from selected device
depths = [ 16, 20, 24, 32 ]
print("---")
for bit in depths:
    if bit == bits:
        pass #print("-<span color='yellow'>" + freq + "</span>")
    else:
        print(bit, "| iconName='dialog-warning'")

# todo extract from selected device
freqs = [ "32000", "44100", "48000", "88200", "96000", "176400", "192000", "352800", "384000" ]
print("---")
print("DEFAULT:", rate) # todo
print("AUTO") # todo
for freq in freqs:
    if freq == rate:
        pass #print("- <span color='green'>" + freq + "</span> -", "| iconName='appointment-new'")
    else:
        print(freq, "| iconName='appointment-new'")


print("---")
#print("Cards:")
for i in cards:
    if i == name:
        pass #print("-<span color='green'>" + i + "</span>")
    else:
        print("Device: <span color='yellow'>" + i + "</span> | iconName='audio-card' bash='echo " + i + " > " + selected + "' terminal=false")

print("---")
is_pw = os.popen("which pw-cli").read().strip()
if is_pw != "":
    print("pw-top | iconName=utilities-terminal-symbolic bash='pw-top'")
    print("pactl info | iconName='info' bash='pactl info'")
    print("pw-jack Ard | iconName='ardour' bash='pw-jack ardour' terminal=false")
    print("pw-jack Calf | iconName='calf'  bash='pw-jack calfjackhost' terminal=false")
    print("pw-jack Carla | iconName='carla' bash='pw-jack carla-jack-multi' terminal=false")
    print("pw-jack patchage | iconName='patchage' bash='pw-jack patchage' terminal=false")
    print("---")
    print("🔴 pw re-start | bash='systemctl --user restart pipewire' terminal=false")
else:
    print("Ardour | iconName='ardour' bash='ardour' terminal=false")
    print("Calf | iconName='calf'  bash='calfjackhost' terminal=false")
    print("Carla | iconName='carla' bash='carla-jack-multi' terminal=false")
    print("Patchage | iconName='patchage' bash='patchage' terminal=false")
