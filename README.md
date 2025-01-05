# QA Genie Lite
This is QA Genie Lite version, which is focus on local agents building for private and enterprise support. 

Any user could donwload this code and just run the script to start a private agent locally, without connect to any public api. 

# Declare
QA Genie Lite version is composed from all open source code.

## Dependense
* Dify : https://github.com/langgenius/dify
* Ollama : https://github.com/ollama/ollama

## Local Model
* QWen2.5 : https://github.com/QwenLM/Qwen2.5


# How to start 
* Step 1: 
```bash 
git clone https://github.com/ifootoo/qagenie.git
```

* Step 2: 
```bash 
cd qagenie
# use docker-compose to start dify and ollama
docker-compose up -d
```

* Step 3: 
```bash 
# init setup account
sh setup.sh
```

* Step 4: 
visit the website 
```
http://localhost
```
to start using qagenie lite.

## More Information about Deployment
Please refer to the [deploy.md](deploy.md) file and [中文部署](deploy_cn.md) file.

# Professional Version
If you want to use professional version, please contact us.

## Contact
* hello@ifootoo.com
or 
* footootech@gmail.com
