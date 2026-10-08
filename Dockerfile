FROM python:3.11-slim AS builder

WORKDIR /build

COPY --from=ghcr.io/astral-sh/uv:0.4.18 /uv /bin/uv

COPY pyproject.toml uv.lock requirements.txt ./

RUN uv venv --python python3.11 /app/.venv && \
    uv pip install --no-cache -r requirements.txt --python /app/.venv

FROM python:3.11-slim AS final

RUN groupadd -r appgroup && useradd -r -g appgroup appuser

WORKDIR /app

COPY --from=builder /app/.venv /app/.venv
COPY prestamos /app/prestamos

RUN mkdir -p /app/datos && chown -R appuser:appgroup /app

ENV PATH="/app/.venv/bin:$PATH"
ENV PYTHONUNBUFFERED=1

USER appuser

EXPOSE 9000

HEALTHCHECK --interval=5s --timeout=3s --retries=3 --start-period=5s \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:9000/salud')" || exit 1

CMD ["uvicorn", "prestamos.servidor:app", "--host", "0.0.0.0", "--port", "9000"]