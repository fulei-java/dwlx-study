#!/bin/sh

# 变量
CURRENT_DATE=$(date +%Y%m%d)
WORK_DIR=/home/data/dwlx-study
DEPLOY_DIR=/home/data/dwlx-study/deploy
BACKUP_DIR=/home/data/dwlx-study/backup
JAR_NAME=dwlx-study-dev.jar

echo " >>> 1. 备份Jar文件"
cd $WORK_DIR

if [ -f "$JAR_NAME" ]; then
  mv $JAR_NAME $BACKUP_DIR/$CURRENT_DATE"-"$JAR_NAME
fi

# 判断部署的文件是否存在
if [ -f "$DEPLOY_DIR/$JAR_NAME" ]; then
  cp $DEPLOY_DIR/$JAR_NAME $WORK_DIR

  echo " >>> 2. 关闭Java应用"
  PROCESS_ID=$(ps -ef|grep java|grep -v grep|grep $JAR_NAME|awk '{print $2}')
  echo " >>>    关闭Java应用进程ID: $PROCESS_ID"
  if [ -n "$PROCESS_ID" ]; then
    kill -9 $PROCESS_ID
  fi

  echo " >>> 3. 启动Java应用 $JAR_NAME"
  nohup java -jar $JAR_NAME --logging.config=./logback-spring.xml > /dev/null 2>&1 &

  echo " >>> 4. 部署成功"
else
  echo " >>> $DEPLOY_DIR/$JAR_NAME 不存在"
fi
