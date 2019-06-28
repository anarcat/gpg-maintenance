#!/bin/sh

KEYSERVER="hkps://keys.openpgp.org"

FILTER="cat"
#KEYRING_SIZE=1000
#FILTER="pv -l -s $KEYRING_SIZE"

# minimum number of seconds to way
DELAY_BASE=120
# a range of random seconds on top of that
DELAY_RANGE=180
# maximum is DELAY_BASE + rand(DELAY_RANGE), so anywhere between 2 to
# 5 minutes by default

# another filter can be enabled with, for example:
# FILTER="grep -v C4BC2DDB38CCE96485EBE9C2F20691179038E5C6"

while true
do
	echo "I: listing all keys..."
	for fingerprint in $(gpg --list-keys --with-colons --with-fingerprint \
				| grep --after-context "1" "^pub" \
				| grep "^fpr" \
				| cut -d ":" -f "10" \
				| $FILTER \
				| sort --random-sort)
	do
		echo "I: refreshing $fingerprint..."
		gpg --batch --no-tty --no-auto-check-trustdb --keyserver "$KEYSERVER" --refresh-keys "$fingerprint"
                # this takes 4 bytes out of urandom and formats them as an unsigned integer
                r=$(od -vAn -N4 -tu4 < /dev/urandom)
		delay=$( echo "$DELAY_BASE + $r % $DELAY_RANGE" | bc )
                echo "I: sleeping for $delay seconds..."
		sleep $delay
	done
done
