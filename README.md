GPG maintenance
===============

Description
-----------

GPG maintenance keeps your GnuPG OpenPGP keyring current, by constantly and silently refreshing public keys to fetch updates.

Refresh Public Keys
-------------------

From Riseup Labs [OpenPGP Best Practices](https://we.riseup.net/riseuplabs+paow/openpgp-best-practices):

> Make sure you are receiving regular key updates.

> If you do not regularly refresh your public keys, you do not get timely expirations or revocations, both of which are very important to be aware of!

> If you do a simple 'gpg --refresh-keys', you disclose to anyone listening, and the keyserver operator, the whole set of keys that you are interested in refreshing.

GPG maintenance is a simple shell script taking all public keys in your keyring and refreshing them one at a time, waiting a random interval between five and 21 minutes.

Configuration
-------------

Be sure to set up your GnuPG options file "~/.gnupg/gpg.conf" to use Tor and a Keyserver supporting HKPS.

See the example gpg.conf for some proposed good practices.

Autostart
---------

GPG maintenance is designed to be started automatically on boot, for example via Init Script.

See the example LSBInitScript.sh for an LSB (Linux Standards Base)-compliant Init Script, as used by Debian-based sytems. Be sure to edit the user.

TODO
----

GPG maintenance currently uses the $RANDOM variable and therefore is not POSIX compatible :(

Inspiration
-----------

There's [parcimonie](https://gaffer.ptitcanardnoir.org/intrigeri/code/parcimonie/) doing something similar. But it's Perl. And it's over 9000 Hectobytes.

License
-------

[Beerware](https://en.wikipedia.org/wiki/Beerware)
