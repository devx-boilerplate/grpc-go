package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"net"
	"net/http"

	"{{ index . "gitRepo" }}/cmd/{{ index . "serviceName" }}/server"
	pb "{{ index . "goPackage" }}"
	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	"google.golang.org/grpc/reflection"
)

var (
	gRPCPort   = flag.Int("port", 50051, "The port to gRPC server")
	{{- if index . "needRegisterOpenAPI"}}
	gRPCGWPort = flag.Int("gwPort", 8090, "The port to  gRPC-Gateway server")
	{{- end}}
)

func main() {
	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", *gRPCPort))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	srv := grpc.NewServer()
	srvImp := server.NewServer()
	pb.Register{{ index . "serverNameCamelCase" }}Server(srv, srvImp)

	// remove reflection for prod
	reflection.Register(srv)

	{{- if index . "needRegisterOpenAPI"}}
    log.Printf("Serving gRPC on localhost%v", fmt.Sprintf(":%d", *gRPCPort))
	go func() {
		log.Fatalln(srv.Serve(lis))
	}()

	conn, err := grpc.DialContext(
		context.Background(),
		"localhost"+fmt.Sprintf(":%d", *gRPCPort),
		grpc.WithBlock(),
		grpc.WithTransportCredentials(insecure.NewCredentials()),
	)
	if err != nil {
		log.Fatalln("Failed to dial server:", err)
	}
	gwmux := runtime.NewServeMux()
	// Register Greeter
	err = pb.Register{{ index . "serverNameCamelCase" }}Handler(context.Background(), gwmux, conn)
	if err != nil {
		log.Fatalln("Failed to register gateway:", err)
	}

	gwServer := &http.Server{
		Addr:    fmt.Sprintf(":%d", *gRPCGWPort),
		Handler: gwmux,
	}

	log.Println("Serving gRPC-Gateway on http://localhost" + fmt.Sprintf(":%d", *gRPCGWPort))
	log.Fatalln(gwServer.ListenAndServe())

    {{ else }}
    log.Printf("Serving gRPC on localhost%v", fmt.Sprintf(":%d", *gRPCPort))
	if err := srv.Serve(lis); err != nil {
		log.Fatalf("Serve error %v", err)
	}
    {{- end}}
}
