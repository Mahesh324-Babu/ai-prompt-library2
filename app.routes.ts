version: "3.9"

services:
  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: promptlib
      POSTGRES_USER: promptuser
      POSTGRES_PASSWORD: promptpass
    volumes:
      - pgdata:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

  backend:
    build: ./backend
    ports:
      - "8000:8000"
    environment:
      DATABASE_URL: postgres://promptuser:promptpass@db:5432/promptlib
      REDIS_URL: redis://redis:6379/0
      DJANGO_ALLOWED_HOSTS: "*"
    depends_on:
      - db
      - redis

  frontend:
    build: ./frontend
    ports:
      - "4200:80"
    depends_on:
      - backend

volumes:
  pgdata:
