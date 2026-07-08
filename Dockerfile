# Stage 1: Build Stage
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION} as builder

# Set the working directory
WORKDIR /app
COPY . .

# Stage 2: Run Stage
FROM python:${PYTHON_VERSION} as run

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY --from=builder /app .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Install MySQL client for database migrations
RUN apt-get update && \
    apt-get install -y --no-install-recommends default-mysql-client && \
    rm -rf /var/lib/apt/lists/*

# Add x permission to wait-for-db.sh script
RUN chmod +x wait-for-db.sh

EXPOSE 8080

# Run database migrations and start the Django application
ENTRYPOINT ["./wait-for-db.sh", "mysql-local", "sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8080"]

