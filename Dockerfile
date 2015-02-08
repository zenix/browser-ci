FROM jenkins
USER root

# Don't ask anything
ENV DEBIAN_FRONTEND=noninteractive

# Node.js
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y apt-utils bzip2 tar gzip unzip
RUN apt-get install -y nodejs wget
RUN npm install -g bower

# Browser testing

#xvfb
RUN apt-get install -y xvfb 

#Browser dependencies
RUN apt-get install -y x11-xkb-utils xfonts-100dpi xfonts-75dpi
RUN apt-get install -y xfonts-scalable xserver-xorg-core
RUN apt-get install -y dbus-x11
RUN apt-get install -y libfontconfig1-dev
RUN apt-get install -y libpango1.0-0 libxss1 libappindicator1 xdg-utils libexif12
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg --install google-chrome-stable_current_amd64.deb || apt-get -f install -y

#install phantomjs
RUN npm install -g phantomjs

#install chromium driver
RUN wget http://chromedriver.storage.googleapis.com/2.9/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip && rm chromedriver_linux64.zip && mv chromedriver /usr/bin && chmod 755 /usr/bin/chromedriver

#install selemium
RUN wget http://selenium-release.storage.googleapis.com/2.44/selenium-server-standalone-2.44.0.jar
RUN mkdir /usr/share/selenium
RUN mv selenium-server-standalone-2.44.0.jar /usr/share/selenium/

RUN touch /phantomjsdriver.log
RUN chmod 666 /phantomjsdriver.log

COPY xvfb.sh /usr/local/bin/xvfb.sh
COPY selenium.sh /usr/local/bin/selenium.sh
COPY run.sh /usr/local/bin/run.sh

RUN chown -R jenkins /usr/local/bin
RUN chmod -R u+x /usr/local/bin
RUN chown -R jenkins /opt/google/chrome

# workaround. Chrome needs suid, and opt is mounted nosuid
RUN dpkg-divert --add --rename --divert /opt/google/chrome/google-chrome.real /opt/google/chrome/google-chrome
RUN echo "#!/bin/bash\nexec /opt/google/chrome/google-chrome.real --disable-setuid-sandbox \"\$@\"" > /opt/google/chrome/google-chrome
RUN chmod 755 /opt/google/chrome/google-chrome

ENTRYPOINT ["/usr/local/bin/run.sh"]
