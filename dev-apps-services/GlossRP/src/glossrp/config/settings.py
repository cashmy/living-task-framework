"""Application settings loaded from environment variables."""

from pathlib import Path
from functools import lru_cache
from typing import Literal

from pydantic import Field
from pydantic_settings import BaseSettings


class AppSettings(BaseSettings):
    """Centralized settings for both REST and gRPC services."""

    rest_host: str = Field("0.0.0.0", alias="REST_HOST")
    rest_port: int = Field(8080, alias="REST_PORT")
    grpc_host: str = Field("0.0.0.0", alias="GRPC_HOST")
    grpc_port: int = Field(50051, alias="GRPC_PORT")

    database_url: str = Field(..., alias="DATABASE_URL")
    db_pool_size: int = Field(10, alias="DB_POOL_SIZE")

    termspec_directory: Path = Field(Path("termspec-staging"), alias="TERMSPEC_DIRECTORY")

    enable_category_curation: bool = Field(False, alias="ENABLE_CATEGORY_CURATION_ENDPOINTS")
    allow_raw_category_inspection: bool = Field(False, alias="ALLOW_RAW_CATEGORY_INSPECTION")

    log_level: Literal["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"] = Field(
        "INFO", alias="LOG_LEVEL"
    )

    model_config = {
        "env_file": ".env",
        "env_file_encoding": "utf-8",
        "extra": "ignore",
    }


@lru_cache(maxsize=1)
def get_settings() -> AppSettings:
    """Return cached settings instance."""

    return AppSettings()  # type: ignore[arg-type]
