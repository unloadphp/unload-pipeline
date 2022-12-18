#!/bin/bash
ROLE=$1
SESSION_NAME=$2
TOKEN=$3

unset AWS_SESSION_TOKEN

# Use assume-role-with-web-identity instead of assume-role
cred=$(aws sts assume-role-with-web-identity --role-arn "$ROLE" \
                        --role-session-name "$SESSION_NAME" \
                        --web-identity-token "$TOKEN" \
                        --query '[Credentials.AccessKeyId,Credentials.SecretAccessKey,Credentials.SessionToken]' \
                        --output text)

export AWS_ACCESS_KEY_ID=$(echo "$cred" | awk '{ print $1 }')
export AWS_SECRET_ACCESS_KEY=$(echo "$cred" | awk '{ print $2 }')
export AWS_SESSION_TOKEN=$(echo "$cred" | awk '{ print $3 }')
