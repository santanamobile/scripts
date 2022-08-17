#!/bin/sh
#
# Author: @santanamobile
# Script arduino-cli install
#

LOCATION="${HOME}/bin"
export BINDIR="${LOCATION}"

if [ ! -d ${LOCATION} ]; then
        mkdir -p ${LOCATION};
fi;

export PATH="${PATH}:${LOCATION}"

curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh 

# arduino-cli config init --additional-urls https://downloads.arduino.cc/packages/package_staging_index.json,https://dl.espressif.com/dl/package_esp32_index.json,https://arduino.esp8266.com/stable/package_esp8266com_index.json
# OR
echo "Creating new config file"
arduino-cli config init
sleep 2

echo "Adding aditional boards to config"
arduino-cli config add board_manager.additional_urls https://downloads.arduino.cc/packages/package_staging_index.json
arduino-cli config add board_manager.additional_urls https://dl.espressif.com/dl/package_esp32_index.json
arduino-cli config add board_manager.additional_urls https://arduino.esp8266.com/stable/package_esp8266com_index.json

sleep 2

echo "Updating the index of cores"
arduino-cli core update-index
sleep 2

echo "Installing boards cores"
arduino-cli core install arduino:avr
arduino-cli core install esp32:esp32
arduino-cli core install esp8266:esp8266

arduino-cli core list
