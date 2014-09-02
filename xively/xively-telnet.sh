#!/bin/sh
FEED="#########"
APIKEY="################################################"
WEBSITE="api.xively.com"
SENSOR="SensorName"
read VALUE < /dev/ttySx
VALUE=$(printf %.0f $VALUE)
DATA="${SENSOR},${VALUE}"
SIZE=$(echo ${DATA} | wc -c)
(
sleep 2
echo "PUT http://${WEBSITE}/v2/feeds/${FEED}.csv HTTP/1.0
Host: ${WEBSITE}
X-ApiKey: ${APIKEY}
Content-Length: ${SIZE}

${DATA}"
sleep 2
) | telnet ${WEBSITE} 80
