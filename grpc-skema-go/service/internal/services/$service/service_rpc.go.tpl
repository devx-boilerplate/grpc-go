// Package {{ index . "serviceName" }} provides {{ index . "serviceName" }} logic implement
package {{ index . "serviceName" }}

import (
	"context"
	"log"

	pb "{{ index . "goPackage" }}"
)

// {{ index . "serviceCamelCase" }}
type {{ index . "serviceCamelCase" }} struct{
{{- range index . "services" }}
{{- $ServiceName := .Name }}
{{- $ServiceName := $ServiceName }}
    pb.Unimplemented{{ $ServiceName }}Server
{{- end}}
}

// New{{ index . "serviceCamelCase" }} 建议使用NewXXX方式来返回实现类，实现类名以小写字母开头
func New{{ index . "serviceCamelCase" }}() *{{ index . "serviceCamelCase" }} {
	svr := &{{ index . "serviceCamelCase" }}{
		// init custom fileds
	}
	// go cron()
	return svr
}

// func cron() {
// 	time.Sleep(time.Second * 10)

// 	client := pb.New{{ index . "serverNameCamelCase" }}Client(grpc.DefaultConn)
// 	for range time.NewTicker(time.Second * 30).C {
// 		ctx := context.Background()
// 		ctx = metadata.AppendToOutgoingContext(ctx, "x-grpc-metrics-caller", "cron/client")
// 		startTime := time.Now()
// 		rsp, err := client.SayHello(ctx, &pb.HelloRequest{Msg: "bob"})
// 		logging.Debugf(ctx, "rsp is %v %v, cost is %dms", rsp, err, time.Since(startTime)/1e6)
// 	}
// }

{{- range index . "services" }}
  {{- range .RPC}}

// {{ .Name }}
func (s *{{ .ServiceCamelCase }}) {{ .Name }}(ctx context.Context, req *pb.{{ .RequestType }}) (rsp *pb.{{.ResponseType }},err error) {
	// implement business logic here ...
	// ...

	log.Printf("Received from {{ .Name }} request: %v", req)
	rsp = &pb.{{.ResponseType }}{
		// Msg: "Hello " + req.GetMsg(),
	}
	return rsp,err
}
  {{- end}}    
{{- end}}