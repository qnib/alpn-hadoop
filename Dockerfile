FROM qnib/alpn-jdk8

ENV HADOOP_VER=2.7.2
RUN apk add --update curl bc jq nmap \
 && curl -fsL http://apache.claz.org/hadoop/common/hadoop-${HADOOP_VER}/hadoop-${HADOOP_VER}.tar.gz | tar xzf - -C /opt && mv /opt/hadoop-${HADOOP_VER} /opt/hadoop \
 && rm -rf /tmp/* /var/cache/apk/*
ADD opt/hadoop/etc/hadoop/hadoop-env.sh \
    opt/hadoop/etc/hadoop/mapred-site.xml \
    /opt/hadoop/etc/hadoop/
RUN adduser -D -s /bin/bash hadoop \
 && echo "/opt/hadoop/bin/hdfs getconf -namenodes" >> /root/.bash_history
ADD etc/bashrc.hadoop /etc/
