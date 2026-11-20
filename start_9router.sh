#!/bin/bash
export PATH=/home/bsiiowd3c0fb/opt/node-v22.14.0-linux-x64/bin:$PATH
export PORT=20128
export HOSTNAME=127.0.0.1
export NODE_ENV=production
export DATA_DIR=/home/bsiiowd3c0fb/9router/data

pkill -9 -f 'standalone/server.js|custom-server.js' 2>/dev/null || true
sleep 1

cd /home/bsiiowd3c0fb/9router/.next/standalone
nohup /home/bsiiowd3c0fb/opt/node-v22.14.0-linux-x64/bin/node server.js > /home/bsiiowd3c0fb/9router/server.log 2>&1 &
PID=$!
echo $PID > /home/bsiiowd3c0fb/9router/server.pid
echo "9Router started with Node 22 on port 20128 with PID $PID"
