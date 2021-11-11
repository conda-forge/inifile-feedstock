#!/bin/bash
function info { echo "+ $@" >&2; }

# Update PR refs for testing.
if [[ -n "${CIRCLE_PR_NUMBER}" ]]
then
    FETCH_REFS="${FETCH_REFS} +refs/pull/${CIRCLE_PR_NUMBER}/head:pr/${CIRCLE_PR_NUMBER}/head"
    FETCH_REFS="${FETCH_REFS} +refs/pull/${CIRCLE_PR_NUMBER}/merge:pr/${CIRCLE_PR_NUMBER}/merge"
fi

# Retrieve the refs.
if [[ -n "${CIRCLE_PR_NUMBER}" ]]
then
    info "fetch refs: git fetch -u origin ${FETCH_REFS}"
    git fetch -u origin ${FETCH_REFS}
fi

# Checkout the PR merge ref.
if [[ -n "${CIRCLE_PR_NUMBER}" ]]
then
    info "checkout: git checkout -qf pr/${CIRCLE_PR_NUMBER}/merge"
    git checkout -qf "pr/${CIRCLE_PR_NUMBER}/merge"
fi

# Check for merge conflicts.
if [[ -n "${CIRCLE_PR_NUMBER}" ]]
then
    info "branching" 
    git branch --merged | grep "pr/${CIRCLE_PR_NUMBER}/head" > /dev/null
fi
