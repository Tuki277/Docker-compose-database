import socket
from concurrent import futures

import grpc

import greeter_pb2
import greeter_pb2_grpc


class Greeter(greeter_pb2_grpc.GreeterServicer):
    def SayHello(self, request, context):
        hostname = socket.gethostname()
        ip = socket.gethostbyname(hostname)
        return greeter_pb2.HelloReply(
            message=f"Hello World, {request.name}",
            container="grpc-api",
            hostname=hostname,
            ip=ip,
        )


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    greeter_pb2_grpc.add_GreeterServicer_to_server(Greeter(), server)
    server.add_insecure_port("0.0.0.0:50051")
    server.start()
    server.wait_for_termination()


if __name__ == "__main__":
    serve()
