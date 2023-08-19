FROM alpine

ARG BUILD_ARCH
ENV PIXLET_VERSION "0.28.0"

# Download pixlet binary
RUN mkdir /usr/bin/pixlet
RUN curl -sSLf -o /usr/bin/pixlet/tmp "https://github.com/tidbyt/pixlet/releases/download/v${PIXLET_VERSION}/pixlet_${PIXLET_VERSION}_linux_${BUILD_ARCH}.tar.gz"
RUN tar -zxf /usr/bin/pixlet/tmp --directory /usr/bin/pixlet
RUN chmod a+x /usr/bin/pixlet/pixlet
RUN rm /usr/bin/pixlet/tmp

EXPOSE 8080
