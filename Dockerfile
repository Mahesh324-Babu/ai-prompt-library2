# 🤖 AI Prompt Library

A beginner-friendly full-stack web application for browsing, viewing, and adding AI prompts with a live view counter.

## Tech Stack

| Layer     | Technology        |
|-----------|-------------------|
| Frontend  | Angular 18        |
| Backend   | Django 5.1 (FBVs) |
| Database  | PostgreSQL 16     |
| Cache     | Redis 7           |
| DevOps    | Docker Compose    |

## Features

- **Browse Prompts** — Card-based list with complexity badges
- **View Details** — Full prompt content with live Redis-powered view counter
- **Add Prompts** — Reactive form with client + server validation
- **Dockerized** — One command to run everything

## Quick Start

```bash
git clone <repo-url>
cd ai-prompt-library
docker-compose up --build
```

Then open **http://localhost:4200**

### Seed sample data (optional)

```bash
docker-compose exec backend python manage.py seed
```

## API Endpoints

| Method | URL               | Description              |
|--------|-------------------|--------------------------|
| GET    | `/prompts/`       | List all prompts         |
| POST   | `/prompts/`       | Create a new prompt      |
| GET    | `/prompts/<id>/`  | Get prompt + view count  |

### POST `/prompts/` body

```json
{
  "title": "My Prompt (min 3 chars)",
  "content": "Detailed prompt content (min 20 chars)",
  "complexity": 5
}
```

## Architecture

```
┌──────────┐     ┌──────────┐     ┌────────────┐
│ Angular  │────▶│  Nginx   │────▶│   Django   │
│ Frontend │     │ (proxy)  │     │  Backend   │
└──────────┘     └──────────┘     └─────┬──────┘
                                        │
                               ┌────────┼────────┐
                               ▼                  ▼
                         ┌──────────┐      ┌──────────┐
                         │PostgreSQL│      │  Redis   │
                         │ (data)   │      │ (views)  │
                         └──────────┘      └──────────┘
```

## Design Decisions

- **Function-based views** — Simpler than class-based for beginners
- **No DRF** — Uses plain `JsonResponse` to keep dependencies minimal
- **Redis for view counts** — Fast, atomic increments without DB writes
- **Standalone Angular components** — Modern Angular 18 pattern, no NgModules
- **Bootstrap via CDN** — Quick, clean styling without complex build setup
- **Nginx reverse proxy** — Single port serves both frontend and API

## Project Structure

```
ai-prompt-library/
├── backend/
│   ├── ai_prompt_library/   # Django project settings
│   ├── prompts/             # Main app (models, views, urls)
│   ├── Dockerfile
│   ├── manage.py
│   └── requirements.txt
├── frontend/
│   ├── src/app/
│   │   ├── components/      # prompt-list, prompt-detail, add-prompt
│   │   └── services/        # prompt.service.ts
│   ├── Dockerfile
│   └── angular.json
├── docker-compose.yml
└── README.md
```
