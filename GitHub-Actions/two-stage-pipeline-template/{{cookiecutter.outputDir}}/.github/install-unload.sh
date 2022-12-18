#!/bin/bash

UNLOAD_VERSION=$1

# install composer
export PATH=~/.composer/vendor/bin:$PATH

# check for packaged binary
if [ -f "unload" ]; then
    echo "Packaged binary exists...skip package installation"
    mv ./unload /usr/bin/unload
    unload --version
    return
fi

# install unload
curl https://github.com/unloadphp/unload/releases/download/$UNLOAD_VERSION/unload -o unload
chmod +x unload
mv ./unload /usr/bin/unload
unload --version