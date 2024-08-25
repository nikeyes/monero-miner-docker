FROM python:3.12.5-alpine3.20

LABEL owner="Jorge Castro" maintainer="nikey_es@yahoo.es"

RUN apk add --no-cache curl

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=on \
    PIP_DISABLE_PIP_VERSION_CHECK=on

RUN addgroup -S appuser && \
    adduser -S -G appuser -s /sbin/nologin -g "appuser user" appuser  
USER appuser

WORKDIR /app

COPY --chown=appuser:appuser app/requirements.txt .
RUN pip install --require-hashes --only-binary :all: --no-cache-dir -r requirements.txt

COPY --chown=appuser:appuser app .

# Redundat, but it's a good practice to avoid permission issues if the files changed at the copy moment
RUN chown -R appuser:appuser /app

EXPOSE 3380

ENTRYPOINT ["python"]
CMD ["/app/p2pool_statistics.py"]
