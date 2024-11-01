FROM node:latest

# Install Android SDK dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends openjdk-11-jdk wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Install Android SDK
ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
ENV ANDROID_HOME="/usr/local/android-sdk"

RUN mkdir -p "$ANDROID_HOME" && \
    cd "$ANDROID_HOME" && \
    wget -q "$ANDROID_SDK_URL" && \
    unzip -q sdk-tools-linux-*.zip && \
    rm sdk-tools-linux-*.zip && \
    yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" "platforms;android-31" "build-tools;31.0.0"

# Set environment variables
ENV PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"
ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

# Install React Native CLI
RUN npm install -g react-native-cli

# Set working directory
WORKDIR /workspace
