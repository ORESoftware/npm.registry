FROM node:9

RUN apt-get -y update
RUN apt-get -y install sudo
RUN sudo apt-get -y update
RUN apt-get install -y netcat

#RUN sudo echo "node ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#RUN useradd -ms /bin/bash newuser
#USER node
ENV HOME="/root"
#ENV USER=node
#WORKDIR /home/node/app

WORKDIR /app



RUN echo "home is: $HOME"

#RUN mkdir -p "$HOME/.npm-global"
#ENV NPM_CONFIG_PREFIX="$HOME/.npm-global"
##RUN npm config set prefix "$HOME/.npm-global"
#ENV PATH="$HOME/.npm-global/bin:$PATH"
#
#RUN sudo chown -R $(whoami) "$HOME/.npm-global"

RUN sudo chown -R $(whoami) "."

RUN mkdir -p "$HOME/.oresoftware/execs"
RUN mkdir -p "$HOME/.oresoftware/bash"

RUN npm set strict-ssl false;
RUN npm config set strict-ssl false;
#RUN npm set registry "npm_registry_server:3441"
#RUN npm config set registry "npm_registry_server:3441"
#RUN npm set registry "http://foo:3441"
#RUN npm config set registry "http://foo:3441"

COPY package.json .
RUN npm install typescript

#RUN  curl -H 'Cache-Control: no-cache' \
#        "https://raw.githubusercontent.com/oresoftware/npm.registry/master/npm.sh?$(date +%s)" \
#        --output "$HOME/.oresoftware/bash/npm.registry.sh"
#
#RUN  curl -H 'Cache-Control: no-cache' \
#        "https://raw.githubusercontent.com/oresoftware/npm.registry/master/npm.exec.sh?$(date +%s)" \
#        --output "$HOME/.oresoftware/execs/npm.registry.sh"
#
#ENV npm_registry_override="yes"
#
#RUN /bin/bash -c ". $HOME/.oresoftware/bash/npm.registry.sh"

#RUN echo "$HOME/.oresoftware/execs/npm.registry.sh" | bash

#RUN ["/bin/bash", "-c", "echo hello"]

#RUN /bin/bash -c ". $HOME/.oresoftware/bash/npm.registry.sh && npm install --loglevel=warn"

ENV PATH="./node_modules/.bin:${PATH}"

COPY . .
RUN tsc || echo "fail compilation";
#RUN gmx tsc

ENTRYPOINT ["/bin/bash", "./test/index.sh"]
