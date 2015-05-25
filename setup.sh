#!/usr/bin/env bash
set -x
set -e

openssl req -utf8 -nodes -newkey rsa:4096 -sha256 -x509 -days 7300 -subj "/C=NT/O=Debian/CN=debile.debian.net" -keyout /srv/debile/master.key -out /srv/debile/master.crt
chmod go-rwx /srv/debile/*.key
gpg -q --gen-key --batch <<EOF
    Key-Type: RSA
    Key-Length: 2048
    Name-Real: Debile Master
    Name-Comment: Debile Master Key
    Name-Email: debile@localhost
EOF

ln -s ~/.gnupg/pubring.gpg /srv/debile/keyring.pgp
cat /srv/debile/master.crt | tee -a /srv/debile/keyring.pem
