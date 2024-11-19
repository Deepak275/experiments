import ipaddress
import json
from glob import glob
import os

conf = json.load(open('ipMigconf.json'))

def sort_ip_addresses(ip_addresses):
  ip_list = []
  ip_list_final = []
  for ip in ip_addresses:
    ip_list.append(ipaddress.ip_address(ip))
  # Sort the list of IP addresses
  ip_list_sorted = sorted(ip_list)
  for ip in ip_list_sorted:
    ip_list_final.append(str(ip))
  return ip_list_final

def getIPs():
  ips = []
  with open('./cr.txt-safe', 'r') as f:
    data = f.readlines()
  for line in data:
    ips.append(line.split("\t")[0].strip())
  return ips

def getPoolInfo():
  existingIps = getIPs()
  pooldata = {}
  for ip in existingIps:
    pooldata[ip] = conf['destinationPool']
  for key in conf['ipsBeingMigrated']:
    pooldata[key] = conf['ipsBeingMigrated'][key]
  return pooldata

def getDiff():
  file_list = glob('./data/output/*.xt.local')
  sampleFile = file_list[0].split("/")[-1]
  print("Below is the diff between newly generated {sampleFile} and old one. please proceed with further steps if it looks good")
  os.system("diff {file_list[0]} ~/svn/mta/{sampleFile}")


def updateVMTAConf():
  os.system('rm -Rf poolIP IPs data cr.txt-safe all')
  os.system("bash ~/com/pool-data.bash {conf["destinationPool"]}")
  pooldata = getPoolInfo()
  with open('./poolIP', 'w') as f:
    f.writelines(["{value},{key}\n" for key, value in pooldata.items()])
  sortedIps = sort_ip_addresses(pooldata.keys())
  with open('./IPs', 'w') as f:
    f.writelines(["{ip}\n" for ip in sortedIps])
  os.system("bash /home/etapp/svn/scripts/makeCfgVfromIPpool.bash {conf["destinationPool"]} poolIP IPs")
  getDiff()

updateVMTAConf()
