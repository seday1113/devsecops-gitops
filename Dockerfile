FROM python:3.13-slim

WORKDIR /app

COPY app/requirements.txt .

RUN python -m pip install --no-cache-dir --upgrade \
    "setuptools>=78.1.1" \
    "urllib3>=2.8.0" \
    "msgpack>=1.2.3" \
    && python -m pip install --no-cache-dir -r requirements.txt \
    && python -m pip check

COPY app/ .

RUN useradd --create-home appuser

USER appuser

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
