
$HADOOP_HOME/bin/hdfs namenode -format
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh
$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh --config $HADOOP_CONF_DIR start historyserver
$HBASE_HOME/bin/start-hbase.sh

$HADOOP_HOME/bin/hdfs dfs -mkdir -p /usr/app
$HADOOP_HOME/bin/hdfs dfs -put /home/tezbuild/apache-tez-0.8.2-src/tez-dist/target/tez-0.8.2.tar.gz /usr/app/tez-0.8.2.tar.gz

$HADOOP_HOME/bin/hdfs dfs -mkdir -p /user/hive/warehouse
$HADOOP_HOME/bin/hdfs dfs -chmod g+w /user/hive/warehouse
$HADOOP_HOME/bin/hdfs dfs -mkdir -p /tmp
$HADOOP_HOME/bin/hdfs dfs -chmod g+w /tmp

/usr/bin/mysqld_safe --skip-grant-tables &
schematool -dbType mysql -initSchema 2>/dev/null
