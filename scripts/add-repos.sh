#!/bin/sh
for dir in $(ls -d charts/*/); do
  helm dependency list $dir 2> /dev/null | tail +2 | head -n -1 | awk '{ print "helm repo add " $1 " " $3 }' | while read cmd; do
    repo_name=$(echo $cmd | awk '{print $4}')
    if ! helm repo list | grep -q $repo_name; then
      $cmd
    else
      echo "Repository $repo_name already exists"
    fi
  done
done
echo "Updating repos"
helm repo update
echo "Starting ling"
ct lint --config ct.yaml