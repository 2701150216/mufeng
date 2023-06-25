o '=====开始运行后台====='

cd docker-compose


echo '=====开始运行mogu_gateway====='

docker-compose -f mogu_gateway.yml up -d

echo '=====开始运行mogu_admin====='

docker-compose -f mogu_admin.yml up -d

echo '=====开始运行mogu_picture====='

docker-compose -f mogu_picture.yml up -d

echo '=====开始运行mogu_search====='

docker-compose -f mogu_search.yml up -d

echo '=====开始运行mogu_sms====='

docker-compose -f mogu_sms.yml up -d

echo '=====开始运行mogu_monitor====='

docker-compose -f mogu_monitor.yml up -d

echo '=====开始运行mogu_web====='

docker-compose -f mogu_web.yml up -d


echo '执行完成 日志目录mogu_blog_v2/log'
