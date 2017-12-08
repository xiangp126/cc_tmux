#!/bin/bash
# After this config, git push can be done by username:password,
# but no ssh-key.

usage() {
    echo "git push using proxy, proxy socks5://127.0.0.0:8080 through SSH reverse tunnel."
    echo "ssh -vv -ND 8080 midman_server -l log_name"
    echo "syntax: $0 enable | disable"
}

proxyAddr="socks5://127.0.0.1:8080"

if [ $# -le 0 ]; then
    usage
    exit
fi

# Only git did not need below 2 variables.
# With these 2, did not need git config http.proxy.
# export http_proxy=socks5://127.0.0.1:8080
# export https_proxy=socks5://127.0.0.1:8080

case $1 in
    'enable')
        echo "start enabling http.proxy ..."
        git config --global http.proxy ${proxyAddr}
        echo "start enabling https.proxy ..."
        git config --global https.proxy ${proxyAddr}
    ;;

    'disable')
        echo "start disabling http.proxy ..."
        git config --global --unset http.proxy
        echo "start disabling https.proxy ..."
        git config --global --unset https.proxy
    ;;
esac;

echo "> git config --global --list"
git config --global --list

