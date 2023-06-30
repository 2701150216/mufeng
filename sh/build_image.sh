o '=====开始mvn clean====='
cd ..
mvn clean

echo '=====开始mvn install&&package====='
mvn install -DskipTests=true && mvn package -DskipTests=true


echo '=====开始构建镜像====='

echo '=====开始构建mogu_admin====='
cd mogu_admin
mvn docker:build

cd ..

echo '=====开始构建mogu_gateway====='
cd mogu_gateway

mvn docker:build

cd ..

echo '=====开始构建mogu_monitor====='
cd mogu_monitor

mvn docker:build

cd ..

echo '=====开始构建mogu_picture====='
cd mogu_picture

mvn docker:build

cd ..

echo '=====开始构建mogu_search====='
cd mogu_search

mvn docker:build

cd ..

echo '=====开始构建mogu_sms====='
cd mogu_sms

mvn docker:build

cd ..

echo '=====开始构建mogu_spider====='
cd mogu_spider

mvn docker:build

cd ..

echo '=====开始构建mogu_web====='
cd mogu_web

mvn docker:build

cd ..

echo '=====镜像构建结束====='

echo '=====删除<none>镜像====='
docker rmi $(docker images | grep "none" | awk '{print $3}')
