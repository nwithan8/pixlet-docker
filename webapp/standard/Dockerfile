# docker buildx build --build-arg PIXLET_VERSION=0.28.0 -f webapp/standard/Dockerfile -t pixlet_standard_webapp .
# docker run -p 8080:8080 --name Pixlet_Push pixlet_standard_webapp

# Use alpine as base image
FROM alpine

# Must define args after FROM:
# https://stackoverflow.com/a/56748289/13343799
# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact

# Comes via BuildKit inherently
ARG TARGETARCH

# Comes from CLI
ARG PIXLET_VERSION

# Install depenendencies
RUN \
  apk add --no-cache \
    curl tar

# Add shortcuts to .bashrc so if/when user enters container, they're loaded
RUN echo "#!/bin/bash" >> /root/.bashrc
RUN echo "" >> /root/.bashrc
RUN echo "export PATH=$PATH:/pixlet" >> /root/.bashrc

# Copy example files into container
COPY /hello_world.star /root/

# Install pixlet binary
RUN mkdir /pixlet
RUN echo "Pixlet version: ${PIXLET_VERSION}, target arch: ${TARGETARCH}"
RUN curl -sSLf -o /pixlet/tmp "https://github.com/tidbyt/pixlet/releases/download/v${PIXLET_VERSION}/pixlet_${PIXLET_VERSION}_linux_${TARGETARCH}.tar.gz"
RUN tar -zxf /pixlet/tmp --directory /pixlet
RUN chmod a+x /pixlet/pixlet
RUN rm /pixlet/tmp

EXPOSE 8080

# Run pixlet web UI
CMD ["/pixlet/pixlet", "serve", "/root/hello_world.star", "-i", "0.0.0.0"]
