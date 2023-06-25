o '=====结束运行====='

cd docker-compose

echo '=====结束运行mogu_gateway====='

docker-compose -f mogu_gateway.yml down

echo '=====结束运行mogu_admin====='

docker-compose -f mogu_admin.yml down

echo '=====结束运行mogu_picture====='

docker-compose -f mogu_picture.yml down

echo '=====结束运行mogu_search====='

docker-compose -f mogu_search.yml down

echo '=====结束运行mogu_sms====='

docker-compose -f mogu_sms.yml down

echo '=====结束运行mogu_monitor====='

docker-compose -f mogu_monitor.yml down

echo '=====结束运行mogu_web====='

docker-compose -f mogu_web.yml down
