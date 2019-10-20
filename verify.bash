#! /bin/bash

set -e

EXPECTED_REMOTE_URL="https://${GH_TOKEN}@github.com/${DRONE_REPO}"
EXPECTED_REMOTE_NAME='expected'
CSV_FILE='users.csv'
REMOTE_ORIGIN_MASTER_HEAD='1b15331985e1ee2463b7a055bc95be73c9179049'
EXPECTED_ANSWER_BRANCH='answer'

function throw() {
  MESSAGE="$1"
  echo "$MESSAGE"
  false
}

git fetch
ANSWER_BRANCH='master'
if git branch | grep --silent ${ANSWER_BRANCH}; then
    git checkout ${ANSWER_BRANCH}
    git reset --hard origin/${ANSWER_BRANCH}
else
    git checkout -b ${ANSWER_BRANCH} origin/${ANSWER_BRANCH}
fi

echo -n 'master の祖先に問題開始時点の origin/master が含まれている: '
git merge-base --is-ancestor "$REMOTE_ORIGIN_MASTER_HEAD" "heads/$ANSWER_BRANCH" || throw NG
echo OK

echo -n '正しい変更が反映されている: '
(git remote | grep "$EXPECTED_REMOTE_NAME" &> /dev/null) || git remote add "$EXPECTED_REMOTE_NAME" "$EXPECTED_REMOTE_URL"
git fetch "$EXPECTED_REMOTE_NAME" &> /dev/null
check-revision-by-file "$EXPECTED_REMOTE_NAME/$EXPECTED_ANSWER_BRANCH" "heads/$ANSWER_BRANCH" "$CSV_FILE" || throw NG

