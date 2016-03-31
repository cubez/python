FROM cubez/base
MAINTAINER cubez <cubez@cubez.nl>

# Variables
ENV PACKAGES bash curl python3
ENV PYTHON_VERSION 3.5

# Install packages
RUN apk --no-cache add $PACKAGES && \
    apk add --no-cache --virtual=build-dependencies wget ca-certificates && \
    wget "https://bootstrap.pypa.io/get-pip.py" -O /dev/stdout | python3 && \
    apk del build-dependencies

# Copy root files
COPY rootfs /

# Define mountable directories
VOLUME ["/app"]

# Set working directory
WORKDIR /app

# Make some useful symlinks that are expected to exist
RUN cd /usr/bin && \
    ln -sf easy_install-$PYTHON_VERSION easy_install && \
    ln -sf idle$PYTHON_VERSION idle && \
    ln -sf pydoc$PYTHON_VERSION pydoc && \
    ln -sf python$PYTHON_VERSION python && \
    ln -sf python-config$PYTHON_VERSION python-config && \
    ln -sf pip$PYTHON_VERSION pip