package main

import (
	"context"
	"log"
	"time"

	"git.woa.com/devx/skemaloop/grpc-go/grpc"
	pb "{{ index . "goPackage" }}"
)

const (
	Address     = "localhost:8080"
)

func main() {
	grpc.SetServiceAddress("{{ index . "packageName" }}.{{ index . "serverName" }}", Address)
	client := pb.New{{ index . "serverNameCamelCase" }}Client(grpc.DefaultConn)
	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	defer cancel()

{{- range index . "services" }}
  {{- range .RPC}}

    // {{ .LowCaseName }}Reply
	{{ .LowCaseName }}Reply, err := client.{{ .Name }} (ctx, &pb.{{ .RequestType }} {
		// Msg: "world",
	})
	HandleReply("{{ .LowCaseName }}Reply", {{ .LowCaseName }}Reply, err)
	// log.Printf("Greeting: %s", {{ .LowCaseName }}Reply.GetMsg())
  {{- end}}
{{- end}}
}

// HandleReply handle the reply
func HandleReply(replyName string, reply interface{}, err error) {
	if err != nil {
		log.Fatalf("%s could not greet: %v", replyName, err)
	}
	log.Printf(replyName + " from server: %v\n", reply)
}
}