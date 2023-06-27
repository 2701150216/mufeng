echo '=====结束运行====='

cd ../doc/docker-compose/yaml


echo '=====结束运行mysql====='

docker-compose -f mysql.yml down

echo '=====结束运行nacos====='

docker-compose -f nacos.yml down

echo '=====结束运行行redis====='

docker-compose -f redis.yml down

echo '=====结束运行rabbitmq====='

docker-compose -f rabbitmq.yml down

echo '=====结束运行mogu_data====='

docker-compose -f mogu_data.yml down

echo '=====结束运行zipkin====='

docker-compose -f zipkin.yml down

echo '=====结束运行sentinel====='

docker-compose -f sentinel.yml down

echo '=====结束运行elk====='

docker-compose -f elk.yml down

echo '=====结束运行miniio====='

docker-compose -f minio.yml down


echo '全部结束运行'

