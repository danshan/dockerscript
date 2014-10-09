FROM danshan/ubuntu

## jdk 6
RUN     wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.tar.gz -P /tmp
RUN     cd /tmp && tar xzf /tmp/jdk-7u67-linux-x64.tar.gz
RUN     mkdir -p /usr/lib/jvm
RUN     ls -al /tmp
RUN     mv /tmp/jdk1.7.0_67 /usr/lib/jvm/
ENV     JAVA_HOME /usr/lib/jvm/jdk1.7.0_67
ENV     PATH $PATH:$JAVA_HOME/bin
