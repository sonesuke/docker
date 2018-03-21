FROM centos:7

RUN yum -y install epel-release openssh-clients rsync wget which java-1.8.0-openjdk-devel sshpass openssh-server

ENV JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk
ENV PATH=$JAVA_HOME/bin:$PATH

# SSH config
COPY ./ssh-config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config
RUN echo "/usr/sbin/sshd" >> ~/.bashrc
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN /usr/bin/ssh-keygen -A

# hadoop setup
RUN wget http://ftp.riken.jp/net/apache/hadoop/common/hadoop-2.8.3/hadoop-2.8.3.tar.gz \
    && tar xf hadoop-2.8.3.tar.gz
ENV HADOOP_HOME=/hadoop-2.8.3
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

# hbase setup
RUN wget http://ftp.jaist.ac.jp/pub/apache/hbase/1.3.1/hbase-1.3.1-bin.tar.gz \
    && tar zxfv hbase-1.3.1-bin.tar.gz
ENV HBASE_HOME=/hbase-1.3.1
ENV PATH=$HBASE_HOME/bin:$PATH

RUN rm -f /hbase-1.3.1/lib/slf4j-log4j12-1.7.5.jar

# tez setup

RUN wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
RUN yum install -y apache-maven protobuf protobuf-compiler bzip2 git npm

RUN adduser tezbuild
USER tezbuild
RUN npm config set strict-ssl false
WORKDIR /home/tezbuild

RUN wget http://ftp.jaist.ac.jp/pub/apache/tez/0.8.2/apache-tez-0.8.2-src.tar.gz \
    && tar xvpf apache-tez-0.8.2-src.tar.gz
RUN cd apache-tez-0.8.2-src \
    && sed -i -e "s|<hadoop.version>2.6.0</hadoop.version>|<hadoop.version>2.8.3</hadoop.version>|g" pom.xml \
    && mvn clean package -DskipTests=true -Dmaven.javadoc.skip=true

USER root
WORKDIR /

RUN mkdir -p /tez-jars/0.8.2 \
    && tar xvzf /home/tezbuild/apache-tez-0.8.2-src/tez-dist/target/tez-0.8.2-minimal.tar.gz -C /tez-jars/0.8.2
RUN rm -f /tez-jars/0.8.2/lib/slf4j-log4j12-1.7.10.jar

# hive setup
RUN wget http://ftp.riken.jp/net/apache/hive/hive-2.3.2/apache-hive-2.3.2-bin.tar.gz && tar xf apache-hive-2.3.2-bin.tar.gz
RUN rm -f /apache-hive-2.3.2-bin/jdbc/hive-jdbc-2.3.2-standalone.jar
RUN rm -f /apache-hive-2.3.2-bin/lib/log4j-slf4j-impl-2.6.2.jar
ENV HIVE_HOME=/apache-hive-2.3.2-bin
ENV PATH=$HIVE_HOME/bin:$PATH

RUN yum -y install mariadb-server
RUN yum -y install mysql-connector-java
RUN ln -s /usr/share/java/mysql-connector-java.jar $HIVE_HOME/lib

# hadoop config
COPY ./core-site.xml /hadoop-2.8.3/etc/hadoop/core-site.xml
COPY ./hdfs-site.xml /hadoop-2.8.3/etc/hadoop/hdfs-site.xml
COPY ./mapred-site.xml /hadoop-2.8.3/etc/hadoop/mapred-site.xml
COPY ./yarn-site.xml /hadoop-2.8.3/etc/hadoop/yarn-site.xml
COPY ./hadoop-env.sh /hadoop-2.8.3/etc/hadoop/hadoop-env.sh
COPY ./hbase-site.xml /hbase-1.3.1/conf/hbase-site.xml
COPY ./slaves /hadoop-2.8.3/etc/hadoop/slaves
COPY ./tez-site.xml /hadoop-2.8.3/etc/hadoop/tez-site.xml
COPY ./hive-site.xml /apache-hive-2.3.2-bin/conf/hive-site.xml

COPY ./start.sh /start.sh
RUN chmod +x /start.sh

COPY ./stop.sh /stop.sh
RUN chmod +x /start.sh
