#!/bin/bash

# Suggested by Github actions to be strict
# Taken from https://www.github.com/vsoch/pull-request-action
set -e
set -o pipefail

################################################################################
# Global Variables (we can't use GITHUB_ prefix)
################################################################################

API_VERSION=v3
BASE=https://api.github.com
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"
HEADER="Accept: application/vnd.github.${API_VERSION}+json"
HEADER="${HEADER}; application/vnd.github.antiope-preview+json; application/vnd.github.shadow-cat-preview+json"

# URLs
REPO_URL="${BASE}/repos/${GITHUB_REPOSITORY}"
PULLS_URL=$REPO_URL/pulls

################################################################################
# Get Markdown from the Payload for new Branch
################################################################################

event_name=$(jq --raw-output .client_payload.event_name "${GITHUB_EVENT_PATH}")
if [ "${event_name}" != "${EVENT_NAME}" ]; then
    echo "Dispatch Event is not intended to update template"
    exit 0;
fi
USERNAME=$(jq --raw-output .client_payload.username "${GITHUB_EVENT_PATH}");
TEMPLATE_FILES=$(jq --raw-output .client_payload.files "${GITHUB_EVENT_PATH}");
export BRANCH_FROM="update/term-${USERNAME}-$(date '+%Y-%m-%d')";
echo "Requested by ${USERNAME}";
echo "GitHub Actor: ${GITHUB_ACTOR}";
git remote set-url origin "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git";
git branch;
git checkout -b "${BRANCH_FROM}";
git branch;
git config --global user.name "github-actions";
git config --global user.email "github-actions@users.noreply.github.com";
git add "${TEMPLATE_FILES}";
git commit -m "Request review of term by ${USERNAME} $(date '+%Y-%m-%d')" --allow-empty;
git push origin "${BRANCH_FROM}";

################################################################################
# Helper Functions
################################################################################


check_credentials() {

    if [[ -z "${GITHUB_TOKEN}" ]]; then
        echo "You must include the GITHUB_TOKEN as an environment variable."
        exit 1
    fi

}

check_events_json() {

    if [[ ! -f "${GITHUB_EVENT_PATH}" ]]; then
        echo "Cannot find Github events file at ${GITHUB_EVENT_PATH}";
        exit 1;
    fi
    echo "Found ${GITHUB_EVENT_PATH}";
    
}

create_pull_request() {

    SOURCE="${1}"  # from this branch
    TARGET="${2}"  # pull request TO this target

    # The calling function can export the title or body
    if [ -z "${TITLE}" ]; then
        TITLE="Request for Term Update Review"
    fi
    if [ -z "${BODY}" ]; then
        BODY='This is a pull request to request review for changes to the term README.md.'
    fi

    DATA="{\"base\":\"${TARGET}\", \"head\":\"${SOURCE}\", \"body\":\"${BODY}\"}"
    RESPONSE=$(curl -sSL -H "${AUTH_HEADER}" -H "${HEADER}" --user "${GITHUB_ACTOR}" -X GET --data "${DATA}" ${PULLS_URL})
    PR=$(echo "${RESPONSE}" | jq --raw-output '.[] | .head.ref')
    echo "Response ref: ${PR}"

    # Option 1: The pull request is already open
    if [[ "${PR}" == "${SOURCE}" ]]; then
        echo "Pull request from ${SOURCE} to ${TARGET} is already open!"

    # Option 2: Open a new pull request
    else
        # Post the pull request
        DATA="{\"title\":\"${TITLE}\", \"base\":\"${TARGET}\", \"head\":\"${SOURCE}\", \"body\":\"${BODY}\"}"
        echo "curl --user ${GITHUB_ACTOR} -X POST --data ${DATA} ${PULLS_URL}"
        curl -sSL -H "${AUTH_HEADER}" -H "${HEADER}" --user "${GITHUB_ACTOR}" -X POST --data "${DATA}" ${PULLS_URL} -o PR_RESPONSE.json
        echo $?
    fi
}


main () {

    # path to file that contains the POST response of the event
    # Example: https://github.com/actions/bin/tree/master/debug
    # Value: /github/workflow/event.json
    check_events_json;

    # User specified branch for PR
    if [ -z "${BRANCH_FROM}" ]; then
        echo "You must specify a branch to PR from."
        exit 1
    fi
    echo "Branch for pull request is $BRANCH_FROM"

    if [ -z "${BRANCH_AGAINST}" ]; then
        BRANCH_AGAINST=master
    fi
    echo "Pull request will go against ${BRANCH_AGAINST}"

    # Ensure we have a GitHub token
    check_credentials
    create_pull_request $BRANCH_FROM $BRANCH_AGAINST

}

echo "==========================================================================
START: Creating Review Request Pull Request!";
main;
echo "==========================================================================
END: Finished";
