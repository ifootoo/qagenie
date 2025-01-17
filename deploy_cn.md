# 安装docker （ubuntu系统）
## 更新包列表
```bash
sudo apt update
```
## 安装docker
```bash
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```
## 查看docker 是否安装成功
```bash
sudo systemctl status docker
```

# 一键部署
## 下载
```
git clone https://github.com/ifootoo/qagenie.git
```

## 启动docker
```bash
cd qagenie
sudo docker compose up -d
```
## 初始化基础数据（等页面setup页面加载出来再运行） 
```bash
sh setup.sh
```

默认账户信息：

```
hello@ifootoo.com / admin  /  QA123456
```
你可以根据需要修改 `setup.sh` 文件。

# 使用
使用浏览器访问 http://localhost 开始使用。
