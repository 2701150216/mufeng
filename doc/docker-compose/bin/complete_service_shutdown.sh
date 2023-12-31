#!/usr/bin/env bash

echo '=====开始结束运行蘑菇博客服务====='

echo '=====结束运行mogu_admin====='
docker-compose -f ../yaml/mogu_admin.yml down

echo '=====结束运行mogu_picture====='
docker-compose -f ../yaml/mogu_picture.yml down

echo '=====结束运行mogu_sms====='
docker-compose -f ../yaml/mogu_sms.yml down

echo '=====结束运行mogu_web====='
docker-compose -f ../yaml/mogu_web.yml down

echo '=====结束运行mogu_search====='
docker-compose -f ../yaml/mogu_search.yml down

echo '=====结束运行mogu_monitor====='
docker-compose -f ../yaml/mogu_monitor.yml down

echo '=====结束运行mogu_gateway====='
docker-compose -f ../yaml/mogu_gateway.yml down

echo '=========================='
echo '=====结束前台服务运行====='
echo '=========================='

echo '=====结束运行vue_mogu_admin====='
docker-compose -f ../yaml/vue_mogu_admin.yml down


echo '=====结束运行vue_mogu_web====='
docker-compose -f ../yaml/vue_mogu_web.yml down

echo '=============================='
echo '=====所有服务已经结束运行====='
echo '=============================='