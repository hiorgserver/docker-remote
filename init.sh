#!/bin/sh

# Please export following variables:
# SSH_HOST
# SSH_PORT
# SSH_USER
# SSH_PRIVATE_KEY
# SSH_SERVER_HOSTKEY (i.e. copied from your local ~/.ssh/known_hosts)

# on $SSH_HOST execute once:
# > nano /etc/passwd
# enable shell (i.e. /bin/bash ) for $SSH_USER
# > passwd $SSH_USER
# enter random password (will never be used)
# > nano /etc/ssh/sshd_config
# add $SSH_USER to AllowUsers
# > systemctl reload sshd
# > chown -R $SSH_USER. /home/of/ssh_user    # note the dot after username
# > sudo $SSH_USER
# > mkdir -p ~/.ssh
# > nano ~/.ssh/authorized_keys
# add corresponding public key (to this SSH_PRIVATE_KEY)
# > chmod 600 ~/.ssh/authorized_keys
# > chmod 700 ~/.ssh
# if you want to access another (git?) server by using this method,
# you should connect NOW once manually, to accept its host fingerprint
# > exit    # from sudo $SSH_USER


if [ -z "$SSH_PORT" ]; then
    SSH_PORT=22
fi

echo ">>> Starting ssh-agent, loading keys"
# run ssh-agent in background
eval $(ssh-agent -s)

echo "$SSH_PRIVATE_KEY" > privkey
chmod 700 privkey
ssh-add privkey
rm privkey

mkdir -p ~/.ssh
echo "$SSH_SERVER_HOSTKEY" > ~/.ssh/known_hosts

if [[ $# -gt 0 ]]; then
  echo ">>> Execute on remote host: $*"
  ssh -p$SSH_PORT $SSH_USER@$SSH_HOST "$*"
fi