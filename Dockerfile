FROM ubuntu:latest

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install openssh-client git curl wget gpg lsb-release jq python3 python3-pip apt-utils -y
RUN wget -q -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list
RUN apt-get update
RUN apt-get install terraform -y
RUN terraform -install-autocomplete
RUN pip3 install checkov --break-system-packages
