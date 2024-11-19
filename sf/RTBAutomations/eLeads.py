import csv
import utils
import traceback
import datetime
import os
import sys

rtbUtil = utils.rtbAutomations()

csvPath = 'eLeads.csv'

def getSubdomains():
    subdomains = []
    with open(csvPath, 'r') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            subdomains.append(row[0].lower())
    return subdomains

def massCopy(start,end):
    zoneFileBackup = f'./zoneFileBackup-{datetime.datetime.now().strftime("%Y-%m-%d-%H-%M-%S")}/'
    os.system(f'mkdir -p {zoneFileBackup}specificBackup')
    subdomains = getSubdomains()[start:end + 1]
    for domain in subdomains:
        fp = f'{rtbUtil.zoneFilePath}{domain}'
        if os.path.exists(fp):
            os.system(f'cp -f {fp} {zoneFileBackup}specificBackup')

def executeEleads(start,end):
    subdomains = getSubdomains()[start:end+1]
    for subDomain in subdomains:
        regex = r'@\s+IN\s+MX\s+10\s+mx2\.eleadtrack\.net\.'
        text = '@               IN MX 20        mx2.eleadtrack.net.'
        try:
            filePath = f'{rtbUtil.zoneFilePath}{subDomain}'
            matches = rtbUtil.findRegex(filePath, regex)
            if len(matches) == 0:
                rtbUtil.log(subDomain,tag='noMatches')
            elif len(matches) > 1:
                rtbUtil.log(subDomain,tag='morethan1')
            else:
                rtbUtil.updateSerial(subDomain)
                rtbUtil.updateSettingsInFile(filePath, regex, text)
                rtbUtil.log(subDomain, tag='one')
        except FileNotFoundError:
            rtbUtil.log(subDomain, tag='fileNotExists')
        except:
            rtbUtil.log(traceback.format_exc(),tag=rtbUtil.error)

try:
    procedure = sys.argv[1]
    start = int(sys.argv[2])
    end = int(sys.argv[3])
    if procedure == 'copy':
        massCopy(start,end)
    elif procedure == 'eleads':
        executeEleads(start,end)
    elif procedure == 'full':
        massCopy(start, end)
        executeEleads(start, end)
    else:
        rtbUtil.log('enter eiter copy or eleads or full',tag=rtbUtil.error)
except:
    rtbUtil.log(traceback.format_exc(),tag=rtbUtil.error)

#to remove local changes
# svn revert -R .

# to view latest commits
#svn log -l 10 -r HEAD:1

# to output files not containing given regex and list of files to search 2=> regex 1=> file list
# while read file_name; do if ! grep -q "$2" "$file_name"; then echo "$file_name"; fi; done < "$1"

# change start,end,zone file path