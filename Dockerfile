FROM golang:1.22-alpine AS builder
WORKDIR /app
RUN go install github.com/fdmomtaz/SQLChart@latest

FROM alpine
COPY --from=builder /go/bin/sqlchart /usr/local/bin/sqlchart
# 不再 COPY your.db，如果你需要动态挂载 DB 文件可使用 -v 或 CMD 参数
EXPOSE 8080
CMD ["sqlchart", "-db", "/app/db.db"]
