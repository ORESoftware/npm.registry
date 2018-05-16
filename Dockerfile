FROM node:9

RUN apt-get -y update
RUN apt-get -y install sudo
RUN sudo apt-get -y update
RUN apt-get install -y netcat

RUN sudo echo "newuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN useradd -ms /bin/bash newuser
USER newuser
ENV HOME="/home/newuser"
ENV USER=newuser
RUN mkdir -p /home/newuser/app
WORKDIR /home/newuser/app

RUN sudo chown -R $(whoami) $(npm config get prefix)/lib
RUN sudo chown -R $(whoami) $(npm config get prefix)/lib/node_modules
RUN sudo chown -R $(whoami) $(npm config get prefix)/bin
RUN sudo chown -R $(whoami) $(npm config get prefix)/share
RUN sudo chown -R $(whoami) /usr/local/lib
RUN sudo chown -R $(whoami) /usr/local/etc

RUN echo "home is: $HOME"

RUN mkdir -p "$HOME/.oresoftware/execs"
RUN mkdir -p "$HOME/.oresoftware/bash"

RUN npm install -g r2g
RUN npm install -g typescript

COPY package.json .
RUN npm install --loglevel=warn;

ENV PATH="./node_modules/.bin:${PATH}"

COPY . .

RUN sudo chown -R $(whoami) /home/newuser/app
RUN tsc || echo "fail compilation";

ENTRYPOINT ["/bin/bash", "./test/index.sh"]
