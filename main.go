package main

import (
	"fmt"
	"net"
	"net/http"
	"time"
)

func main() {

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		ifaces, _ := net.Interfaces()

		for _, i := range ifaces {
			addrs, _ := i.Addrs()
			for _, addr := range addrs {
				var ip net.IP
				switch v := addr.(type) {
				case *net.IPNet:
					ip = v.IP
				case *net.IPAddr:
					ip = v.IP
				}

				if ip.To4() != nil && !ip.IsLoopback() {
					fmt.Fprintf(w, "%s:\t%v\n", i.Name, ip)
				}
			}
		}
	})

	srv := &http.Server{
		Addr:         ":80",
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 10 * time.Second,
	}

	fmt.Println("server started")
	srv.ListenAndServe()
}
