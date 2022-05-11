## grpc-go目录

参考：[https://github.com/golang-standards/project-layout/blob/master/README_zh.md](https://github.com/golang-standards/project-layout/blob/master/README_zh.md)

 ```
 .
├── .sdd # 调试目录
│   └── project_config.yaml # 创建project时，根据layout_config.yaml生成，用与持久化基础信息和本地容器调试使用
├── build # 构建相关
│   ├── build.sh # 构建指定服务的二进制程序
│   ├── services
│   │   ├── server1
│   │   │   └── ci # 流水线
│   │   │       └── ci-pipeline.yaml
│   │   └── server2
│   │       └── ci # 流水线
│   │           └── ci-pipeline.yaml
│   ├── custom # 不同服务的自定义构建，可替换默认的方式
│   │   ├── server1
│   │   │   └── Dockerfile
│   │   └── server2
│   │       └── Dockerfile
│   ├── Dockerfile # 构建镜像使用
│   └── assets # 打包到镜像里的文件
│       └── health_check.sh
├── cmd # 程序入口，不要在这个目录放置太多代码
│   ├── server1 # 服务1
│   │   ├── client # 每个service有一个client，用与和server测试
│   │   │   └── main.go # service1客户端的main.go
│   │   ├── main.go # service1服务端的main.go
│   │   ├── grpc.yaml # 如果grpc.yaml不分环境，将这个配置跟二进制程序一次打包
│   └── server2 # 服务2
│       ├── client # 每个service有一个client，用与和server测试
│       │   └── main.go # service2客户端的main.go
│       ├── main.go # service2服务端的main.go
│       └── grpc.yaml # 如果grpc.yaml不分环境，将这个配置跟二进制程序一次打包
├── internal # 服务内部的业务逻辑
│   ├── pkg # 仓库内使用公共包
│   │   └── README.md
│   └── services # 业务接口逻辑入口
│       ├── server1 # 服务的接口逻辑
│       │   └── greet.go # service为greet的接口
│       └── server2
│           └── greet.go
├── go.mod # 依赖管理
├── pkg # 给仓库外部使用的公共包
│   └── README.md
├── README.md # 项目的说明文档
└── scripts # 公共脚本，如格式化等
    └── fmt.sh
 ```

 另外自动生成的`README.md`内容包含如何构建-部署-查看可观测数据等

