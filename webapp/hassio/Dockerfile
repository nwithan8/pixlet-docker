# Comes via Home Assistant Add-On install process inherently
ARG BUILD_FROM

# Use $BUILD_FROM as base image
FROM $BUILD_FROM

# Must define args after FROM:
# https://stackoverflow.com/a/56748289/13343799
# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact

# Comes from Home Assistant Add-On config.json
ARG PIXLET_VERSION

# Comes from Home Assistant Add-On install process inherently
ARG BUILD_ARCH

# Install depenendencies
# curl and tar pre-installed in base image

# Add shortcuts to .bashrc so if/when user enters container, they're loaded
RUN echo "#!/usr/bin/with-contenv bashio" >> /root/.bashrc
RUN echo "" >> /root/.bashrc
RUN echo "export PATH=$PATH:/pixlet" >> /root/.bashrc
RUN echo "export PIXLET_FILES_DIR=/config/addons_config/pixlet" >> /root/.bashrc

# Copy example files into container
COPY /hello_world.star /root/

# Install pixlet binary
RUN mkdir /pixlet
RUN echo "Pixlet version: ${PIXLET_VERSION}, target arch: ${BUILD_ARCH}"
RUN curl -sSLf -o /pixlet/tmp "https://github.com/tidbyt/pixlet/releases/download/v${PIXLET_VERSION}/pixlet_${PIXLET_VERSION}_linux_${BUILD_ARCH}.tar.gz"
RUN tar -zxf /pixlet/tmp --directory /pixlet
RUN chmod a+x /pixlet/pixlet
RUN rm /pixlet/tmp

# Run pixlet web UI
CMD ["/pixlet/pixlet", "serve", "/root/hello_world.star", "-i", "0.0.0.0"]
