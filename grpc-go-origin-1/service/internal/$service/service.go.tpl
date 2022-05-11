// Package {{ index . "serviceName" }} provides {{ index . "serviceName" }} logic implement
package {{ index . "serviceName" }}

import (
	"fmt"
)

// {{ index . "serviceCamelCase" }}
type {{ index . "serviceCamelCase" }} struct{
}

// NewService
func NewService() *{{ index . "serviceCamelCase" }} {
	service := &{{ index . "serviceCamelCase" }} {
		// init custom fileds
	}
	return service
}

func (s *{{ index . "serviceCamelCase" }}) Helloworld() {
	fmt.Printf("Hello World!\n")
	// implement business logic here ...
	// ...
	return
}