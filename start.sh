#!/bin/sh
set -e

INPUT_YOU_TOKEN=${INPUT_YOU_TOKEN:-$GITHUB_TOKEN}
INPUT_DIRECTORY=${INPUT_DIRECTORY:-'./'}
INPUT_BRANCH=${INPUT_BRANCH:-'master'}
INPUT_FORCE=${INPUT_FORCE:-false}
INPUT_TAGS=${INPUT_TAGS:-false}
_FORCE_OPTION=''
_TAGS_OPTION=''


echo "Push to branch $INPUT_BRANCH";
[ -z "${INPUT_YOU_TOKEN}" ] && {
    echo 'Missing input "github_token: ${{ secrets.GITHUB_TOKEN }}".';
    exit 1;
};

if $INPUT_FORCE; then
    _FORCE_OPTION='--force'
fi

if $INPUT_TAGS; then
    _TAGS_OPTION='--tags'
fi

cd ${INPUT_DIRECTORY}

remote_repo="https://${INPUT_YOU_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

git push --force $remote_repo HEAD:${INPUT_BRANCH} --follow-tags $_FORCE_OPTION $_TAGS_OPTION

