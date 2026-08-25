#!/bin/bash
set -euo pipefail

curl -L -o quickclean --progress-bar https://raw.githubusercontent.com/M4RC086/quick-clean/main/quickclean.sh
chmod +x quickclean
sudo mv quickclean /usr/bin
echo "Installed :)"