#!/bin/bash

UNLOAD_VERSION=$1

# install composer
export TMP_UNLOAD_BIN="/tmp/unload"
mkdir $TMP_UNLOAD_BIN
export PATH="~/.composer/vendor/bin:$TMP_UNLOAD_BIN:$PATH"

# check for packaged binary
if [ -f "unload" ]; then
    echo "Packaged binary exists...skip package installation"
    chmod +x unload
    mv ./unload /tmp/unload/unload
    unload --version
    return
fi

# install unload
curl -L https://github.com/unloadphp/unload/releases/download/$UNLOAD_VERSION/unload -o unload
chmod +x unload
mv ./unload /tmp/unload/unload
unload --version