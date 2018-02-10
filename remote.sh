#!/bin/sh

# Please export following variables:
# SSH_HOST
# SSH_USER
# SSH_PORT  (optional, default: 22)

if [[ $# -eq 0 ]]; then
  echo "ERROR: no command specified. Use: $0 <command to execute on remote host>"
  exit 1
fi  

if [ -z "$SSH_PORT" ]; then
    SSH_PORT=22
fi
  
echo ">>> Run remote: $*"
ssh -p$SSH_PORT $SSH_USER@$SSH_HOST "$*"