package main

import (
	"{{ index . "gitRepo" }}/internal/services/{{ index . "serviceName" }}"

	pb "{{ index . "goPackage" }}"
	"github.com/skema-dev/skema-go/grpcmux"
	"github.com/skema-dev/skema-go/logging"

	{{- $Components := index . "components" }}
    {{- if $Components.Database.Db1.Demo }}
	"github.com/skema-dev/skema-go/data"
    {{- end }}

    {{- if $Components.Redis.Db1.Demo }}
	"github.com/skema-dev/skema-go/redis"
    {{- end }}
)

func main() {
    {{- if $Components.Database.Db1.Demo }}
	// init database
	data.InitWithFile("./components.yaml", "database")
	{{- end }}

    {{- if $Components.Redis.Db1.Demo }}
    // init redis
    redis.InitRedisWithConfigFile("./components.yaml", "redis")
    {{- end }}
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
