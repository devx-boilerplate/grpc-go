## grpc-go目录

参考：[https://github.com/golang-standards/project-layout/blob/master/README_zh.md](https://github.com/golang-standards/project-layout/blob/master/README_zh.md)

 ```
 .
├── .sdd # 调试目录
│   └── project_config.yaml # 创建project时，根据layout_config.yaml生成，用与持久化基础信息和本地容器调试使用
├── cmd # 程序入口，不要在这个目录放置太多代码
│   ├── server1 # 服务1
│   │   ├── client # 每个service有一个client，用与和server测试
│   │   │   └── main.go # service1客户端的main.go
│   │   ├── main.go # service1服务端的main.go
│   │   ├── grpc.yaml # 如果grpc.yaml不分环境，将这个配置跟二进制程序一次打包
│   │   └── components.yaml # 数据库配置文件
│   └── server2 # 服务2
│       ├── client # 每个service有一个client，用与和server测试
│       │   └── main.go # service2客户端的main.go
│       ├── main.go # service2服务端的main.go
│       ├── grpc.yaml # 如果grpc.yaml不分环境，将这个配置跟二进制程序一次打包
│       └── components.yaml # 数据库配置文件
├── internal # 服务内部的业务逻辑
│   ├── pkg # 仓库内使用公共包
│   │   └── README.md
│   └── services # 业务接口逻辑入口
│       ├── server1 # 服务的接口逻辑
│       │   ├──dao
│       │   │  └── userDao.go # 集中user表操作数据库的方法
│       │   ├──model # 数据库表结构的struct
│       │   │  └── user.go # user表的struct描述
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

