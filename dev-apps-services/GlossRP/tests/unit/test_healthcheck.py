import pytest
from httpx import ASGITransport, AsyncClient
from fastapi import status

from glossrp.api.rest.main import app


@pytest.mark.asyncio
async def test_healthcheck() -> None:
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as client:
        response = await client.get("/healthz")
    assert response.status_code == status.HTTP_200_OK
    assert response.json()["status"] == "ok"
