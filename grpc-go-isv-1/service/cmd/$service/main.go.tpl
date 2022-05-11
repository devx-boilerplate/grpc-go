package main

import (
	"log"

	"git.woa.com/devx/skemaloop/grpc-go/grpc"
	"git.woa.com/devx/skemaloop/grpc-go/logging"
	"{{ index . "gitRepo" }}/internal/services/{{ index . "serviceName" }}"
	pb "{{ index . "goPackage" }}"
)

func main() {
	srv := grpc.NewServer()
	srvImp := {{ index . "serviceName" }}.New{{ index . "serviceCamelCase" }}()
	pb.Register{{ index . "serverNameCamelCase" }}Server(srv, srvImp)

	{{- if index . "needRegisterOpenAPI"}}

	ctx, mux, conn := srv.GetGatewayInfo(srvImp, &pb.{{ index . "serverNameCamelCase" }}_ServiceDesc)
    pb.Register{{ index . "serverNameCamelCase" }}HandlerClient(ctx, mux, pb.New{{ index . "serverNameCamelCase" }}Client(conn))
    {{- end}}

	log.Printf("Serving gRPC ...")
	if err := srv.Serve(); err != nil {
		logging.Fatalf("Serve error %v", err.Error())
	}
}
