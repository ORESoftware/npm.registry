FROM node:9

RUN apt-get -y update
RUN apt-get -y install sudo
RUN sudo apt-get -y update
RUN apt-get install -y netcat

#RUN sudo echo "node ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#RUN useradd -ms /bin/bash newuser
#USER node
#ENV HOME=/home/node
#ENV USER=node
#WORKDIR /home/node/app

WORKDIR /app

#RUN mkdir -p "$HOME/.npm-global"
#ENV NPM_CONFIG_PREFIX="$HOME/.npm-global"
##RUN npm config set prefix "$HOME/.npm-global"
#ENV PATH="$HOME/.npm-global/bin:$PATH"
#
#RUN sudo chown -R $(whoami) "$HOME/.npm-global"
#RUN sudo chown -R $(whoami) "$HOME/app"


RUN  npm install -g typescript

#RUN npm install "@oresoftware/registry@0.0.105"

RUN npm install -g "@oresoftware/registry@0.0.105"

ENV npm_registry_override="yes"

RUN /bin/bash -c ". $HOME/.oresoftware/bash/npm.registry.sh"

COPY package.json .
RUN npm install --loglevel=warn

ENV PATH="./node_modules/.bin:${PATH}"

COPY . .
RUN tsc

#ENTRYPOINT ["./test/index.sh"]
#ENTRYPOINT ["r2g"]
