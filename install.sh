#!/usr/bin/env bash
# 2021 Gintaras Valatka
# Pull fixes via https://github.com/soholt/pipewire-gin

ARGOS=~/.config/argos

mkdir -p $ARGOS
chmod +x alsa.1s.sh
cp alsa.1s.sh $ARGOS
