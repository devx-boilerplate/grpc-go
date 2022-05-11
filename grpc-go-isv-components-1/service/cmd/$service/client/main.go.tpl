package main

import (
	"context"
	"log"
	"time"

	pb "{{ index . "goPackage" }}"
	"github.com/skema-dev/skema-go/grpcmux"
)

func main() {
    // create conn according to grpc.yaml
	conn, err := grpcmux.GetConn()
	if err != nil {
		log.Fatalf("Get conn error: %v", err)
	}

	client := pb.New{{ index . "serverNameCamelCase" }}Client(conn)
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
	log.Printf(replyName+" from server: %v\n", reply)
}