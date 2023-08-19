# docker buildx build --build-arg PIXLET_VERSION=0.28.0 -f push/standard/Dockerfile -t pixlet_standard_push .
# docker run -p 5000:5000 --name Pixlet_Push pixlet_standard_push

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
    curl tar python3 py3-pip

# Add shortcuts to .bashrc so if/when user enters container, they're loaded
RUN echo "#!/bin/bash" >> /root/.bashrc
RUN echo "" >> /root/.bashrc
RUN echo "export PATH=$PATH:/pixlet" >> /root/.bashrc

# Copy Python server files into container
# Files stored in hassio directory because HA needs them to be in the same directory as the Dockerfile
COPY /push/hassio/server.py /server/
COPY /push/hassio/requirements.txt /server/
RUN chmod a+x /server/server.py

# Install pixlet binary
RUN mkdir /pixlet
RUN echo "Pixlet version: ${PIXLET_VERSION}, target arch: ${TARGETARCH}"
RUN curl -sSLf -o /pixlet/tmp "https://github.com/tidbyt/pixlet/releases/download/v${PIXLET_VERSION}/pixlet_${PIXLET_VERSION}_linux_${TARGETARCH}.tar.gz"
RUN tar -zxf /pixlet/tmp --directory /pixlet
RUN chmod a+x /pixlet/pixlet
RUN rm /pixlet/tmp

# Install Python dependencies for server
RUN pip3 install -r /server/requirements.txt

# Make the temporary storage directory for flask
RUN mkdir /tmp/flask

EXPOSE 8080

EXPOSE 5000

# Run flask server
CMD ["python3", "/server/server.py"]
