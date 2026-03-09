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
RUN mkdir -p $ANDROID_SDK_ROOT/licenses/ \ 
    && echo "8933bad161af4178b1185d1a37fbf41ea5269c55\nd56f5187479451eabf01fb78af6dfcb131a6481e\n24333f8a63b6825ea9c5514f83c2829b004d1fee" > $ANDROID_SDK_ROOT/licenses/android-sdk-license \ 
    && echo "84831b9409646a918e30573bab4c9c91346d8abd\n504667f4c0de7af1a06de9f4b1727b84351f2910" > $ANDROID_SDK_ROOT/licenses/android-sdk-preview-license

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
