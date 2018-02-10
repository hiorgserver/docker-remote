#!/bin/sh

# Please export following variables:
# SSH_HOST
# SSH_PORT
# SSH_USER
# SSH_PRIVATE_KEY
# SSH_SERVER_HOSTKEY (i.e. copied from your local ~/.ssh/known_hosts)

echo ">>> Starting ssh-agent"
# run ssh-agent in background
eval $(ssh-agent -s)
ssh-add <(echo "$SSH_PRIVATE_KEY")

echo ">>> Add remote host key to known_hosts"
mkdir -p ~/.ssh
echo "$SSH_SERVER_HOSTKEY" > ~/.ssh/known_hosts

if [[ $# -gt 0 ]]; then
  echo ">>> Execute on remote host: $*"
  ssh -p$SSH_PORT $SSH_USER@$SSH_HOST "$*"
fi