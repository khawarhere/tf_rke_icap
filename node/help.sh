export AWS_PROFILE=gw
aws iam list-roles

#aws iam list-instance-profiles-for-role --role-name rke-role

#aws iam remove-role-from-instance-profile --instance-profile-name rke-aws --role-name rke-role

aws iam delete-instance-profile --instance-profile-name rke-aws

aws iam delete-role --role-name rke-role