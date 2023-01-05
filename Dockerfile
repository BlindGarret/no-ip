FROM alpine:3.17
RUN apk --update upgrade \
    && apk add libc6-compat expect \
    && rm -rf /var/cache/apk
ADD https://www.noip.com/client/linux/noip-duc-linux.tar.gz /downloads/
RUN mkdir /app \
    && mkdir /test \
    && cd downloads \
    && tar -xf /downloads/noip-duc-linux.tar.gz noip-2.1.9-1/binaries/noip2-x86_64 \
    && mv /downloads/noip-2.1.9-1/binaries/noip2-x86_64 /app \
    && rm -rf /downloads \
    && chmod +x /app/noip2-x86_64
COPY ./build-config.exp /app/build-config.exp
COPY ./mainloop.sh /app/mainloop
CMD ["sh", "/app/mainloop"]
