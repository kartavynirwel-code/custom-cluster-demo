#!/bin/sh
# Runs at container start (nginx image executes /docker-entrypoint.d/*.sh).
# Turns environment variables into env.js so the static page can read them.
set -eu

esc() { printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'; }

cat > /usr/share/nginx/html/env.js <<EOT
window.__ENV__ = {
  APP_TITLE: "$(esc "${APP_TITLE:-}")",
  APP_ENV: "$(esc "${APP_ENV:-}")",
  POD_NAME: "$(esc "${POD_NAME:-}")",
  POD_NAMESPACE: "$(esc "${POD_NAMESPACE:-}")",
  POD_IP: "$(esc "${POD_IP:-}")",
  NODE_NAME: "$(esc "${NODE_NAME:-}")"
};
EOT
