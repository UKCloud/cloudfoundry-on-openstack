#!/usr/bin/env bash

echo "IN CLEANUP SCRIPT"

echo "GETTING IP OF DEPLOYED INSTANCE"
bastion_ip=`openstack stack output show tl_cloudfoundry bastion_ip -f value -c output_value`


echo "COPYING BOSH_DELPOYMENT.YML TO /TMP"
scp -o ConnectTimeout=7 -o BatchMode=yes -o StrictHostKeyChecking=no -i /tmp/key.pem centos@$bastion_ip:workspace/deployments/bosh-deployments.yml /tmp



echo "PARSING CLOUD IDs FROM /TMP/BOSH_DEPLOYMENT.YML"
vm_id=`spec/fixtures/parse_cloud_id.py /tmp/bosh-deployments.yml :vm_cid`
volume_id=`spec/fixtures/parse_cloud_id.py /tmp/bosh-deployments.yml :disk_cid`
stack_name='tl_cloudfoundry'

echo "DELETING INSTANCE"
openstack server delete $vm_id
echo "DELETING VOLUME"
openstack volume delete $volume_id
echo "DELETING STACK"
openstack stack delete $stack_name --yes --wait
