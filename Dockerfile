# sshd
#
# VERSION               0.0.4

FROM ubuntu:14.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN usermod www-data -s /bin/bash -d /var/www/html

RUN echo 'www-data:123' | chpasswd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo "AllowUsers drupal"

# Instalamos las herramientas necesarias para desarrollo y despliegue
RUN apt-get update && apt-get install -y build-essential ruby-full bundler nano vim php-pear

ENV TERM xterm

# Añadimos git
RUN apt-get update && apt-get install -y git curl
RUN curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o /root/git-completion.bash
RUN echo "source /root/git-completion.bash" >> /root/.bashrc

# Set the locale
RUN locale-gen es_ES.UTF-8  
ENV LANG es_ES.UTF-8  
ENV LANGUAGE es_ES:en  
ENV LC_ALL es_ES.UTF-8

WORKDIR /var/www/html

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
