FROM danshan/java7

RUN     apt-get install -y zip

# jenkins 1.565.3
ENV     JENKINS_VERSION 1.565.3
ENV     JENKINS_WORK /opt/jenkins
ENV     JENKINS_DATA /data/jenkins

RUN     curl -L http://mirrors.jenkins-ci.org/war-stable/$JENKINS_VERSION/jenkins.war -o  /tmp/jenkins.war

RUN     mkdir -p $JENKINS_WORK $JENKINS_DATA
RUN     cp /tmp/jenkins.war $JENKINS_WORK
RUN     useradd -d /home/jenkins -m -s /bin/bash jenkins

COPY    scripts/init.groovy /tmp/WEB-INF/init.groovy.d/tcp-slave-angent-port.groovy
RUN     cd /tmp && zip -g $JENKINS_WORK/jenkins.war WEB-INF/init.groovy.d/tcp-slave-angent-port.groovy && rm -rf /tmp/WEB-INF

COPY scripts/jenkins.sh /usr/local/bin/jenkins.sh
RUN     chmod -R 755 /usr/local/bin/jenkins.sh
RUN     chown -R jenkins $JENKINS_DATA
VOLUME  $JENKINS_DATA

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

USER jenkins

ENTRYPOINT ["/usr/local/bin/jenkins.sh"]