#!/bin/bash
###################################
#环境变量及程序执行参数
###################################
SERVER=zhidao-oper-car-butler
PINPOINTNAME=car-butler
# 项目启动的端口号，为了检查服务健康状态
PORT=8951

#APP目录
if [ ! -n "$APP_HOME" ]; then
  APP_HOME=$(cd `dirname $0`; pwd)
fi
# JAR名称
APP_JAR=$SERVER-rest/output/*.jar
# 查找进行标识符
APP_NAME=$SERVER
RUN_ENV=
SLEEP_TIME=0s
#JAVA运行参数,根据不同的环境设置不同的值
if [ "$2"x = "dev"x ]; then
    JAVA_OPTS='-server -Xms256m -Xmx256m'
    RUN_ENV=' --spring.profiles.active=dev'
elif [ "$2"x = "test"x ]; then
    JAVA_OPTS='-server -Xms256m -Xmx256m'
    RUN_ENV=' --spring.profiles.active=test'
else
    JAVA_OPTS='-server -Xms1g -Xmx1g'
    RUN_ENV=' --spring.profiles.active=prod'
    SLEEP_TIME=65s
fi
JAVA_OPTS=$JAVA_OPTS' -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath='$APP_HOME'/logs/'
JAVA_OPTS=$JAVA_OPTS' -XX:SurvivorRatio=4 '
JAVA_OPTS=$JAVA_OPTS' -XX:+DisableExplicitGC -XX:+UseParNewGC -XX:+UseConcMarkSweepGC'
JAVA_OPTS=$JAVA_OPTS' -XX:+CMSParallelRemarkEnabled -XX:+UseCMSInitiatingOccupancyOnly'
JAVA_OPTS=$JAVA_OPTS' -XX:CMSInitiatingOccupancyFraction=70 -XX:+PrintGCDetails'
JAVA_OPTS=$JAVA_OPTS' -XX:+PrintGCDateStamps -Xloggc:'$APP_HOME'/logs/gc.log'

#######################################################
#(函数)判断程序是否已启动
#1.使用JDK自带的JPS命令及grep命令组合，准确查找pid
#2.jps 加 l 参数，表示显示java的完整包路径
#3.使用awk，分割出pid ($1部分)，及Java程序名称($2部分)
#######################################################
#初始化psid变量（全局）
psid=0

checkpid() {
  javaps=`jps -l | grep $APP_NAME`
  if [ -n "$javaps" ]; then
    psid=`echo $javaps | awk '{print $1}'`
  else
    psid=0
  fi
}

#######################################################
#(函数)启动程序
#1.首先调用checkpid函数，刷新$psid全局变量
#2.如果程序已经启动（$psid不等于0），则提示程序已启动
#3.如果程序没有被启动，则执行启动命令行
#4.启动命令执行后，再次调用checkpid函数
#5.如果步骤4的结果能够确认程序的pid,则打印[OK]，否则打印[Failed]
#######################################################
start() {
  checkpid

  if [ $psid -ne 0 ]; then
    echo "================================"
    echo "warn: $APP_JAR already started! (pid=$psid)"
    echo "================================"
    exit 1
  else
    ip=`hostname -I`
    ip=${ip:5:10}
    echo -n "Starting $APP_JAR ..."
    echo $JAVA_OPTS
    nohup java $JAVA_OPTS -jar -javaagent:/home/work/pinpoint-agent-1.8.2/pinpoint-bootstrap-1.8.2.jar -Dpinpoint.agentId=${PINPOINTNAME}-${ip} -Dpinpoint.applicationName=${PINPOINTNAME} $APP_JAR ${RUN_ENV} >nohup.out 2>&1 &
    sleep 3s
    checkpid
    if [ $psid -ne 0 ]; then
      # 10分钟部署校验
      for((i=1;i<=300;i++));
      do
        sleep 2s
        httpResult=`curl --connect-timeout 1 -m 1 http://127.0.0.1:$PORT/actuator/health`
        result=$(echo $httpResult | grep '"status":"UP"')
        if [[ "$result" != "" ]]; then
          result1=$(echo $httpResult | grep '"status":"DOWN"')
          if [[ "$result1" != "" ]]; then
            echo $httpResult
            echo '检查失败继续检查'
          else
            echo $httpResult
            echo "[OK] (pid=$psid)"
            echo "将服务设置成上线"
            curl -X "POST" "http://127.0.0.1:$PORT/actuator/service-registry?status=UP" -H "Content-Type: application/vnd.spring-boot.actuator.v2+json;charset=UTF-8"
            exit 0
          fi
        fi
      done
      echo "[启动检查失败]"
      exit 1
    else
      echo "[启动失败]"
      exit 1
    fi
  fi
}

#######################################################
#(函数)停止程序
#1.首先调用checkpid函数，刷新$psid全局变量
#2.如果程序已经启动（$psid不等于0），则开始执行停止，否则，提示程序未运行
#3.使用kill -15 pid命令进行强制杀死进程
#4.如果程序还在运行（$psid不等于0）,则打印[Failed]，否则打印[OK]
#######################################################
stop() {
  checkpid
 
  if [ $psid -ne 0 ]; then
    echo -n "Stopping $APP_JAR ...(pid=$psid) "
    echo "将机器在注册中心标注为不提供服务"
    curl -X "POST" "http://127.0.0.1:$PORT/actuator/service-registry?status=OUT_OF_SERVICE" -H "Content-Type: application/vnd.spring-boot.actuator.v2+json;charset=UTF-8"
    #等待各种缓存中的服务器缓存过期
    sleep $SLEEP_TIME
    curl -X POST http://127.0.0.1:$PORT/actuator/shutdown
    sleep 3s 
    checkpid
    if [ $psid -ne 0 ]; then
      kill -9 $psid
      sleep 2s
      checkpid
      if [ $psid -ne 0 ]; then
         echo "[stop service Failed]"
      else
         echo "[stop service OK] (pid=$psid)"
      fi
    else
      echo "[stop service OK] (pid=$psid)"
    fi
  else
    echo "================================"
    echo "warn: $APP_JAR is not running"
    echo "================================"
  fi
}

#######################################################
#(函数)检查程序运行状态
#1.首先调用checkpid函数，刷新$psid全局变量
#2.如果程序已经启动（$psid不等于0），则提示正在运行并表示出pid
#3.否则，提示程序未运行
#######################################################
status() {
  checkpid

  if [ $psid -ne 0 ];  then
    echo "$APP_JAR is running! (pid=$psid)"
  else
    echo "$APP_JAR is not running"
  fi
}

#######################################################
#(函数)打印系统环境参数
#######################################################
info() {
  checkpid

  echo ""
  echo "****************************"
  echo $(head -n 1 /etc/issue)
  echo $(uname -a)
  echo

  echo $(java -version)
  echo "JAVA_OPTS: $JAVA_OPTS"
  echo
  echo "APP_HOME: $APP_HOME"
  echo "APP_JAR: $APP_JAR"
  echo "APP_PID: $psid"
  echo "****************************"
}

#######################################################
#读取脚本的第一个参数($1)，进行判断
#参数取值范围：{start|stop|restart|status|info}
#如参数不在指定范围之内，则打印帮助信息
#######################################################
case "$2" in
  'dev')
    echo 'dev'
    ;;
  'test')
    echo 'test'
    ;;
  'prod')
    echo 'prod'
    ;;
  *)
    echo "Usage: $1 {dev|test|prod}"
    exit 1
esac
case "$1" in
  'start')
    info
    start
    ;;
  'stop')
    info
    stop
    ;;
  'restart')
    info
    stop
    start
    ;;
  'status')
    status
    ;;
  'info')
    info
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|status|info}"
    exit 1
esac
exit 0
