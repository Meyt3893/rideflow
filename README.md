# Joint Work

A mono-repo project for recruiting home assignments. Built with TypeScript, Express, Vue 3, and MySQL.

## Prerequisites

- Node.js >= 18
- pnpm
- Docker (for MySQL)
- Atlas CLI (for schema management)

### Installing Prerequisites

**pnpm** (if not installed):
```bash
npm install -g pnpm
```

**Atlas CLI** (if not installed):
```bash
curl -sSf https://atlasgo.sh | sh
```

> **Note:** Atlas requires Docker for its dev database (used for schema diffing).

## Quick Start

### 1. Install Dependencies

```bash
pnpm install
```

### 2. Set Up Environment

```bash
cp .env.example .env
# Edit .env if needed (defaults work with Docker setup below)
```

### 3. Start MySQL with Docker

```bash
docker run -d --name joint_work_mysql \
  --restart unless-stopped \
  -e MYSQL_ROOT_PASSWORD=password \
  -e MYSQL_DATABASE=joint_work \
  -v joint_work_mysql_data:/var/lib/mysql \
  -p 3307:3306 \
  mysql:8
```

### 4. Apply Database Schema

```bash
pnpm run db:apply
```

### 5. Run the Application

In separate terminals:

```bash
# Backend (runs on port 3000)
pnpm run dev:backend

# Frontend (runs on port 5173)
pnpm run dev:frontend
```

## Project Structure

```
joint_work/
├── packages/
│   └── shared/          # Shared TypeScript types
├── services/
│   └── backend/         # Express API server
├── apps/
│   └── frontend/        # Vue 3 frontend
└── db/
    ├── atlas.hcl        # Atlas configuration
    └── schema.sql       # Database schema
```

## Available Scripts

| Script | Description |
|--------|-------------|
| `pnpm install` | Install all dependencies |
| `pnpm build` | Build all packages |
| `pnpm dev:backend` | Start backend with hot reload |
| `pnpm dev:frontend` | Start frontend dev server |
| `pnpm test` | Run all tests |
| `pnpm db:apply` | Apply database schema with Atlas |

## API Endpoints

- `GET /api/reservations` - List all bookings
- `POST /api/reservations` - Create a new booking

## Tech Stack

- **Backend**: Express, TypeScript, mysql2, Zod
- **Frontend**: Vue 3, Vite, TypeScript
- **Database**: MySQL 8
- **Schema Management**: Atlas
- **Package Manager**: pnpm workspaces
