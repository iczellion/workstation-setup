#!/bin/bash

WORK_DIR=/tmp/dotfiles

sudo_correct=1
until [ $sudo_correct -eq 0 ]
do
  read -s -p "Enter sudo password for $USER: " password
  echo ""

  echo $password | sudo -S -k whoami &>/dev/null
  sudo_correct=$?

  if [ $sudo_correct -ne 0 ]; then
    echo "⚠️ Sudo password incorrect, please try again."
  fi
done

echo "🛠️ Installing pre-requisites..."
echo $password | sudo -S -k apt update
echo $password | sudo -S -k apt install software-properties-common
echo $password | sudo -S -k add-apt-repository --yes --update ppa:ansible/ansible
echo $password | sudo -S -k add-apt-repository --yes --update ppa:deadsnakes/ppa
echo $password | sudo -S -k apt install -yq python3 python3-pip ansible

echo "Cloning repository..."
rm -rf $WORK_DIR && \
git clone -q https://github.com/iczellion/workstation-setup.git $WORK_DIR

echo "🛠️ Running Ansible playbook..."
password="9298"
ansible-playbook -c local -i 127.0.0.1, -e "ansible_become_pass=$password" $WORK_DIR/main.yml

echo "✅ Bootstrap complete!"