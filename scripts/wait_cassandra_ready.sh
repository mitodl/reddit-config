#!/usr/bin/env bash

which nodetool

if [[ $? -ne 0 ]]; then
  echo "nodetool not installed, skipping"
  exit
fi

while true; do
  nodetool info 2>/dev/null | grep -E "Thrift\sactive\s+:\s+true"
  if [[ $? -eq 0 ]]; then
    echo "Cassandra thrift ready"
    exit
  fi
  sleep 3
done
