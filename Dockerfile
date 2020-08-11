# adapted from Dockerfile for https://github.com/adnanh/webhook
FROM        node:12-stretch 
MAINTAINER  brendan tang <b@brendantang.net>
WORKDIR     /etc/webhook
RUN         apt-get update
RUN         apt-get install webhook
VOLUME      ["/etc/webhook"]
EXPOSE      9000
ENTRYPOINT  ["/usr/bin/webhook"]
