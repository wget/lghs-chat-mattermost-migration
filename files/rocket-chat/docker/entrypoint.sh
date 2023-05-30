#!/bin/sh

/usr/bin/mongod  &
server=${!} &
(sleep 2 && /usr/bin/mongo --eval "$(cat /home/script.js)")
pkill -9 'mongod'
rm /data/db/*.lock /bin /usr/bin/mongo
/usr/bin/mongod --bind_ip 0.0.0.0 --auth
