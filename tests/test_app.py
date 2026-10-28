import sys
from pathlib import Path

sys.path.insert(
    0,
    str(Path(__file__).resolve().parents[1] / "app")
)

from app import app


def test_home():
    client = app.test_client()
    response = client.get("/")

    assert response.status_code == 200

    data = response.get_json()
    assert data["application"] == "DevSecOps GitOps Demo"
    assert data["status"] == "running"


def test_health():
    client = app.test_client()
    response = client.get("/health")

    assert response.status_code == 200
    assert response.get_json()["status"] == "healthy"


def test_ready():
    client = app.test_client()
    response = client.get("/ready")

    assert response.status_code == 200
    assert response.get_json()["status"] == "ready"
