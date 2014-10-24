FROM danshan/java7

## zookeeper 3.4.6
RUN     wget http://mirrors.cnnic.cn/apache/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz -P /tmp
RUN     cd /tmp && tar xzf /tmp/zookeeper-3.4.6.tar.gz
RUN     mv /tmp/zookeeper-3.4.6 /data/tools
ENV     ZK_HOME /data/tools/zookeeper-3.4.6
RUN     cd $ZK_HOME/conf && cp zoo_sample.cfg zoo.cfg

# change dataDir
ENV     ZK_DATA /data/apps/zookeeper
RUN     mkdir -p $ZK_DATA
RUN     cd $ZK_HOME/conf && sed -i "s ^dataDir=.*$ dataDir=$ZK_DATA g" zoo.cfg 
RUN     cat $ZK_HOME/conf/zoo.cfg
