#!/usr/bin/env bash

set -euo pipefail

if [[ ! -f "/usr/bin/firefox" ]]; then
	echo "Firefox doesn't exists, not removing..."
else
	rpm-ostree override remove firefox
	rpm-ostree override remove firefox-langpacks
fi
