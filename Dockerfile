FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PORT=8080

WORKDIR /app
RUN addgroup --system app && adduser --system --ingroup app app

COPY app/requirements.txt /app/
RUN python -m pip install --no-cache-dir -r requirements.txt
COPY --chown=app:app app/ /app/
USER app

EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --retries=3 --start-period=10s \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8080/healthcheck').read()"

CMD ["python", "app.py"]
