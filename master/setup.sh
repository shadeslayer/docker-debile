#!/usr/bin/env bash
set -x
set -e
DEBILE_DIR='/srv/debile'
FILE="$DEBILE_DIR/setup.done"

export GNUPGHOME=$DEBILE_DIR

if [ ! -f $FILE ];
then
  openssl req -utf8 -nodes -newkey rsa:4096 -sha256 -x509 -days 7300 -subj "/C=NT/O=Debian/CN=debile.debian.net" -keyout $DEBILE_DIR/master.key -out $DEBILE_DIR/master.crt
  chmod go-rwx $DEBILE_DIR/*.key
  gpg -q --gen-key --batch <<EOF
    Key-Type: RSA
    Key-Length: 2048
    Name-Real: Debile Master
    Name-Comment: Debile Master Key
    Name-Email: debile@localhost
EOF

  gpg --fingerprint debile@localhost
  cat $DEBILE_DIR/master.crt | tee -a $DEBILE_DIR/keyring.pem

  mkdir -p $DEBILE_DIR/incoming/UploadQueue \
              $DEBILE_DIR/files/default \
              $DEBILE_DIR/repo/default

  cp /opt/debile/config.yaml /srv/debile/
  touch $FILE
fi
