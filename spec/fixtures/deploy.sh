#!/usr/bin/env bash

echo "IN DEPLOY SCRIPT"

echo "DEPLOYING INITIAL STACK"

openstack stack create -f yaml -t cloudfoundry.yaml tl_cloudfoundry --wait


echo "GETTING BASTION IP"

bastion_ip=`openstack stack output show tl_cloudfoundry bastion_ip -f value -c output_value`


echo "GETTING BASTIO SSH KEY"

rm -f /tmp/key.pem
openstack stack output show tl_cloudfoundry bastion_private_key -f value -c output_value > /tmp/key.pem
chmod 400 /tmp/key.pem


echo "CLEAR SSH KNOWN_HOSTS ENTRY"

ssh-keygen -f ~/.ssh/known_hosts -R bastion

echo "SETTING HOST ENTRY"

sudo spec/fixtures/set_host.py $bastion_ip
