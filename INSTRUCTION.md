# Django-Todolist — Docker Compose Instructions

## Docker Hub Repository

- App image: https://hub.docker.com/r/olehkovalievskyi/todoapp

## Prerequisites

- Docker installed on your machine
- Docker Compose installed on your machine (usually bundled with Docker Desktop)

## Project Structure

This project uses `docker-compose.yml` to build and run two services together:

- `mysql-local` — MySQL database with a persistent volume attached
- `todolist-app` — Django Todolist application

## 1. Start the application

From the root directory of the project, run:

```bash
docker-compose up
```

This command will:
1. Build the `todolist-app` service image (if not already built).
2. Pull and start the `mysql-local` (MySQL) service.
3. Run database migrations automatically when the `todolist-app` container starts.
4. Start the Django development server on `0.0.0.0:8080`.

To run the containers in detached mode (in the background):

```bash
docker-compose up -d
```

## 2. Access the application

Once both containers are up and running, open your browser and navigate to:

http://localhost:8080

## 3. Stop the containers

To stop the running containers (without removing them):

```bash
docker-compose stop
```

To stop and remove the containers, networks created by `docker-compose up`:

```bash
docker-compose down
```

**Note:** the command above does **not** remove the named volume, so your
database data will persist. If you want to remove the volume as well
(this will delete all stored data), run:

```bash
docker-compose down -v
```

## 4. View logs

To check the application logs (useful for debugging):

```bash
docker-compose logs -f todolist-app
```

To check the database logs:

```bash
docker-compose logs -f mysql-local
```

## Notes

- Todos are stored in a MySQL database (`app_db`), with a persistent
  volume attached, so data survives container restarts.
- Database migrations run automatically at container startup
  (via `ENTRYPOINT`), not during the image build, since the database
  is not available at build time.
- The application listens on `0.0.0.0:8080` inside the container.