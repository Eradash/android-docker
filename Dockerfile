FROM openjdk:8-jdk

ENV ANDROID_COMPILE_SDK=29 \
    ANDROID_BUILD_TOOLS=28.0.3 \
    ANDROID_SDK_TOOLS=24.4.1

RUN apt-get --quiet update --yes >>log.txt &&\
    apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 ruby-dev make g++>>log.txt

RUN echo 'gem: --no-document' > /etc/gemrc

RUN wget --quiet --output-document=android-sdk.tgz https://dl.google.com/android/android-sdk_r${ANDROID_SDK_TOOLS}-linux.tgz

RUN echo Extracting tools
    
RUN tar --extract --gzip --file=android-sdk.tgz

RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter android-${ANDROID_COMPILE_SDK}
RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter platform-tools
RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter build-tools-${ANDROID_BUILD_TOOLS}
RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-android-m2repository
RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-google_play_services
RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-m2repository
