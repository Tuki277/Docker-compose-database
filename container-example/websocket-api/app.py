import asyncio
import json
import socket

from websockets.asyncio.server import serve


async def handler(websocket):
    hostname = socket.gethostname()
    ip = socket.gethostbyname(hostname)
    async for message in websocket:
        await websocket.send(
            json.dumps(
                {
                    "message": "Hello World",
                    "container": "websocket-api",
                    "hostname": hostname,
                    "ip": ip,
                    "echo": message,
                }
            )
        )


async def main():
    async with serve(handler, "0.0.0.0", 8080):
        await asyncio.get_running_loop().create_future()


if __name__ == "__main__":
    asyncio.run(main())
