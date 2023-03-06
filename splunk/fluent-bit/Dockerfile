FROM ubuntu:latest



RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install curl gpg -y
RUN curl https://raw.githubusercontent.com/fluent/fluent-bit/master/install.sh | sh


CMD /opt/fluent-bit/bin/fluent-bit -c /opt/fluent-bit/fluent-bit.conf