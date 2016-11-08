#!/usr/bin/env bash
set -x

echo "IN BASTION PREPARE SCRIPT"

export TERM=linux

sudo apt-get install curl ruby-full -y

curl https://raw.githubusercontent.com/cloudfoundry-community/traveling-bosh/TB_VERSION/scripts/installer -o /tmp/traveling-bosh.sh
curl https://raw.githubusercontent.com/cloudfoundry-community/traveling-cf-admin/TCF_VERSION/scripts/installer -o /tmp/traveling-cf-admin.sh

chmod +x /tmp/traveling-bosh.sh
chmod +x /tmp/traveling-cf-admin.sh

sudo /tmp/traveling-bosh.sh
sudo /tmp/traveling-cf-admin.sh

source /etc/bash.bashrc

sudo chown -R ubuntu:ubuntu /home/ubuntu/
cd /home/ubuntu/workspace


echo "APPLYING OPENSTACK PATCH FOR STORAGE AVAILABILITY ZONES\n\n"

sudo find /usr/bin -regex '.*openstack_cpi.*cloud.rb' -exec cp /tmp/patch/cloud.rb {} \;


echo "DEPLOYING BASTION VM\n\n"

/usr/bin/traveling-bosh/bosh bootstrap deploy

/tmp/continue.sh
