import re
import sys
import datetime
import os
import ipaddress

class rtbAutomations:
    def __init__(self):
        # self.zoneFilePath = './test/customer/'
        self.zoneFilePath = '/home/etapp/svn/dns/master/customer/'
        self.info = 'info'
        self.error = 'error'
        self.tmpFolder = f'./tmp-{datetime.datetime.now().strftime("%Y-%m-%d-%H-%M-%S")}/'
        if not os.path.exists(self.tmpFolder):
            os.makedirs(self.tmpFolder)

    def pushDNS(self):
        pass

    def injectionTest(self,toMail,vmta,ip,subject,fromMail='SFMC-ITMTA@mc.salesforce.com'):
        os.system(f'echo -e "{vmta}\n{ip}\n{fromMail}\n{toMail}\n{subject}" | /home/etapp/bin/inject.sh')

    def getHostsForPool(self,pool):
        os.system(f'rm -Rf {pool} && mkdir {pool} && cd {pool} && bash ~/com/pool-data.bash {pool}')
        res = []
        with open(f'./{pool}/all', "r") as input_file:
            hosts = input_file.readlines()
        for host in hosts:
            temp = host.strip()
            if temp != "":
                res.append(f'/home/etapp/svn/mta/config.vmtas.{temp}.xt.local')
        return res

    def getHostsByIp(self,ip):
        res = []
        output = os.popen(f"grep -l '{ip}>' ~/svn/mta/config.vmtas*").readlines()
        for host in output:
            host = host.strip("\n")
            res.append(host)
        return res

    def updateSerial(self,subDomain):
        regex = r'[0-9]{10}\s*;\s*Serial'
        filePath = f'{self.zoneFilePath}{subDomain}'
        matches = self.findRegex(filePath,regex)
        if len(matches) != 1:
            self.log(filePath + f'\n{len(matches)} matches found', tag=self.error)
        else:
            matchedText = matches[0].strip().split(";")[0].strip()
            counter = 0
            today = str(datetime.date.today()).replace('-','')
            if matchedText[:-2] == today:
                counter = 1 + int(matchedText[-2:])
            text = f'{today}{counter:02d} ; Serial'
            self.updateSettingsInFile(filePath, regex, text)

    def addNewConfig(self,filePath,text):
        with open(filePath, 'r') as file:
            contents = file.read()
        contents.rstrip('\n')
        with open(filePath, 'w') as file:
            file.write(f'{contents}\n{text}\n')

    def findRegex(self,filePath,regex):
        with open(filePath, 'r') as f:
            contents = f.read()
        temp = list(re.finditer(regex, contents,flags=re.MULTILINE))
        matches = []
        for i in temp:
            matches.append(contents[i.start():i.end()])
        return matches

    def updateSettingsInFile(self,filePath,regex,text,process='replace'):
        with open(filePath, 'r') as f:
            contents = f.read()
        matches = list(re.finditer(regex, contents,flags=re.MULTILINE))
        totalLength = len(matches)
        for i in range(0,totalLength):
            match = matches[0]
            start = match.start()
            end = match.end()
            if process == 'replace':
                contents = contents[:start] + text + contents[end:]
            elif process == 'delete':
                contents = contents[:start]+contents[end:]
            elif process == 'append':
                contents = contents[:end] + text + contents[end:]
            else:
                raise ValueError('Please check process parameter in this function')
            matches = list(re.finditer(regex, contents, flags=re.MULTILINE))
        if totalLength > 0:
            with open(filePath, 'w') as f:
                f.write(contents)
        return totalLength

    def log(self, lines,tag=None):
        text = lines+ '\n==========================================\n\n\n'
        if tag == self.error:
            logFile = f'{self.tmpFolder}{self.error}.tmp'
            sys.stderr.write(text)
        elif tag == None or tag == self.info:
            logFile = f'{self.tmpFolder}{self.info}.tmp'
            print(text)
        else:
            logFile = f'{self.tmpFolder}{tag}.tmp'
        with open(logFile, "a") as file:
            file.write(text)

    def check_ip_validation(self,ip):
        print("----- Validating input ip -----")
        ipaddress.ip_address(ip)
        print(f"----- Input ip {ip} validated and is in correct format. -----\n")
