#!/usr/bin/env bash

echo '======================'
echo '=====开始运行后台====='
echo '======================'

echo '=====开始运行mogu_monitor====='
docker-compose -f ../yaml/mogu_gateway.yml up -d

echo '=====开始运行mogu_admin====='
docker-compose -f ../yaml/mogu_admin.yml up -d

echo '=====开始运行mogu_picture====='
docker-compose -f ../yaml/mogu_picture.yml up -d

echo '=====开始运行mogu_sms====='
docker-compose -f ../yaml/mogu_sms.yml up -d

echo '=====开始运行mogu_web====='
docker-compose -f ../yaml/mogu_web.yml up -d

echo '=====开始运行mogu_search====='
docker-compose -f ../yaml/mogu_search.yml up -d

echo '=====开始运行mogu_monitor====='
docker-compose -f ../yaml/mogu_monitor.yml up -d

echo '执行完成 日志目录: ./log'


echo '======================'
echo '=====开始运行前台====='
echo '======================'

echo '=====开始运行vue_mogu_admin====='
docker-compose -f ../yaml/vue_mogu_admin.yml up -d


echo '=====开始运行vue_mogu_web====='
docker-compose -f ../yaml/vue_mogu_web.yml up -d

echo '======================================================'
echo '=====所有服务已经启动【请检查是否存在错误启动的】====='
echo '======================================================'
