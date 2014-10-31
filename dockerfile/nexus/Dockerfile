FROM danshan/java7

# nexus latest
RUN     wget -O /tmp/nexus.tar.gz http://www.sonatype.org/downloads/nexus-latest-bundle.tar.gz

ENV     NEXUS_DATA /data/nexus
ENV     NEXUS_WORK /opt/nexus

RUN     mkdir -p $NEXUS_DATA $NEXUS_WORK

RUN     tar -zxvf /tmp/nexus.tar.gz -C $NEXUS_WORK --strip-components=1
RUN     useradd --user-group --system --home-dir $NEXUS_WORK nexus
RUN     chown -R nexus:nexus $NEXUS_WORK $NEXUS_DATA
RUN     cd $NEXUS_WORK/conf && sed -i "s ^nexus-work=.*$ nexus-work=`echo $NEXUS_DATA` g" nexus.properties
RUN     cat $NEXUS_WORK/conf/nexus.properties

USER nexus

EXPOSE 8081

VOLUME $NEXUS_DATA

CMD ["$NEXUS_WORK/bin/nexus","console"]