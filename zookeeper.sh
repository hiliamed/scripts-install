sudo wget http://mirror.cogentco.com/pub/apache/kafka/2.2.0/kafka_2.12-2.2.0.tgz
sudo tar -xvf kafka_2.12-2.2.0.tgz
sudo mv kafka_2.12-2.2.0 kafka



sudo apt install -y default-jdk
java -version

sudo swapoff -a


sudo cat /etc/init.d/zookeeper << 'EOF'


#!/bin/bash
#/etc/init.d/zookeeper
DAEMON_PATH=/home/cloud_user/kafka/bin
DAEMON_NAME=zookeeper
# Check that networking is up.
#[ ${NETWORKING} = "no" ] && exit 0

PATH=$PATH:$DAEMON_PATH

case "$1" in
  start)
        # Start daemon.
        pid=`ps ax | grep -i 'org.apache.zookeeper' | grep -v grep | awk '{print $1}'`
        if [ -n "$pid" ]
          then
            echo "Zookeeper is already running";
        else
          echo "Starting $DAEMON_NAME";
          $DAEMON_PATH/zookeeper-server-start.sh -daemon /home/cloud_user/kafka/config/zookeeper.properties
        fi
        ;;
  stop)
        echo "Shutting down $DAEMON_NAME";
        $DAEMON_PATH/zookeeper-server-stop.sh
        ;;
  restart)
        $0 stop
        sleep 2
        $0 start
        ;;
  status)
        pid=`ps ax | grep -i 'org.apache.zookeeper' | grep -v grep | awk '{print $1}'`
        if [ -n "$pid" ]
          then
          echo "Zookeeper is Running as PID: $pid"
        else
          echo "Zookeeper is not Running"
        fi
        ;;
  *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
esac

exit 0

EOF


sudo chmod +x /etc/init.d/zookeeeper
sudo chown root:root /etc/init.d/zookeeper

sudo update-rc.d zookeeper defaults

sudo service zookeeper start
sudo service zookeeper status



