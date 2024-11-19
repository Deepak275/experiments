import re
import csv
import utils
import traceback
from copy import deepcopy

rtbUtil = utils.rtbAutomations()

def readInput():
    data = {}
    for row in csv.DictReader(open('dnsInput.csv', "r", encoding="utf8")):
        key = row['Domain'].lower()
        temp = {k: v.lower() if k in ['Type', 'Domain'] else v for k, v in row.items()}
        if key in data:
            data[key].append(temp)
        else:
            data[key] = [temp]
    return data

def writeToCSV(data, fname):
    with open(f'{rtbUtil.tmpFolder}{fname}', "w", newline="") as file:
        writer = csv.DictWriter(file, fieldnames=data[0].keys())
        writer.writeheader()
        writer.writerows(data)

def regexGenericHandler(zone, change, regex, typeRegex, replace=True):
    if len(list(re.finditer(typeRegex, change))) != 1:
        return False, 'please Check change in input file'
    filePath = f'{rtbUtil.zoneFilePath}{zone}'
    matches = rtbUtil.findRegex(filePath, regex)
    if len(matches) == 0:
        rtbUtil.addNewConfig(filePath, change)
        return True, 'success'
    elif len(matches) == 1:
        if replace:
            rtbUtil.updateSettingsInFile(filePath, regex, change)
            return True, 'success'
        else:
            return False, 'change already exists'
    else:
        return False, "multiple matches found in zone file.please remove duplicates to make this zone work"

# regex is in zone file
# typeregex is in csv file
# dmarc came handled
# no checks for txt and caa
def regexHandler(zone, type, change):
    try:
        if type == 'gpt':
            regex = rf'^@\s+IN\s+TXT\s+"google-site-verification={change.split("verification=")[1]}$'
            typeRegex = r'^@\s+IN\s+TXT\s+"google-site-verification=.+"$'
            return regexGenericHandler(zone, change, regex, typeRegex, replace=False)
        elif type == 'dmarc':
            regex = rf'^{change.split(" ")[0]}.*'
            typeRegex = r'^_dmarc(\.\S+)?\s+IN\s+TXT\s+"v=DMARC.+"$'
            return regexGenericHandler(zone, change, regex, typeRegex)
        elif type == 'bimi':
            regex = rf'^{change.split(" ")[0]}\s+IN\s+TXT\s+"v=BIMI.+"$'
            typeRegex = r'^default._bimi(\.\S+)?\s+IN\s+TXT\s+"v=BIMI.+"$'
            return regexGenericHandler(zone, change, regex, typeRegex)
        elif type == 'dmarc delete':
            regex = '^_dmarc.*'
            rtbUtil.updateSettingsInFile(f'{rtbUtil.zoneFilePath}{zone}', regex, '', process='delete')
            return True, 'success'
        elif type == 'cname':
            #handling dmarcs given in cname format
            if change.startWith('_dmarc'):
                res = regexHandler(zone,'dmarc delete','')
                if not res[0]:
                    return res
            regex = rf'^{change.split(" ")[0]}\s+IN\s+(CNAME|A)\s+\S+\.$'
            typeRegex = r'^\S+\s+IN\s+CNAME\s+\S+\.$'
            return regexGenericHandler(zone, change, regex, typeRegex)
        elif type == 'txt':
            txtString = change.split('"')[1]
            regex = rf'^@\s+IN\s+TXT\s+"{txtString}$'
            typeRegex = r'^@\s+IN\s+TXT\s+".+"$'
            return regexGenericHandler(zone, change, regex, typeRegex, replace=False)
        else:
            return False, 'This script doesnt match this type of record yet'
    except FileNotFoundError as e:
        rtbUtil.log(traceback.format_exc(), tag=rtbUtil.error)
        return False, 'zone file not present'
    except:
        rtbUtil.log(traceback.format_exc(), tag=rtbUtil.error)
        return False, 'Exception occured'


def process():
    failure = []
    success = []
    inputData = readInput()
    for zone in inputData:
        changeDone = False
        print(zone)
        for row in inputData[zone]:
            change = row['Change']
            recordType = row['Type']
            status, reason = regexHandler(zone, recordType, change)
            tempRow = deepcopy(row)
            tempRow['status'] = reason
            if status:
                changeDone = True
                success.append(tempRow)
            else:
                failure.append(tempRow)
        if changeDone:
            rtbUtil.updateSerial(zone)
    if len(failure) > 0:
        writeToCSV(failure, 'dnsFailure.csv')
    if len(success) > 0:
        writeToCSV(success, 'dnsSuccess.csv')


try:
    process()
except:
    rtbUtil.log(traceback.format_exc(), tag=rtbUtil.error)