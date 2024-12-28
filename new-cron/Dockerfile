# Use your favorite image
FROM debian:stable-slim
ARG S6_OVERLAY_VERSION=3.2.0.2

RUN apt-get update && apt-get install -y xz-utils
# RUN echo "daemon off;" >> /etc/nginx/nginx.conf
# CMD ["/usr/sbin/nginx"]
CMD ["/bin/bash"]

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-symlinks-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-symlinks-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-symlinks-arch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-symlinks-arch.tar.xz

ENV LANG='en_GB.UTF-8'                   \
  LANGUAGE='en_GB.UTF-8'               \
  TERM='xterm'                         \
  S6_LOGGING="1"                       \
  S6_VERBOSITY="0"                     \
  S6_CMD_WAIT_FOR_SERVICES_MAXTIME="0" \
  TZ="Europe/London"


ENTRYPOINT ["/init"]