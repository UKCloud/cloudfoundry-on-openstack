#!/usr/bin/env python

import yaml
import sys

with open(sys.argv[1], 'r') as stream:
  doc = yaml.load(stream)

key = sys.argv[2]


print doc['instances'][0][key]
