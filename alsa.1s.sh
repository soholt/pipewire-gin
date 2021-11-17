#!/usr/bin/env bash
# By trial & error; 2021 Gintaras Valatka
# Pull fixes via https://github.com/soholt/pipewire-gin

# TO hide/show selected 0/1
SHOW_SELECTED=0


IDS=() # CARD IDs
CARDS=() # CARD NAMEs
CARDS_FILE="/proc/asound/cards"
if [ -f $CARDS_FILE ]; then
    readarray -t CARDS_RAW < $CARDS_FILE
	# Build id and cards array
	for c in "${CARDS_RAW[@]}"; do
		# If substring "[" found
		if [[ $c = *"["* ]]; then
			# String part before :colon
			_CARD=`awk -F':' '{print $1}' <<< $c`
			# Split by space
			IFS=' ' read -ra SUBSTR <<< ${_CARD}
			ID=${SUBSTR[0]}
			NAME=${SUBSTR[1]}
			# Remove "[]"
			NAME=${NAME/#[}
			#NAME=${NAME/%]}
			# Add to array
			IDS+=($ID)
			CARDS+=($NAME)
		fi
	done
else
	echo "NoSoundCards"
	exit
fi


CARD="card0"
# Read config if exist
CONFIG=~/.config/argos/alsa.selected
if [ -f $CONFIG ]; then
	CARD=`cat $CONFIG`
fi

# Get card params by card name
RATE=0
HW_PARAMS="/proc/asound/$CARD/pcm0p/sub0/hw_params"
if [ -f $HW_PARAMS ]; then

    readarray -t PARAMS < $HW_PARAMS

    if [ "${PARAMS[0]}" == "closed" ]; then
		echo "$CARD ${PARAMS[0]}"
    else
		# https://stackoverflow.com/questions/918886/how-do-i-split-a-string-on-a-delimiter-in-bash
		IFS=' ' read -ra FORMAT <<< ${PARAMS[1]}
		FORMAT=${FORMAT[1]}
		
		IFS=' ' read -ra CH <<< ${PARAMS[3]}
		CH=${CH[1]}

		IFS=' ' read -ra RATE <<< ${PARAMS[4]}
		RATE=${RATE[1]}

		echo "$CARD $FORMAT@$RATE""x$CH""ch"
        echo "---"
		# Params:
        for i in "${PARAMS[@]}"; do
			echo $i
		done

		echo " - T O D O: Fs and Bits - "
		# Freqs aka Rates; TODO extract from selected device
		#FREQS=("32000" "44100" "48000" "88200" "96000" "176400" "192000" "352800" "384000")
		FREQS=(44100 48000 88200 96000)
		#echo "DEFAULT: $RATE; TODO"
		#echo "AUTO ${FREQS[*]}"
		for FREQ in "${FREQS[@]}"; do
			# This hides selected freq
			if [ $FREQ != $RATE ]; then
				echo "Fs: <span color='yellow'>$(expr $FREQ / 1000)kHz</span> | iconName='appointment-new' bash='echo TODO' terminal=false"
			else
				if [ $SHOW_SELECTED -eq 1 ]; then
					echo "Fs: <span color='green' weight='bold'>$(expr $FREQ / 1000)kHz</span> | iconName='appointment-new'"
				fi
			fi
		done

		# Bit depths
		BITS=0
		DEPTHS=(16 24 32)
		for DEPTH in "${DEPTHS[@]}"; do
			if [ $DEPTHS != $BITS ]; then
				echo "Res: <span color='orange'>$DEPTH""Bit</span> | iconName='appointment-new' bash='echo TODO' terminal=false"
			else
				if [ $SHOW_SELECTED -eq 1 ]; then
					echo "Res: <span color='green' weight='bold'>$DEPTH""Bit</span> | iconName='appointment-new'"
				fi
			fi
		done

    fi
else
    echo "$CARD not found"
	echo "---"
fi

# List cards if more than 1 #echo ${IDS[*]} #echo ${CARDS[*]}
if [ ${#CARDS[@]} -gt 1 ]; then
	echo "---"
	for i in "${CARDS[@]}"; do
		if [ $i != $CARD ]; then
			# Write config on select
			echo "Dev: <span color='yellow'>$i</span> | iconName='audio-card' bash='echo $i > $CONFIG' terminal=false"
		else
			if [ $SHOW_SELECTED -eq 1 ]; then
				echo "Dev: <span color='green' weight='bold'>$i</span> | iconName='audio-card'"
			fi
		fi
	done
fi

# Extra menu, delete not needed entries
echo "---"
# If pipewire
if [ `which pw-cat` ]; then
	echo "pw-top | iconName=utilities-terminal-symbolic bash='pw-top && exit'"
    echo "pactl info | iconName='info' bash='pactl info'"
    echo "pw-jack Ardour | iconName='ardour' bash='pw-jack ardour' terminal=false"
    echo "pw-jack Calf | iconName='calf'  bash='pw-jack calfjackhost' terminal=false"
    echo "pw-jack Carla | iconName='carla' bash='pw-jack carla-jack-multi' terminal=false"
    echo "pw-jack Patchage | iconName='patchage' bash='pw-jack patchage' terminal=false"
    echo "---"
    echo "🔴 pw re-start | bash='systemctl --user restart pipewire' terminal=false"
else
    echo "Ardour | iconName='ardour' bash='ardour' terminal=false"
    echo "Calf | iconName='calf'  bash='calfjackhost' terminal=false"
    echo "Carla | iconName='carla' bash='carla-jack-multi' terminal=false"
    echo "Patchage | iconName='patchage' bash='patchage' terminal=false"
fi
