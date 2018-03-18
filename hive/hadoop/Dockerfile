FROM centos:7

RUN yum -y install epel-release openssh-clients rsync wget which java-1.8.0-openjdk-devel sshpass openssh-server
RUN wget http://ftp.riken.jp/net/apache/hadoop/common/hadoop-2.8.3/hadoop-2.8.3.tar.gz && tar xf hadoop-2.8.3.tar.gz


ENV JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk
ENV HADOOP_HOME=/hadoop-2.8.3
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$JAVA_HOME/bin:$PATH

# hadoop config
COPY ./core-site.xml /hadoop-2.8.3/etc/hadoop/core-site.xml
COPY ./hdfs-site.xml /hadoop-2.8.3/etc/hadoop/hdfs-site.xml
COPY ./mapred-site.xml /hadoop-2.8.3/etc/hadoop/mapred-site.xml
COPY ./yarn-site.xml /hadoop-2.8.3/etc/hadoop/yarn-site.xml
COPY ./hadoop-env.sh /hadoop-2.8.3/etc/hadoop/hadoop-env.sh
COPY ./slaves /hadoop-2.8.3/etc/hadoop/slaves

# SSH config
COPY ./ssh-config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

RUN echo "/usr/sbin/sshd" >> ~/.bashrc
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN /usr/bin/ssh-keygen -A

COPY ./start.sh /start.sh
RUN chmod +x /start.sh
