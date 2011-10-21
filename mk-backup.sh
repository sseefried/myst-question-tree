#!/bin/bash

echo [+] Create a new backup and delete the oldest one
echo heroku pgbackups:capture --expire

NEW_DB=$(heroku pgbackups | tail -1 | awk '{ print $1}')
DIR=~/db-backups/myst-question-tree
mkdir -p $DIR
FILE="$DIR/myst-db-$(date +%F).sql"
curl $(heroku pgbackups:url $NEW_DB) -o $FILE
gzip $FILE


