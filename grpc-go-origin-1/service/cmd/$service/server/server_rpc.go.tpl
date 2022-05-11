// Package server provides grpc server implement
package server

import (
	"context"
	"log"

	"{{ index . "gitRepo" }}/internal/{{ index . "serviceName" }}"
	pb "{{ index . "goPackage" }}"
)

// {{ index . "serviceCamelCase" }}
type rpc{{ index . "serviceCamelCase" }}Server struct{
{{- range index . "services" }}
{{- $ServiceName := .Name }}
{{- $ServiceName := $ServiceName }}
    pb.Unimplemented{{ $ServiceName }}Server
{{- end}}
}

// NewServer: Create new grpc server instance
func NewServer() pb.{{ index . "serverNameCamelCase" }}Server {
	svr := &rpc{{ index . "serviceCamelCase" }}Server {
		// init custom fileds
	}
	return svr
}

{{- $UserServiceName := index . "serviceName" }}
{{- range index . "services" }}

  {{- range .RPC}}
// {{ .Name }}
func (s *rpc{{ .ServiceCamelCase }}Server) {{ .Name }}(ctx context.Context, req *pb.{{ .RequestType }}) (rsp *pb.{{.ResponseType }},err error) {
	// implement business logic here ...
	// ...

	log.Printf("Received from {{ .Name }} request: %v", req)
	rsp = &pb.{{.ResponseType }}{
		// Msg: "Hello " + req.GetMsg(),
	}

	service := {{ $UserServiceName }}.NewService()
	service.Helloworld()
	return rsp,err
}
  {{- end}}    
{{- end}}
