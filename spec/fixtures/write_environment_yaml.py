#!/usr/bin/env python
import yaml
import os

data = dict(
    parameters = dict(
        openstack_user = os.environ['OS_USERNAME'],
        openstack_password = os.environ['OS_PASSWORD'],
        openstack_project = os.environ['OS_PROJECT_NAME'],
        openstack_auth_url = os.environ['OS_AUTH_URL']
        )
)


with open('environment.yaml', 'w') as outfile:
    yaml.dump(data, outfile, default_flow_style=False)

