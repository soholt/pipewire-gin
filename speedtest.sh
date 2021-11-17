#!/usr/bin/env bash
# 2021 Gintaras Valatka
# Pull fixes via https://github.com/soholt/pipewire-gin

# To speed test run:
# time ./alsa.speed.sh

# My results
# echo `./alsa.1s.sh`
#real    0m1.222s
#user    0m0.565s
#sys     0m0.663s

# echo `./alsa.1s.py`
#real    0m3.881s
#user    0m3.016s
#sys     0m0.681s

# Rename .sh to .py to test python
for i in {1..100}
do
  echo `./alsa.1s.sh`
done
