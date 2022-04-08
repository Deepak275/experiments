#!/bin/bash

set -e

declare -a user_groups
index=0
user_list=($(aws iam list-users --profile aws_bs | jq  ".Users | .[] | .UserName"))

echo "All users are: "
echo -e "${user_list[*]} \n"

for i in "${user_list[@]}"; do

  t=$(eval echo $i)

  cmd=$(aws iam list-groups-for-user --user-name $t --profile aws_bs | jq  ".Groups | .[] | .GroupName")
  echo "$t belongs to below groups: "
  echo $cmd
  
  cmd=$(aws iam list-user-policies --user-name $t --profile aws_bs | jq  ".PolicyNames")
  echo "$1 policies attached are:"
  echo $cmd
  # aws iam list-groups-for-user --user-name $t | jq  ".Groups | .[] | .GroupName"
  # echo $user_groups
done


# policy_arn=$(aws iam list-policies --query 'Policies[?interview_s3_read==`FullAccess`].Arn' --output text)


# cmd=$(aws iam list-user-policies --user-name $t --profile aws_bs | jq  ".PolicyNames")

# list-user-policies
# echo $user_list