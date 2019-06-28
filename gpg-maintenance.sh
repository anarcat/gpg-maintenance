#!/bin/sh

KEYSERVER="hkps://keys.openpgp.org"

FILTER="cat"

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
                delay=$(( $(tr -cd "[:digit:]" < /dev/urandom | head -c 3) + 300 ))
                echo "I: sleeping for $delay seconds..."
		sleep $delay
	done
done
