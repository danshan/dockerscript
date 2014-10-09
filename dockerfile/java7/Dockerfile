FROM danshan/ubuntu

RUN     mkdir -p /data/tools

## jdk 6
RUN     wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.tar.gz -P /tmp
RUN     cd /tmp && tar xzf /tmp/jdk-7u67-linux-x64.tar.gz
RUN     mkdir -p /usr/lib/jvm
RUN     mv /tmp/jdk1.7.0_67 /usr/lib/jvm/
ENV     JAVA_HOME /usr/lib/jvm/jdk1.7.0_67
ENV     PATH $PATH:$JAVA_HOME/bin

## maven 3.0.5
RUN     wget http://mirror.nus.edu.sg/apache/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz -P /tmp
RUN     cd /tmp && tar xzf /tmp/apache-maven-3.0.5-bin.tar.gz
RUN     mv /tmp/apache-maven-3.0.5 /data/tools
ENV     MAVEN_HOME /data/tools/apache-maven-3.0.5
ENV     PATH $PATH:$MAVEN_HOME/bin

