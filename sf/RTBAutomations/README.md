# RTBAutomations

This Repo targets at automating RTBs end to end.

Common procedures we perform for various RTBs should be placed in rtbAutomations class in utils.py
Each individual RTB has its own file, stitching the procedures it perform while reusing rtbAutomations class

DNS automation involves updating zone files based on CSV from CR. Currently only below records are automated
CNAME, GPT, TXT, DMARC, BIMI
Please review using svn diff before committing to ensure everything is good before committing

Automations:
1) DNS RTB:
    a) DNS automation involves updating zone files based on CSV from CR. Currently only below records are automated
CNAME, GPT, TXT, DMARC, BIMI
    b) This automation does following for below records. For others no action will be performed and the record will be mentioned in dnsFailure.csv
        => dmarc: replaces current dmarc. Applied to both dmarc records be it in cname form or _dmarc form 
        => gpt: adds new gpt record. Doesnt modify the existing ones
        => bimi: replaces existing bimi.
        => dmarc_delete: deletes all kinds of dmarc records in given zone file
        => cname: fails in case of A record/other CNAME presence for same subdomain. replaces other cnames if any exist for same subdomain. Incase this record refers to _dmarc, replaces existing dmarc
        => txt: adds new txt record. 
        except for txt, all the above records if present in csv will be verified against valid regex to prevent input errors
    b) To Run this follow below steps
        => download Excel attached in DNS CR in csv format and rename it to dnsInput.csv
        => clone this repo in s1a and copy dnsInput.csv to that folder
        => run "python3 dns.py". A tmp folder will be created with current date. Check dnsFailure.csv in that directory for failures
        => manually update failed records and review using svn diff. After this you are free to push using bin/push

2) IP Migration: playbook https://salesforce.quip.com/AbavAVEtCD4F
   a) Only Updating "config.vmtas files" and "Remove migrated IP(s) from old config.vmtas files and changing default-virtual-mta" sections in the above playbook are automated
   b) Conf.json has details regarding destination pool, ips Being migrated and their current pools. Make sure this file is in same folder as python files
      To update config.vmtas files(adding new IPs and their config to destination pool) use "python3 vmtaConfUpdate.py" This will not copy files given in include statements. Import them manually
      To remove Ips in their current pool post migration run "python3 cleanupOldIps.py". post this you can proceed with chef pool reload commands
