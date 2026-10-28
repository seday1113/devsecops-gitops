FROM python:3.13-slim AS builder

WORKDIR /build

COPY app/requirements.txt .

RUN python -m pip install --no-cache-dir \
    --prefix=/install \
    -r requirements.txt

FROM python:3.13-slim

WORKDIR /app

COPY --from=builder /install /usr/local

COPY app/ .

RUN useradd --create-home appuser

USER appuser

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
