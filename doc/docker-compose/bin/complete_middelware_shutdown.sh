#!/usr/bin/env bash

echo '=====开始结束运行蘑菇博客中间件====='

echo '=====结束运行portainer可视化工具====='
docker-compose -f ../yaml/portainer.yml down

echo '=====结束运行mysql====='
docker-compose -f ../yaml/mysql.yml down

echo '=====结束运行nacos====='
docker-compose -f ../yaml/nacos.yml down

echo '=====结束运行rabbitmq====='
docker-compose -f ../yaml/rabbitmq.yml down

echo '=====结束运行redis====='
docker-compose -f ../yaml/redis.yml down

echo '=====结束运行mogu_data====='
docker-compose -f ../yaml/mogu_data.yml down

echo '=====结束运行zipkin====='
docker-compose -f ../yaml/zipkin.yml down

echo '=====结束运行sentinel====='
docker-compose -f ../yaml/sentinel.yml down

echo '=====结束运行ELK====='
docker-compose -f ../yaml/elk.yml down

echo '=============================='
echo '=====所有中间件已经结束运行====='
echo '=============================='