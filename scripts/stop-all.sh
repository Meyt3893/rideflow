#!/bin/bash

# Stop all Joint Work services

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Load .env file if it exists (export all variables)
if [ -f "$PROJECT_ROOT/.env" ]; then
  set -a
  source "$PROJECT_ROOT/.env"
  set +a
fi

# Set defaults if not defined in .env
export BACKEND_PORT="${BACKEND_PORT:-3030}"
export FRONTEND_PORT="${FRONTEND_PORT:-5193}"

echo "🛑 Stopping services..."

# Kill processes on service ports
for port in $BACKEND_PORT $FRONTEND_PORT; do
  pid=$(lsof -ti:$port 2>/dev/null || true)
  if [ -n "$pid" ]; then
    echo "  Killing process on port $port (PID: $pid)"
    kill -9 $pid 2>/dev/null || true
  else
    echo "  No process running on port $port"
  fi
done

echo "✅ All services stopped"
