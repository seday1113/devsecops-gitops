# Stage 1: Build dependencies
FROM python:3.13-slim AS builder

WORKDIR /build

COPY app/requirements.txt .

RUN python -m pip install \
    --prefix=/install \
    -r requirements.txt

# Stage 2: Runtime image
FROM python:3.13-slim

WORKDIR /app

COPY --from=builder /install /usr/local

COPY app/ .

# Remove pip and its vendored libraries from runtime
RUN python -m pip uninstall -y pip

RUN useradd --create-home appuser

USER appuser

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
