FROM alpine

RUN apk --no-cache add openssh-client

COPY init.sh /usr/bin/
COPY remote.sh /usr/bin/