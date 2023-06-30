echo '=====开始安装中间件环境====='

cd ../doc/docker-compose/yaml


echo '=====开始安装mysql====='

docker-compose -f mysql.yml up -d

echo '=====开始安装nacos====='

docker-compose -f nacos.yml up -d

echo '=====开始安装行redis====='

docker-compose -f redis.yml up -d

echo '=====开始安装rabbitmq====='

docker-compose -f rabbitmq.yml up -d

echo '=====开始安装mogu_data====='

docker-compose -f mogu_data.yml up -d

echo '=====开始安装zipkin====='

docker-compose -f zipkin.yml up -d

echo '=====开始安装sentinel====='

docker-compose -f sentinel.yml up -d

echo '=====开始安装elk====='

docker-compose -f elk.yml up -d

echo '=====开始安装miniio====='

docker-compose -f minio.yml up -d


echo '安装完成 日志目录mogu_blog_v2/log'

