#!/bin/bash

source envfile

if [ -z "$CFN_ProjectName" ]; then
  echo "環境変数CFN_ProjectNameが設定されていません" >&2
  exit 1
fi

TEMPLATE_NAME=fargate-codepipeline-github

CFN_TEMPLATE=${TEMPLATE_NAME}.yml
CFN_STACK_NAME=${CFN_ProjectName}-${TEMPLATE_NAME}

# テンプレートの実行
aws cloudformation deploy --stack-name ${CFN_STACK_NAME} --template-file ${CFN_TEMPLATE} \
  --parameter-overrides \
  Cluster=${CFN_Cluster} \
  Service=${CFN_Service} \
  ContainerName=${CFN_ContainerName} \
  ECRName=${CFN_ECRName} \
  GitHubAccountName=${CFN_GitHubAccountName} \
  GitHubRepositoryName=${CFN_GitHubRepositoryName} \
  GitHubSecret=${CFN_GitHubSecret} \
  Branch=${CFN_Branch} \
  BuildProjectName=${CFN_BuildProjectName} \
  PipelineName=${CFN_PipelineName} \
  --capabilities CAPABILITY_NAMED_IAM

exit 0
