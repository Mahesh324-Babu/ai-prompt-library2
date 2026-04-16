import os
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent
SECRET_KEY = "dev-secret-key-change-in-production"
DEBUG = True
ALLOWED_HOSTS = os.environ.get("DJANGO_ALLOWED_HOSTS", "*").split(",")

INSTALLED_APPS = [
    "django.contrib.contenttypes",
    "django.contrib.auth",
    "corsheaders",
    "prompts",
]

MIDDLEWARE = [
    "corsheaders.middleware.CorsMiddleware",
    "django.middleware.common.CommonMiddleware",
]

CORS_ALLOW_ALL_ORIGINS = True
ROOT_URLCONF = "ai_prompt_library.urls"
WSGI_APPLICATION = "ai_prompt_library.wsgi.application"

# Database — parse DATABASE_URL or default to SQLite
_db_url = os.environ.get("DATABASE_URL", "")
if _db_url.startswith("postgres"):
    import re
    m = re.match(r"postgres://(?P<user>[^:]+):(?P<password>[^@]+)@(?P<host>[^:]+):(?P<port>\d+)/(?P<name>.+)", _db_url)
    DATABASES = {
        "default": {
            "ENGINE": "django.db.backends.postgresql",
            "NAME": m.group("name"),
            "USER": m.group("user"),
            "PASSWORD": m.group("password"),
            "HOST": m.group("host"),
            "PORT": m.group("port"),
        }
    }
else:
    DATABASES = {
        "default": {
            "ENGINE": "django.db.backends.sqlite3",
            "NAME": BASE_DIR / "db.sqlite3",
        }
    }

# Redis
REDIS_URL = os.environ.get("REDIS_URL", "redis://localhost:6379/0")

DEFAULT_AUTO_FIELD = "django.db.models.BigAutoField"
