FROM jlesage/baseimage-gui:debian-11
ARG APP_NAME=Calibre
ARG APP_VERSION=6.11.0
ARG DOCKER_IMAGE_VERSION=0.0.1

# Install dependencies
RUN add-pkg python3 wget xdg-utils xz-utils libegl1 libopengl0 libxcb-xinerama0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-render-util0 \
    libxkbcommon0 \
    libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev \
    '^libxcb.*-dev' procps

# Set Icon
RUN install_app_icon.sh "https://github.com/kovidgoyal/calibre/raw/master/icons/calibre.png"

# Install calibre
RUN wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin version=$APP_VERSION

# Copy the start script.
COPY startapp.sh /startapp.sh

# Mountable volumes
VOLUME ["/config"]

# Calibre Content Server
EXPOSE 8081