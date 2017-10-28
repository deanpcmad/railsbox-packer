#!/usr/bin/env bash

apt-get update

# Install java
apt-get install openjdk-8-jre openjdk-8-jre-headless openjdk-8-jdk openjdk-8-jdk-headless

# Install phantomjs
PHANTOMJS_URL="https://circle-downloads.s3.amazonaws.com/circleci-images/cache/linux-amd64/phantomjs-latest.tar.bz2" \
  && apt-get install libfontconfig \
  && curl --silent --show-error --location --fail --retry 3 --output /tmp/phantomjs.tar.bz2 ${PHANTOMJS_URL} \
  && tar -x -C /tmp -f /tmp/phantomjs.tar.bz2 \
  && mv /tmp/phantomjs-*-linux-x86_64/bin/phantomjs /usr/local/bin \
  && rm -rf /tmp/phantomjs.tar.bz2 /tmp/phantomjs-* \
  && phantomjs --version

# Install firefox
FIREFOX_URL="https://s3.amazonaws.com/circle-downloads/firefox-mozilla-build_47.0.1-0ubuntu1_amd64.deb" \
  && curl --silent --show-error --location --fail --retry 3 --output /tmp/firefox.deb $FIREFOX_URL \
  && echo 'ef016febe5ec4eaf7d455a34579834bcde7703cb0818c80044f4d148df8473bb  /tmp/firefox.deb' | sha256sum -c \
  && dpkg -i /tmp/firefox.deb || apt-get -f install  \
  && apt-get install -y libgtk3.0-cil-dev libasound2 libasound2 libdbus-glib-1-2 libdbus-1-3 \
  && rm -rf /tmp/firefox.deb \
  && firefox --version

# Install chrome
curl --silent --show-error --location --fail --retry 3 --output /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
      && (dpkg -i /tmp/google-chrome-stable_current_amd64.deb || apt-get -fy install)  \
      && rm -rf /tmp/google-chrome-stable_current_amd64.deb \
      && sed -i 's|HERE/chrome"|HERE/chrome" --disable-setuid-sandbox --no-sandbox|g' \
           "/opt/google/chrome/google-chrome" \
      && google-chrome --version

# Install chromedriver
export CHROMEDRIVER_RELEASE=$(curl --location --fail --retry 3 http://chromedriver.storage.googleapis.com/LATEST_RELEASE) \
      && curl --silent --show-error --location --fail --retry 3 --output /tmp/chromedriver_linux64.zip "http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_RELEASE/chromedriver_linux64.zip" \
      && cd /tmp \
      && unzip chromedriver_linux64.zip \
      && rm -rf chromedriver_linux64.zip \
      && mv chromedriver /usr/local/bin/chromedriver \
      && chmod +x /usr/local/bin/chromedriver \
      && chromedriver --version

su -l -c "echo 'export DISPLAY=:99' >> ~/.bash_profile" vagrant

printf '#!/bin/sh\nXvfb :99 -screen 0 1280x1024x24 &\nexec "$@"\n' > /home/vagrant/display.sh \
  && chmod +x /home/vagrant/display.sh \
  && chown vagrant /home/vagrant/display.sh \
  && su -l -c "echo 'sh /home/vagrant/display.sh &' >> ~/.bash_profile" vagrant
