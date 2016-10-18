#!/usr/bin/env bash

echo "IN SETUP SCRIPT"

echo "INSTALLING OPENSTACK CLI"

pip install python-openstackclient
pip install python-heatclient
pip install python-keystoneclient
pip install python-hosts


openstack --version
