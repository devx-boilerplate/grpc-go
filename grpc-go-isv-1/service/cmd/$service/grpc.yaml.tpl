app: %App% # 必填，应用名
server: %Service% # 必填，服务名，在server目录中会被替换
namespace: "{{ $NAMESPACE }}" # 命名空间
port: 8080 # 必填，端口号，grpc多个service可共用一个端口
http_port: 8080 # 选填，http端口号，功能与grpc-gateway一致。如果与port端口相同，则可共用端口号。

# 日志
logging:
  level: debug # 日志等级，有debug/info/warn/error/fatal
  enable_method: true # 打印方法名
  enable_caller: true # 打印调用的文件和行号
  fields: # 每条日志默认增加的字段
    Namespace: "{{ $NAMESPACE }}"
    App: "{{ .app }}"
    Server: "{{ .server }}"
    Region: "{{ $REGION }}"
    IP: "{{ $POD_IP }}"
  method_log: # 打印接口出入参,blacklist为空表示全集，whitelist-blacklist的差集作为判断开启依据
    enable: true # 是否开启
    req_whitelist: ["sayHello"] # 打印请求参数的接口白名单
    req_blacklist: ["method1", "method2"] # 打印请求参数的接口黑名单
    rsp_whitelist: ["sayHello"] # 打印返回参数的接口白名单
    rsp_blacklist: ["method1", "method2"] # 打印返回参数的接口黑名单

  writers: # 日志输出writer，可配置多个，支持console/file
    file: # 输出到文件
      time_unit: day # 支持按year/month/day/hour/minute滚动日志文件
      max_number: 15 # 日志保留的份数
      max_size_mb: 10000  # 日志最大数量，超过后会自动删除最老的日志文件
      log_path: "./logs/{{ .server }}/rpc.log" # 日志保存路径

# http相关
http:
  gateway:
    path: "/" # 网关http服务的path


# 系统错误的定义，用于区分是用户还是系统原因报的错
# 使用whitelist-blacklist即差集来判断是否系统错误
sys_err:
  whitelist: # 白名单，在列表的错误码表示系统错误，为空表示所有大于0的错误码
  - [1, 1000] # 区间[1, 1000]
  - [5000] # 错误码为5000
  blacklist: # 黑名单，在列表的错误码表示不是系统错误
  - [4000, 4999]

# 依赖的中间件等
# dependency:
#   mysql:
#     default: # 实例名，默认为default
#       max_conn: 1000 # 最大连接数
#       source: root:123@tcp(127.0.0.1:3306)/mydb # 访问地址，支持polaris/ip直连等方式
#     readonly:
#       max_conn: 1000 # 最大连接数
#       source: root:123@tcp(127.0.0.1:3306)/mydb # 访问地址，支持polaris/ip直连等方式
#   redis:
#     default:
#       address: "127.0.0.1:6379"
#       db: 0
#   kafka:
#     producer:
#       default:
#         address: "127.0.0.1:9092"
#         topic: topic1 # 主题，不支持多个主题
#     consumer:
#       default:
#         address: "127.0.0.1:9092"
#         topics: "topic1" # 主题，多个使用英文逗号分隔
#         group: group-A1 # 消费组名
#   elasticsearch:
#     default:
#       address: "xxx"