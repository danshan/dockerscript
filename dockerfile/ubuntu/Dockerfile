FROM ubuntu:14.04

RUN     apt-get update

## base tools 
RUN     apt-get install -y -q curl wget telnet
RUN     apt-get install -y -q git build-essential
RUN     apt-get install -y -q unzip
RUN     apt-get install -y -q vim

RUN     mkdir -p /data/downloads

## danshan env
RUN     git clone -q https://github.com/danshan/danshan.env.git /data/downloads/danshan.env
RUN     cp /data/downloads/danshan.env/linux/.bashrc ~
RUN     cp /data/downloads/danshan.env/linux/.vimrc ~
RUN     cp /data/downloads/danshan.env/linux/.screenrc ~

