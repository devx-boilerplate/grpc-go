package main

import (
	"git.woa.com/grpc/grpc-go/grpc"
	"git.woa.com/grpc/grpc-go/logging"
	"{{ .GitRepo }}/internal/service/{{ .Service }}"
	pb "{{ .GoPackage }}"
)

func main() {
	srv := grpc.NewServer()
	srvImp := {{ .Service }}.New{{ .ServiceCamelCase }}()
	pb.Register{{ .ServerName }}Server(srv, srvImp)

	if err := srv.Serve(); err != nil {
		logging.Fatalf("Serve error %v", err.Error())
	}
}
