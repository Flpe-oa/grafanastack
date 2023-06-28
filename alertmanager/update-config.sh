#!/bin/bash

# Replace these with the names of your parameters in AWS Parameter Store
USERNAME_PARAM_NAME="ses-smtp-username"
PASSWORD_PARAM_NAME="ses-smtp-password"

# Retrieve parameters from AWS Parameter Store
USERNAME=$(aws ssm get-parameter --name $USERNAME_PARAM_NAME --with-decryption --query "Parameter.Value" --output text)
PASSWORD=$(aws ssm get-parameter --name $PASSWORD_PARAM_NAME --with-decryption --query "Parameter.Value" --output text)

# Replace placeholders in alertmanager.yml with retrieved values
sed -i "s/\${AUTH_USERNAME}/$USERNAME/g" /etc/alertmanager/config.yml
sed -i "s/\${AUTH_PASSWORD}/$PASSWORD/g" /etc/alertmanager/config.yml

# Start Alertmanager with the updated configuration
/alertmanager --config.file=/etc/alertmanager/config.yml

