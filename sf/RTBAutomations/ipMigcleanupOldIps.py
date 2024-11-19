import json
import utils

conf = json.load(open('ipMigconf.json'))
rtbUtil = utils.rtbAutomations()

def cleanup(ip,hostFile):
    with open(hostFile, "r") as input_file:
        contents = input_file.read()
    start_tag = f"<virtual-mta {ip}>"
    end_tag = "</virtual-mta>"
    if start_tag in contents:
        start_index = contents.find(start_tag)
        end_index = contents.find(end_tag,start_index) + len(end_tag)
        contents = contents[:start_index] + contents[end_index:]
    with open(hostFile, "w") as output_file:
        output_file.write(contents)

def process():
    destHosts = rtbUtil.getHostsForPool(conf['destinationPool'])
    for ip in conf['ipsBeingMigrated'].keys():
        rtbUtil.check_ip_validation(ip)
        hosts = rtbUtil.getHostsByIp(ip)
        finalHosts = [x for x in hosts if x not in destHosts]
        for host in finalHosts:
            cleanup(ip,host)



process()