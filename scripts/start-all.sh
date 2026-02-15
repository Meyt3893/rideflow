#!/bin/bash

# Start all Joint Work services (backend, frontend)
# Kills existing processes on their ports and starts fresh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

# Load .env file if it exists (export all variables)
if [ -f "$PROJECT_ROOT/.env" ]; then
  set -a
  source "$PROJECT_ROOT/.env"
  set +a
fi

# Set defaults if not defined in .env
export BACKEND_PORT="${BACKEND_PORT:-3030}"
export FRONTEND_PORT="${FRONTEND_PORT:-5193}"

echo "🔄 Stopping existing services..."

# Kill processes on service ports
for port in $BACKEND_PORT $FRONTEND_PORT; do
  pid=$(lsof -ti:$port 2>/dev/null || true)
  if [ -n "$pid" ]; then
    echo "  Killing process on port $port (PID: $pid)"
    kill -9 $pid 2>/dev/null || true
  fi
done

# Give processes time to release ports
sleep 1

# Create logs directory if it doesn't exist
mkdir -p "$PROJECT_ROOT/logs"

# Clear logs
rm -f "$PROJECT_ROOT/logs"/*

echo "🚀 Starting services..."

# Start Backend
echo "  Starting backend on port $BACKEND_PORT..." > "$PROJECT_ROOT/logs/backend.log"
pnpm --filter backend dev >> "$PROJECT_ROOT/logs/backend.log" 2>&1 &

# Start Frontend
echo "  Starting frontend on port $FRONTEND_PORT..." > "$PROJECT_ROOT/logs/frontend.log"
pnpm --filter frontend dev >> "$PROJECT_ROOT/logs/frontend.log" 2>&1 &

echo ""
echo "✅ All services started in background:"
echo "   - Backend:  http://localhost:$BACKEND_PORT"
echo "   - Frontend: http://localhost:$FRONTEND_PORT"
echo ""
echo "📁 Logs: $PROJECT_ROOT/logs/"
echo "💡 Use 'pnpm stop' to stop all services"

# Wait for services to be ready
echo ""
echo "⏳ Waiting for services to be ready..."

wait_for_service() {
  local name=$1
  local url=$2
  local max_attempts=30
  local attempt=1

  while [ $attempt -le $max_attempts ]; do
    if curl -s -o /dev/null -w "%{http_code}" "$url" 2>/dev/null | grep -q "^[23]"; then
      echo "   ✓ $name is ready"
      return 0
    fi
    sleep 1
    attempt=$((attempt + 1))
  done

  echo "   ✗ $name failed to start within ${max_attempts}s"
  return 1
}

wait_for_service "Backend" "http://localhost:$BACKEND_PORT/health" || exit 1
wait_for_service "Frontend" "http://localhost:$FRONTEND_PORT" || exit 1

echo ""
echo "✅ All services are ready!"

# Open browser (cross-platform)
echo "🌐 Opening browser..."
if command -v xdg-open &> /dev/null; then
  xdg-open "http://localhost:$FRONTEND_PORT" 2>/dev/null &
elif command -v open &> /dev/null; then
  open "http://localhost:$FRONTEND_PORT"
else
  echo "   Could not open browser automatically. Please navigate to http://localhost:$FRONTEND_PORT"
fi
