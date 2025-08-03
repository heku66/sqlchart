# 第一阶段：构建 sqlchart 可执行文件
FROM golang:1.22-alpine AS builder

RUN apk add --no-cache git
WORKDIR /app
RUN go install github.com/fdmomtaz/SQLChart@latest

# 第二阶段：极简运行环境
FROM alpine

RUN apk add --no-cache sqlite-libs ca-certificates
COPY --from=builder /go/bin/sqlchart /usr/local/bin/sqlchart

WORKDIR /data
EXPOSE 8080

# 注意：不包含 your.db，靠挂载提供
CMD ["sh", "-c", "sqlchart -db /data/db.db -addr :8080"]
