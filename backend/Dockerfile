FROM python:3.11-alpine

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install build dependencies for psycopg2
RUN apk add --no-cache --virtual .build-deps \
        gcc \
        musl-dev \
        libffi-dev \
        postgresql-dev \
        python3-dev \
        build-base \
    && apk add --no-cache libpq

COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Remove heavy build dependencies (saves 400–500MB)
RUN apk del .build-deps

COPY . .

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]













# FROM python:3.10-alpine
#
# ENV PYTHONDONTWRITEBYTECODE=1
# ENV PYTHONUNBUFFERED=1
#
# WORKDIR /app
#
# # Install system dependencies required for PostgreSQL & psycopg2
# RUN apk add --no-cache \
#     gcc \
#     musl-dev \
#     libffi-dev \
#     postgresql-dev \
#     python3-dev \
#     build-base
#
# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt
#
# COPY . .
#
# # Run migrations automatically on container start
# CMD ["sh", "-c", "python manage.py makemigrations && python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
#
