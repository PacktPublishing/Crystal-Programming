package main

import (
	"io"
	"net/http"
)

func hello(w http.ResponseWriter, req *http.Request) {
	w.Header().Add("Content-Type", "text/plain")
	io.WriteString(w, "Hello World!")
}

func main() {
	http.HandleFunc("/", hello)
	http.ListenAndServe(":8090", nil)
}
