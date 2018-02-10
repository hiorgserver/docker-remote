#!/bin/sh

# Please export following variables:
# SSH_HOST
# SSH_PORT
# SSH_USER
# SSH_PRIVATE_KEY
# SSH_SERVER_HOSTKEY (i.e. copied from your local ~/.ssh/known_hosts)

# on destination server:
# > sudo $SSH_USER
# > mkdir -p ~/.ssh
# > nano ~/.ssh/authorized_keys
# add corresponding public key (to this SSH_PRIVATE_KEY)
# > chmod 600 ~/.ssh/authorized_keys
# > chmod 700 ~/.ssh
# > nano /etc/passwd
# enable shell (i.e. /bin/bash ) for $SSH_USER
# > nano /etc/ssh/sshd_config
# add $SSH_USER to AllowUsers
# > systemctl reload sshd

echo ">>> Starting ssh-agent"
# run ssh-agent in background
eval $(ssh-agent -s)
echo "$SSH_PRIVATE_KEY" > privkey
chmod 700 privkey
ssh-add privkey
rm privkey

echo ">>> Add remote host key to known_hosts"
mkdir -p ~/.ssh
echo "$SSH_SERVER_HOSTKEY" > ~/.ssh/known_hosts

if [[ $# -gt 0 ]]; then
  echo ">>> Execute on remote host: $*"
  ssh -p$SSH_PORT $SSH_USER@$SSH_HOST "$*"
fi