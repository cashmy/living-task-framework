"""FastAPI application exposing GlossRP REST endpoints."""

from fastapi import Depends, FastAPI

from glossrp.config import get_settings
from glossrp.db import get_session
from glossrp.retrieval import RetrievalEngine
from glossrp.schemas import TermResponse
from glossrp.storage import StorageAdapter

app = FastAPI(title="GlossRP REST API", version="0.1.0")


def get_retrieval_engine(session=Depends(get_session)) -> RetrievalEngine:
    return RetrievalEngine(StorageAdapter(session))


@app.get("/healthz")
async def healthcheck() -> dict[str, str]:
    settings = get_settings()
    return {"status": "ok", "log_level": settings.log_level}


@app.get("/terms/{term_id}", response_model=TermResponse)
async def get_term(
    term_id: str, engine: RetrievalEngine = Depends(get_retrieval_engine)
) -> TermResponse:
    data = await engine.single_term(term_id)
    return TermResponse(**data)
