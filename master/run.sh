#!/usr/bin/env bash
set -x
set -e

/opt/debile/setup.sh
/usr/bin/debile-master --auth simple --config /srv/debile/config.yaml
