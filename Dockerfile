FROM ziglang/zig:latest AS builder
WORKDIR /app
COPY . .
RUN zig build

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/zig-out/bin/your-app .
ENTRYPOINT ["./your-app"]
