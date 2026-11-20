# 9Router en Core-under — notas de operación

Este repo es un clon de `decolua/9router` y NO se modifica su código: el
dashboard se sirve compilado desde `.next/standalone` y lo opera el panel de
Core-under a través de su proxy (`/admin/herramientas/gateway/9router`).

## Qué hay en esta rama

| Fichero | Para qué |
|---|---|
| `start_9router.sh` | arranque real: `PORT=20128`, `HOSTNAME=127.0.0.1`, `NODE_ENV=production`, `DATA_DIR=~/9router/data`, mata el proceso anterior y lanza `standalone/server.js` guardando `server.pid` |
| `keepalive.sh` | cron cada 5 min: si `/api/status` no responde lo relanza y anota en `keepalive.log` |
| `CORE-UNDER.md` | este documento |

Todo lo demás (`data/`, `.next/`, `node_modules/`, `.env`, logs) queda fuera de
git a propósito: son datos o artefactos de build.

## Sesión única desde el panel

El panel de Core-under ya autentica al operador. Para que el dashboard no pida
contraseña dentro del iframe, el proxy de Laravel hace un **login real** contra
`127.0.0.1:20128` con la clave del dashboard (`NINEROUTER_DASHBOARD_PASSWORD`
en el `.env` de Laravel) y cachea 8 h la cookie `auth_token` que emite el propio
9Router. No se replica la firma JWT: su middleware usa un secreto propio que no
está en `data/jwt-secret`, así que fabricar el token no funciona.

## Reconstruir tras un `git pull` del upstream

```bash
export PATH=$HOME/opt/node-v22.14.0-linux-x64/bin:$PATH
cd ~/9router
npm install          # dependencias del build
npm run build        # genera .next/standalone
bash start_9router.sh
```

Aviso: en este host el compilador de Next se queda sin memoria si se lanza con
los límites por defecto de la cuenta; el build conviene hacerlo fuera (CI) y
subir `.next/standalone`.
