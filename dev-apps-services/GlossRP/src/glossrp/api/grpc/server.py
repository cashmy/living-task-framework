"""Async gRPC server bootstrap using grpc.aio."""

import asyncio

from grpc import aio

from glossrp.config import get_settings


async def serve() -> None:
    """Start the gRPC server (services wired in future milestones)."""

    settings = get_settings()
    server = aio.server()
    listen_addr = f"{settings.grpc_host}:{settings.grpc_port}"
    server.add_insecure_port(listen_addr)

    # TODO: register generated service implementations once protos are compiled.
    await server.start()
    print(f"gRPC server listening on {listen_addr}")
    await server.wait_for_termination()


def main() -> None:
    asyncio.run(serve())


if __name__ == "__main__":
    main()
