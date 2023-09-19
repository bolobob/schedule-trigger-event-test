#!/bin/bash -x

git fetch origin
TWO_WEEKS_AGO=$(date -d "2 weeks ago" +%s)
for branch in $(git branch -r | grep 'origin/deploy/int' | sed 's/origin\///'); do
  LAST_COMMIT_DATE=$(git show -s --format="%ci" origin/"$branch" | head -n 1)
  LAST_COMMIT_DATE_EPOCH=$(date -d "$LAST_COMMIT_DATE" +%s)

  if [ "$LAST_COMMIT_DATE_EPOCH" -lt "$TWO_WEEKS_AGO" ]; then
    git push origin --delete "$branch"
  fi
done
