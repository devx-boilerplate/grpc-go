package main

import (
	"context"
	"log"
	"time"

	pb "{{ index . "goPackage" }}"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

const (
	Address     = "localhost:50051"
)

func main() {
	// Set up a connection to the server.
	conn, err := grpc.Dial(Address, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatalf("Did not connect: %v", err)
	}
	defer conn.Close()
	c := pb.New{{ index . "serverNameCamelCase" }}Client(conn)

	// Contact the server and print out its response.
	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	defer cancel()

{{- range index . "services" }}
  {{- range .RPC}}

    // {{ .LowCaseName }}Reply
	{{ .LowCaseName }}Reply, err := c.{{ .Name }} (ctx, &pb.{{ .RequestType }} {
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