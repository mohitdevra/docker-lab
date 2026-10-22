FROM python:3.13-slim
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/

WORKDIR /code

# Copy dependency configs first for caching
COPY pyproject.toml .python-version uv.lock README.md ./

# Copy remaining source code
COPY src ./src

# Install dependencies into virtual environment
RUN uv sync --locked --no-dev --no-editable

# Set environment path to virtual env
ENV PATH="/code/.venv/bin:$PATH"

ENTRYPOINT ["python", "-m", "pipeline.ingest_data"]