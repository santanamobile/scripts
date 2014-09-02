#!/bin/sh
FEED="#########"
APIKEY="################################################"
WEBSITE="api.xively.com";
SENSOR="SensorName"
VALUE=$(shuf -i 10-15 -n 1)
VALUE=$(printf %.0f $VALUE)
DATA='{"version":"1.0.0", "datastreams":[{"id":"'"$SENSOR"'", "current_value":"'"$VALUE"'"}]}'

curl -ssss \
 --request PUT \
 --header "X-ApiKey: $APIKEY" \
 --data "$DATA" \
 https://$WEBSITE/v2/feeds/$FEED > /dev/null
