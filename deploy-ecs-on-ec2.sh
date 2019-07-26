#!/bin/bash

source envfile2

if [ -z "$CFN_ProjectName" ]; then
  echo "環境変数CFN_ProjectNameが設定されていません" >&2
  exit 1
fi

TEMPLATE_NAME=ecs-on-ec2

CFN_TEMPLATE=${TEMPLATE_NAME}.yml
CFN_STACK_NAME=${CFN_ProjectName}-${TEMPLATE_NAME}

# テンプレートの実行
aws cloudformation deploy --stack-name ${CFN_STACK_NAME} --template-file ${CFN_TEMPLATE} \
  --parameter-overrides \
  ProjectName=${CFN_ProjectName} \
  VpcId=${CFN_VpcId} \
  KeyName=${CFN_KeyName} \
  ALBSubnetId1=${CFN_ALBSubnetId1} \
  ALBSubnetId2=${CFN_ALBSubnetId2} \
  ALBSecurityGroupId=${CFN_ALBSecurityGroupId} \
  ECSSecurityGroupId=${CFN_ECSSecurityGroupId} \
  ECSSubnetId1=${CFN_ECSSubnetId1} \
  ECSSubnetId2=${CFN_ECSSubnetId2} \
  ALBSecurityGroupId=${CFN_ALBSecurityGroupId} \
  ECSSecurityGroupId=${CFN_ECSSecurityGroupId} \
  ECSImageName=${CFN_ECSImageName} \
  DBMasterName=${CFN_DBMasterName} \
  DBEndPoint=${CFN_DBEndPoint} \
  DBNAME=${CFN_DBNAME} \
  --capabilities CAPABILITY_NAMED_IAM

exit 0
