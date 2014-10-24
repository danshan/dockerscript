FROM danshan/java7

# Run upgrades
RUN     echo deb http://us.archive.ubuntu.com/ubuntu/ precise universe multiverse >> /etc/apt/sources.list
RUN     echo deb http://us.archive.ubuntu.com/ubuntu/ precise-updates main restricted universe >> /etc/apt/sources.list
RUN     echo deb http://security.ubuntu.com/ubuntu precise-security main restricted universe >> /etc/apt/sources.list
RUN     echo udev hold | dpkg --set-selections
RUN     echo initscripts hold | dpkg --set-selections
RUN     echo upstart hold | dpkg --set-selections
RUN     apt-get update
RUN     apt-get -y upgrade

# Install dependencies
RUN apt-get install -y -q build-essential zlib1g-dev libyaml-dev libssl-dev libgdbm-dev libreadline-dev libncurses5-dev libffi-dev curl openssh-server redis-server checkinstall libxml2-dev libxslt-dev libcurl4-openssl-dev libicu-dev sudo python python-docutils python-software-properties nginx logrotate sendmail

# Install Ruby
RUN apt-get install -y -q ruby1.9.1-dev;\
    gem install bundler --no-ri --no-rdoc

# Create Git user
RUN adduser --disabled-login --gecos 'GitLab' git


# Install GitLab Shell
RUN cd /home/git;\
    su git -c "git clone https://github.com/gitlabhq/gitlab-shell.git -b v1.8.0";\
    cd gitlab-shell;\
    su git -c "cp config.yml.example config.yml";\
    sed -i -e 's/localhost/127.0.0.1/g' config.yml;\
    su git -c "./bin/install"

# Install MySQL
RUN echo mysql-server mysql-server/root_password password $MYSQLTMPROOT | debconf-set-selections;\
    echo mysql-server mysql-server/root_password_again password $MYSQLTMPROOT | debconf-set-selections;\
    apt-get install -y mysql-server mysql-client libmysqlclient-dev

# Install GitLab
RUN cd /home/git;\
  su git -c "git clone https://github.com/gitlabhq/gitlabhq.git -b 6-4-stable gitlab"

# Misc configuration stuff
RUN cd /home/git/gitlab;\
    chown -R git tmp/;\
    chown -R git log/;\
    chmod -R u+rwX log/;\
    chmod -R u+rwX tmp/;\
    su git -c "mkdir /home/git/gitlab-satellites";\
    su git -c "mkdir tmp/pids/";\
    su git -c "mkdir tmp/sockets/";\
    chmod -R u+rwX tmp/pids/;\
    chmod -R u+rwX tmp/sockets/;\
    su git -c "mkdir public/uploads";\
    chmod -R u+rwX public/uploads;\
    su git -c "cp config/unicorn.rb.example config/unicorn.rb";\
    su git -c "cp config/initializers/rack_attack.rb.example config/initializers/rack_attack.rb";\
    su git -c "git config --global user.name 'GitLab'";\
    su git -c "git config --global user.email 'gitlab@localhost'";\
    su git -c "git config --global core.autocrlf input"

RUN cd /home/git/gitlab;\
    wget http://rubygems.org/downloads/modernizr-2.6.2.gem;\
    gem install modernizr;\
    sed -i -e 's/2\.6\.2/2.7.1/g' Gemfile;\
    sed -i -e 's/2\.6\.2/2.7.1/g' Gemfile.lock;\
    sed -i -e 's/modernizr/modernizr-rails/g' Gemfile*;\
    su git -c "bundle install --deployment --without development test postgres aws"

# Install init scripts
RUN cd /home/git/gitlab;\
  cp lib/support/init.d/gitlab /etc/init.d/gitlab;\
  update-rc.d gitlab defaults 21;\
  cp lib/support/logrotate/gitlab /etc/logrotate.d/gitlab

EXPOSE 80
EXPOSE 22

ADD . /srv/gitlab

RUN chmod +x /srv/gitlab/start.sh;\
  chmod +x /srv/gitlab/firstrun.sh

CMD ["/srv/gitlab/start.sh"]