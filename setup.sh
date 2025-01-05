#!/bin/bash

# 第一个 Docker 容器名称
CONTAINER_NAME_OLLAMA="ollama"  # 替换为你的第一个容器名称

# 拉取模型
sudo docker exec -it "$CONTAINER_NAME_OLLAMA" bash -c "ollama pull bge-m3 && ollama pull qwen2.5"
# 检查是否成功
if [ $? -eq 0 ]; then
  echo "在容器 $CONTAINER_NAME_OLLAMA 拉取模型 完成！"
else
  echo "在容器 $CONTAINER_NAME_OLLAMA 拉取模型 失败！"
  exit 1
fi



SETUP_API_URL="http://localhost/console/api/setup"

# 请求参数
SETUP_REQUEST_BODY='{
    "email": "hello@ifootoo.com",
    "name": "admin",
    "password": "QA123456"
}'

# 使用 curl 发送 POST 请求
echo "Sending setup request to $SETUP_API_URL..."
SETUP_RESPONSE=$(curl -s -X POST -H "Content-Type: application/json" -d "$SETUP_REQUEST_BODY" "$SETUP_API_URL")

# 检查 curl 是否成功
if [ $? -ne 0 ]; then
    echo "Error: Failed to connect to $SETUP_API_URL"
    exit 1
fi

SETUP_RESULT=$(echo "$SETUP_RESPONSE" | jq -r '.result')
# 判断 data 字段是否为 "success"
if [ "$SETUP_RESULT" = "success" ]; then
    echo "管理用户设置成功"
else
    echo "管理用户设置失败"
    exit 1
fi

# API URL
LOGIN_API_URL="http://localhost/console/api/login"

# 请求参数
LOGIN_REQUEST_BODY='{
    "email": "hello@ifootoo.com",
    "password": "QA123456",
    "language": "zh-Hans",
    "remember_me": true
}'

# 使用 curl 发送 POST 请求
echo "Sending login request to $LOGIN_API_URL..."
LOGIN_RESPONSE=$(curl -s -X POST -H "Content-Type: application/json" -d "$LOGIN_REQUEST_BODY" "$LOGIN_API_URL")

# 检查 curl 是否成功
if [ $? -ne 0 ]; then
    echo "Error: Failed to connect to $LOGIN_API_URL"
    exit 1
fi

# 使用 jq 解析 JSON 并提取 data 字段
echo "Parsing response JSON..."
DATA=$(echo "$LOGIN_RESPONSE" | jq -r '.data')
ACCESS_TOKEN=$(echo "$DATA" | jq -r '.access_token')

# 检查 jq 是否成功
if [ $? -ne 0 ]; then
    echo "Error: Failed to parse JSON response."
    exit 1
fi

# 打印 data 字段
echo "access_token field from response:"
echo "$ACCESS_TOKEN"

MODEL_API_URL="http://localhost/console/api/workspaces/current/model-providers/ollama/models"

# 请求参数
LLM_REQUEST_BODY='{
    "model": "qwen2.5",
    "model_type": "llm",
    "credentials": {
        "mode": "chat",
        "context_size": "4096",
        "max_tokens": "4096",
        "vision_support": "false",
        "function_call_support": "false",
        "base_url": "http://ollama:11434"
    },
    "load_balancing": {
        "enabled": false,
        "configs": []
    }
}'

EMBEDDING_REQUEST_BODY='{
    "model": "bge-m3",
    "model_type": "text-embedding",
    "credentials": {
        "context_size": "4096",
        "base_url": "http://ollama:11434"
    },
    "load_balancing": {
        "enabled": false,
        "configs": []
    }
}'

# 使用 curl 发送 POST 请求
LLM_RESPONSE=$(curl -s -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -d "$LLM_REQUEST_BODY" \
    "$MODEL_API_URL")

# 使用 jq 解析 JSON 并提取 data 字段
echo "Parsing response JSON...$LLM_RESPONSE"
LLM_RESULT=$(echo "$LLM_RESPONSE" | jq -r '.result')
# 判断 data 字段是否为 "success"
if [ "$LLM_RESULT" = "success" ]; then
    echo "对话模型设置成功"
else
    echo "对话模型设置失败"
    exit 1
fi

# 使用 curl 发送 POST 请求
EMBEDDING_RESPONSE=$(curl -s -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -d "$EMBEDDING_REQUEST_BODY" \
    "$MODEL_API_URL")

# 使用 jq 解析 JSON 并提取 data 字段
echo "Parsing response JSON...$EMBEDDING_RESPONSE"
EMBEDDING_RESULT=$(echo "$EMBEDDING_RESPONSE" | jq -r '.result')
# 判断 data 字段是否为 "success"
if [ "$EMBEDDING_RESULT" = "success" ]; then
    echo "EMBEDDING模型设置成功"
else
    echo "EMBEDDING模型设置失败"
    exit 1
fi

APPS_API_URL="http://localhost/console/api/apps"

# 请求参数
APPS_REQUEST_BODY='{
    "name": "QAGenie",
    "icon_type": "emoji",
    "icon": "🤖",
    "icon_background": "#FFEAD5",
    "mode": "chat",
    "description": "QAGenie 聊天"
}'

# 使用 curl 发送 POST 请求
APPS_RESPONSE=$(curl -s -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -d "$APPS_REQUEST_BODY" \
    "$APPS_API_URL")

# 使用 jq 解析 JSON 并提取 data 字段
echo "Parsing response JSON...$APPS_RESPONSE"
APPS_RESULT=$(echo "$APPS_RESPONSE" | jq -r '.id')
# 判断 data 字段是否为 "success"
if [ "$APPS_RESULT" ]; then
    echo "APPS设置成功"
else
    echo "APPS设置失败"
    exit 1
fi