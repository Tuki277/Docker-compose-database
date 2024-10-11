# https://hub.docker.com/_/ubuntu
# using this one instead of openjdk image, so we are in control of the Ubuntu base image
FROM ubuntu:20.04

# disable question when apt get package
ARG DEBIAN_FRONTEND=noninteractive

# build-essential: compilers etc.
# devscripts: make command etc.
# java jdk: android sdk tools require it
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    devscripts \
    openjdk-17-jdk \
    curl \
    unzip

RUN curl -L https://github.com/Kitware/CMake/releases/download/v3.18.1/cmake-3.18.1-Linux-x86_64.sh -o /tmp/cmake-install.sh \
    && chmod u+x /tmp/cmake-install.sh \
    && mkdir /usr/bin/cmake \
    && /tmp/cmake-install.sh --skip-license --prefix=/usr/bin/cmake \
    && rm /tmp/cmake-install.sh

# Install Ninja
RUN curl -L https://github.com/ninja-build/ninja/releases/download/v1.10.2/ninja-linux.zip -o ninja.zip \
    && unzip ninja.zip -d /usr/local/bin \
    && rm ninja.zip


ENV PATH="/usr/bin/cmake/bin:${PATH}"

# Set up Android SDK
ENV ANDROID_HOME=/root/android-sdk
ENV ANDROID_SDK_ROOT=$ANDROID_HOME
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

# Download and install Android SDK Command-line tools
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools && \
    curl -L https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -o cmdline-tools.zip && \
    unzip cmdline-tools.zip -d ${ANDROID_HOME}/cmdline-tools && \
    mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest && \
    rm cmdline-tools.zip

# Accept licenses and install necessary SDK components
RUN mkdir -p ~/.android && touch ~/.android/repositories.cfg && \
    yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" "build-tools;29.0.2" "platforms;android-29"

# Install Android NDK
ENV ANDROID_NDK_HOME=${ANDROID_HOME}/ndk-bundle
RUN curl -L https://dl.google.com/android/repository/android-ndk-r27b-linux.zip -o androidndk.zip && \
    unzip androidndk.zip -d ${ANDROID_HOME} && \
    mv ${ANDROID_HOME}/android-ndk-* ${ANDROID_NDK_HOME} && \
    rm androidndk.zip

# Set up environment variables
ENV CONTAINER=true \
    ANDROID_NDK_PATH=${ANDROID_NDK_HOME} \
    ANDROID_NDK_ROOT=${ANDROID_NDK_HOME}

WORKDIR /root/build