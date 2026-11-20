#!/bin/bash
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:20128/api/status 2>/dev/null)

if [ "$HTTP_CODE" = "000" ] || [ -z "$HTTP_CODE" ]; then
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:20128/ 2>/dev/null)
fi

if [ "$HTTP_CODE" = "000" ] || [ -z "$HTTP_CODE" ]; then
    echo "$(date): 9Router is DOWN (HTTP $HTTP_CODE). Restarting..." >> /home/bsiiowd3c0fb/9router/keepalive.log
    /home/bsiiowd3c0fb/9router/start_9router.sh
else
    echo "$(date): 9Router is UP (HTTP $HTTP_CODE)" >> /home/bsiiowd3c0fb/9router/keepalive.log
fi
