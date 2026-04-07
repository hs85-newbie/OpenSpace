FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml requirements.txt ./
COPY openspace/ ./openspace/

RUN pip install --no-cache-dir -e .

ENV OPENSPACE_WORKSPACE=/data/openspace
ENV OPENSPACE_HOST_SKILL_DIRS=""
ENV PORT=8080
ENV FASTMCP_HOST=0.0.0.0
ENV FASTMCP_PORT=8080

EXPOSE 8080

CMD ["openspace-mcp", "--transport", "sse", "--port", "8080"]
