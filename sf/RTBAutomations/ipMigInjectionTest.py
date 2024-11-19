import json
import os

import utils

conf = json.load(open('ipMigconf.json'))
rtbUtil = utils.rtbAutomations()
ips = list(conf['ipsBeingMigrated'].keys())
hosts = rtbUtil.getHostsForPool(conf['destinationPool'])
for ip in ips:
    for host in hosts:
        vmta = host.split('config.vmtas.')[1]
        rtbUtil.injectionTest(conf['testmail'],vmta,ip,f'IP Migration testing for {vmta} and {ip}')

print(f"you should have {len(ips) * len(hosts)} mails in testmail inbox")
