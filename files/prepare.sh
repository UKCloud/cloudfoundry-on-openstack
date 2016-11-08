#!/usr/bin/env bash
set -x

echo "IN BASTION PREPARE SCRIPT"

export TERM=linux

echo "INSTALLING DEPENDENCIES"

sudo apt-get install curl ruby-full -y


echo "INSTALLING BOSH & CF CLI TOOLS"

curl https://raw.githubusercontent.com/cloudfoundry-community/traveling-bosh/TB_VERSION/scripts/installer -o /tmp/traveling-bosh.sh
curl https://raw.githubusercontent.com/cloudfoundry-community/traveling-cf-admin/TCF_VERSION/scripts/installer -o /tmp/traveling-cf-admin.sh

chmod +x /tmp/traveling-bosh.sh
chmod +x /tmp/traveling-cf-admin.sh

sudo /tmp/traveling-bosh.sh
sudo /tmp/traveling-cf-admin.sh


export PATH=$PATH:/usr/bin/traveling-bosh:/usr/bin/traveling-cf-admin

sudo chown -R ubuntu:ubuntu /home/ubuntu/
cd /home/ubuntu/workspace


echo "APPLYING OPENSTACK PATCH FOR STORAGE AVAILABILITY ZONES\n\n"

mkdir /tmp/patch
curl https://raw.githubusercontent.com/UKCloud/cloudfoundry-on-openstack/master/files/patch/cloud.rb -o /tmp/patch/cloud.rb

sudo find /usr/bin -regex '.*openstack_cpi.*cloud.rb' -exec cp /tmp/patch/cloud.rb {} \;



echo "DOWNLOADING STEMCELL STEMCELL_VERSION"

mkdir -p /home/ubuntu/workspace/deployments/firstbosh

cd /home/ubuntu/workspace/deployments/firstbosh
bosh download public stemcell bosh-stemcell-STEMCELL_VERSION-openstack-kvm-ubuntu-trusty-go_agent.tgz


echo "DEPLOYING BASTION VM\n\n"

cd /home/ubuntu/workspace
bosh bootstrap deploy


