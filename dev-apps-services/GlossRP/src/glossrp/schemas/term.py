"""Pydantic models for REST/gRPC payloads."""

from pydantic import BaseModel


class TermResponse(BaseModel):
    term_id: str
    status: str
