#!/bin/bash
set -e

# Railway Startup Script for OpenClaw
echo "[OpenClaw] Starting Gateway..."

# Validate environment
if [ -z "$PORT" ]; then
  PORT=3000
  echo "[OpenClaw] PORT not set, using default: $PORT"
fi

export PORT

# Ensure data directories exist with proper permissions
mkdir -p "${OPENCLAW_STATE_DIR:=/data/.openclaw}"
mkdir -p "${OPENCLAW_WORKSPACE_DIR:=/data/workspace}"
mkdir -p "${OPENCLAW_CONFIG_DIR:=/data/.openclaw}"

# Log startup info
echo "[OpenClaw] Configuration:"
echo "  PORT: $PORT"
echo "  STATE_DIR: ${OPENCLAW_STATE_DIR}"
echo "  WORKSPACE_DIR: ${OPENCLAW_WORKSPACE_DIR}"
echo "  NODE_ENV: ${NODE_ENV:=production}"

# Start the gateway
exec node dist/index.js gateway \
  --allow-unconfigured \
  --port "$PORT" \
  --bind 0.0.0.0
