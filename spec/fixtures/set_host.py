#!/usr/bin/env python
import sys
from python_hosts import Hosts, HostsEntry

hosts = Hosts(path='/etc/hosts')
hosts.remove_all_matching(name='bastion')
new_entry = HostsEntry(entry_type='ipv4', address=sys.argv[1], names=['bastion'])
hosts.add([new_entry])
hosts.write()
