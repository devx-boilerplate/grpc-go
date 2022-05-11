// Package {{ .Service }} provides {{ .Service }} logic implement
package {{ .Service }}

import (
	"context"

	pb "{{ .GoPackage }}"
)

// {{ .ServiceCamelCase }}
type {{ .ServiceCamelCase }} struct{
{{- range .Services}}
{{- $ServiceName := .Name }}
{{- $ServiceName := $ServiceName }}
    pb.Unimplemented{{ $ServiceName }}Server
{{- end}}
}

// New{{ .ServiceCamelCase }} 建议使用NewXXX方式来返回实现类，实现类名以小写字母开头
func New{{ .ServiceCamelCase }}() *{{ .ServiceCamelCase }} {
	svr := &{{ .ServiceCamelCase }}{
		// init custom fileds
	}
	// go cron()
	return svr
}

// func cron() {
// 	time.Sleep(time.Second * 10)

// 	client := pb.New{{ .ServerName }}Client(grpc.DefaultConn)
// 	for range time.NewTicker(time.Second * 30).C {
// 		ctx := context.Background()
// 		ctx = metadata.AppendToOutgoingContext(ctx, "x-grpc-metrics-caller", "cron/client")
// 		startTime := time.Now()
// 		rsp, err := client.SayHello(ctx, &pb.HelloRequest{Msg: "bob"})
// 		logging.Debugf(ctx, "rsp is %v %v, cost is %dms", rsp, err, time.Since(startTime)/1e6)
// 	}
// }



{{- range .Services}}
{{- $ServiceName := .Name }}
{{- $ServiceName := $ServiceName }}
  {{- range .RPC}}
// {{ .Name }}
func (s *{{ $.ServiceCamelCase }}) {{ .Name }}(ctx context.Context, req *pb.{{ .RequestType }}) (rsp *pb.{{
.ResponseType }},err error) {
	// implement business logic here ...
	// ...
	return rsp,err
}
  {{- end}}    
{{- end}}


