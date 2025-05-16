#!/bin/bash

register_actions_runner()
{
    actions_runner_token="$(cat /run/secrets/actions_runner_token)"
    response=$(curl -L -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $actions_runner_token" -H "X-GitHub-Api-Version: 2022-11-28" "https://api.github.com/orgs/$GITHUB_ORGANIZATION/actions/runners/registration-token")
    token=$(echo "$response" | jq -r '.token')
    ./config.sh --url https://github.com/"$GITHUB_ORGANIZATION" --token "$token"
}

unregister_actions_runner()
{
    actions_runner_token="$(cat /run/secrets/actions_runner_token)"
    response=$(curl -L -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $actions_runner_token" -H "X-GitHub-Api-Version: 2022-11-28" "https://api.github.com/orgs/$GITHUB_ORGANIZATION/actions/runners/remove-token")
    token=$(echo "$response" | jq -r '.token')
    ./config.sh remove --token "$token"
}

register_actions_runner
trap unregister_actions_runner EXIT
./run.sh
