# api-spec-converter

需要将swagger3.0版本的API文档（json）导入到YAPI但是发现公司私有化部署的YAPI只支持swagger2.0, 需要转换一下文档版本，找了下资料说这个工具可以转换。

系统环境：LinuxMint:21

1. 安装

   ```shell
   sudo npm install -g api-spec-converter
   # 需要使用root权限，由于没有给 node 配置全局的环境,可能会遇到找不到 node 命令报错,执行下面（node个人安装目录：/opt/node）
   sudo ln -s /opt/node/bin/node /usr/bin/node
   sudo ln -s /opt/node/lib/node /usr/lib/node
   sudo ln -s /opt/node/bin/npm /usr/bin/npm
   sudo ln -s /opt/node/bin/node-waf /usr/bin/node-waf
   # 测试
   api-spec-converter -h
   ```

2. swagger api 文档转换

   ```shell
   api-spec-converter --from=openapi_3 --to=swagger_2 --syntax=json --order=alpha openapi3.json > swagger2.json
   ```






