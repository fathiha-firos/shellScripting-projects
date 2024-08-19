#!/bin/bash

###############################################################
# This script will output the admins of a particular repository
###############################################################

#Github api url
API_URL="https://api.github.com"

#Github username and personal access token
USER_NAME=$username
TOKEN=$token
#repo owner(organisation name) and repo name
REPO_OWNER=$1
REPO_NAME=$2

# function to make a GET to request to github api
function github_api_get {
	local endpoint="$1"
	local url="${API_URL}/${endpoint}"

# Sending an api get request to api url
curl -s -u "${USER_NAME}:${TOKEN}" "$url"
}

#Function to list admins
function list-admins {
local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"
collaborators=$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.admin == true) | .login')

if [[ -z "$collaborators" ]]; then
echo "No admins yet for the repo ${REPO_NAME}"
else
echo "The list of admins for ${REPO_OWNER}/${REPO_NAME} : "
echo "$collaborators"
fi
}

echo "Listing admins of ${REPO_OWNER}/${REPO_NAME} : "

#calling the function to list admins
list-admins
