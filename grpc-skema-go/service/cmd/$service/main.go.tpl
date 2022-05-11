package main

import (
	"{{ index . "gitRepo" }}/internal/services/{{ index . "serviceName" }}"

	pb "{{ index . "goPackage" }}"
	"github.com/skema-dev/skema-go/grpcmux"
	"github.com/skema-dev/skema-go/logging"
)

func main() {
	srv := grpcmux.NewServer()
	srvImp := {{ index . "serviceName" }}.New{{ index . "serviceCamelCase" }}()
	pb.Register{{ index . "serverNameCamelCase" }}Server(srv, srvImp)

	ctx, mux, conn := srv.GetGatewayInfo()
	pb.Register{{ index . "serverNameCamelCase" }}HandlerClient(ctx, mux, pb.New{{ index . "serverNameCamelCase" }}Client(conn))

    logging.Infof("Serving gRPC start...")
	if err := srv.Serve(); err != nil {
		logging.Fatalf("Serve error %v", err.Error())
	}
}
