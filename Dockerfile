FROM busybox
COPY swarm_test /swarm_test
EXPOSE 80
CMD ["./swarm_test"]
