import boto3
import collections
import datetime
import sys
import pprint

ec = boto3.client('ec2')

def lambda_handler(event, context):

    reservations = \
        ec.describe_instances(Filters=[{'Name': 'tag:payservstart',
                              'Values': ['Yes', 'yes'
                              ]}]).get('Reservations', [])

    instances = sum([[i for i in r['Instances']] for r in
                        reservations], [])
    
    
    print ('Found {} instances those are going to start'.format(len(instances)))
    for instance in instances:
        InstID = instance['InstanceId']
        # ec.start_instances(InstanceIds=[InstID])
    
        print ("Instances to be started " + str(InstID))
        #print ("Instances : " + str(instances))