#!/bin/bash

brew install bash-completion
brew install colordiff
brew install curl --with-libidn --with-nghttp2 --with-openssl
brew install git --with-brewed-curl --with-brewed-openssl --with-pcre
brew install gnupg
brew install hub
brew install irssi --with-perl --with-proxy
brew install memcached
brew install mtr
brew install netcat
brew install nginx --with-spdy
brew install openssl
brew install pcre
brew install percona-toolkit
brew install python
brew install ruby
brew install source-highlight
brew install terminal-notifier
brew install the_silver_searcher
brew install watch
brew install wget --with-iri

# Install multiple versions of php
brew install php55 --with-homebrew-curl --with-homebrew-libxml2
brew link php55
echo "date.timezone = UTC" > /usr/local/etc/php/5.5/conf.d/date.ini
brew install php55-memcache
brew install php55-xdebug
brew install php55-xhprof
brew unlink php55
brew install php56 --with-homebrew-curl --with-homebrew-libxml2
brew link php56
echo "date.timezone = UTC" > /usr/local/etc/php/5.6/conf.d/date.ini
brew install php56-memcache
brew install php56-xdebug
brew install php56-xhprof
brew unlink php56
brew install php70 --with-homebrew-curl --with-homebrew-libxml2
brew link php70
brew install php70-memcached
brew install php70-xdebug
brew unlink php70

# Setup phpenv
brew install phpenv
if [ ! -d "${HOME}/.phpenv" ]; then
  phpenv-install.sh
fi

# Link php versions to phpenv folder
for version in $(find /usr/local/Cellar/php55 /usr/local/Cellar/php56 /usr/local/Cellar/php70 -maxdepth 1 -mindepth 1 -type d 2>/dev/null); do
  ln -s ${version} ${HOME}/.phpenv/versions/ 2>/dev/null
done

