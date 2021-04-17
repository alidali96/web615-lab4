#!/bin/bash
set +e
bin/rails db:migrate 2>/dev/null
RET=$?
set -e
if [ $RET -gt 0 ]; then
    bin/rails db:create
    bin/rails db:migrate
    bin/rails db:test:prepare
    bin/rails db:seed
fi
rm -f tmp/pids/server.pid
bin/rails server -p 3000 -b '0.0.0.0'
