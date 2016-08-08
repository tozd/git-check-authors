#!/bin/bash -e

ROOT_COMMIT=$(git rev-list --max-parents=0 HEAD)
AUTHORS=.gitauthors

# Load known authors.
declare -A KNOWN_AUTHORS
for author in $(cat ${AUTHORS}); do
  KNOWN_AUTHORS[${author}]="ok"
done

# Check that all authors are present in the authors file.
echo "Checking whether all commit authors are known..."

failures=0
for entry in $(git log ${ROOT_COMMIT}.. --format="%H:%aE" --reverse); do
  IFS=':' read -ra atoms <<< "${entry}"
  commit=${atoms[0]}
  author=${atoms[1]}
  if [ -z "${KNOWN_AUTHORS[${author}]}" ]; then
    echo "Commit ${commit} has an unknown author '${author}'."
    failures=1
  fi
done

if [ "${failures}" == "0" ]; then
  echo "All commit authors verified."
else
  echo "Unknown authors found."
  exit 1
fi

# Check that all committers are present in the authors file.
echo "Checking whether all commit committers are known..."

# Special case for GitHub committer. GitHub
# uses it when interacting through the web interface.
KNOWN_AUTHORS["noreply@github.com"]="ok"

failures=0
for entry in $(git log ${ROOT_COMMIT}.. --format="%H:%cE" --reverse); do
  IFS=':' read -ra atoms <<< "${entry}"
  commit=${atoms[0]}
  committer=${atoms[1]}
  if [ -z "${KNOWN_AUTHORS[${committer}]}" ]; then
    echo "Commit ${commit} has an unknown committer '${committer}'."
    failures=1
  fi
done

if [ "${failures}" == "0" ]; then
  echo "All commit committers verified."
else
  echo "Unknown committers found."
  exit 1
fi
