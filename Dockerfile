FROM ubuntu:latest
LABEL authors="bednar"

ENTRYPOINT ["top", "-b"]
