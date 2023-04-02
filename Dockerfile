ARG ROOT_CONTAINER=debian:bullseye 

FROM $ROOT_CONTAINER 

LABEL maintainer="IDE Server Code  <robertondame@gmail.com>"
ARG NB_USER="robsz"
ARG NB_UID="1000"
ARG NB_GID="0"
ARG HOME=/home/$NB_USER

RUN apt update 
RUN apt install -y curl zsh git
RUN curl -fsSL https://code-server.dev/install.sh | sh 

RUN mkdir /opt/config/

# Configuration of applications and extensions
COPY config.yaml /opt/config
COPY extensions.txt /opt/config 
COPY run-ide.sh /opt/config 

# Setting user
RUN useradd -d $HOME -s /bin/zsh -N -u $NB_UID -g $NB_GID $NB_USER
RUN chown -R $NB_USER. $HOME
RUN chmod -R 755 $HOME 

# Run ide 
RUN chmod +x /opt/config/run-ide.sh 
CMD  /opt/config/run-ide.sh 

# working dir to robsz
USER $NB_UID
WORKDIR $HOME 

# Installing oh-my-zsh
RUN echo -en 'Y' | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN sed -i 's/robbyrussell/fino-time/g' .zshrc