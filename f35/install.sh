#!/usr/bin/env bash
# Build by trial & error; 2021 Gintaras Valatka
# Pull fixes via githttp://soho.lt/au

# Extracted from
# https://kojipkgs.fedoraproject.org//packages/gnome-shell-extension-argos/3/7.20211027git2eb03a7.fc35/src/gnome-shell-extension-argos-3-7.20211027git2eb03a7.fc35.src.rpm

GNOME=~/.local/share/gnome-shell/extensions

mkdir -p $GNOME
cp -r argos@pew.worldwidemann.com $GNOME
