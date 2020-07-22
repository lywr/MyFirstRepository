# 打包注意顺序,比如common这一类的最先编译
# $0 就是你写的shell脚本本身的名字，$1 是你给你写的shell脚本传的第一个参数，$2 是你给你写的shell脚本传的第二个参数

COMMON=zhidao-oper-car-butler-common
BEAN=zhidao-oper-car-butler-bean
CORE=zhidao-oper-car-butler-core
SDK=zhidao-oper-car-butler-sdk
SERVER=zhidao-oper-car-butler

#echo 打父工程 $SERVER 并deploy到nexus
mvn  -N clean package deploy

echo 打包 $COMMON 并deploy到nexus
cd $COMMON
mvn clean package deploy

echo 打包 $BEAN 并deploy到nexus
cd ../$BEAN
mvn clean package deploy

echo 打包 $CORE 并deploy到nexus
cd ../$CORE
mvn clean package deploy

echo 打包 $CORE 并deploy到nexus
cd ../$SDK
mvn clean package deploy

echo 打包$SERVER
cd ../$SERVER-rest
mvnResult=`mvn clean package -P $1 -Dmaven.test.skip=true`
echo $mvnResult
result=$(echo $mvnResult | grep "BUILD FAILURE")
if [[ "$result" != "" ]]; then
    echo "代码构建失败,可能是版本冲突了"
    exit 1
fi

echo 删除之前的 output 文件夹
rm -rf output
echo 新建 output 文件夹
mkdir output

echo 删除 *-sources.jar
rm -rf target/*-sources.jar

echo 拷贝 $SERVER 到 output 文件夹中
cp target/$SERVER-*.jar output/
echo 拷贝 server.sh脚本 到 output 文件夹中
cp deploy/server.sh output/