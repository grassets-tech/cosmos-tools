#!/bin/bash

BLOCK_START=167640
BLOCK_END=169350
NL=$'\n'

for BLOCK in {167640..169350}; do
        echo "BLOCK: $BLOCK "
        MEMO=$(eval cohod query txs --events 'tx.height=${BLOCK}' -o json | jq -r '.txs[].tx.body.memo')
        MEMOS+="${MEMO}${NL}"
        echo "$MEMOS"
        #MEMOS+=$(eval cohod query txs --events 'tx.height=${BLOCK}' -o json | jq -r '.txs[].tx.body.memo')
    done

MEMOS=($(echo $MEMOS))
(IFS=$'\n'; sort <<< "${MEMOS[*]}") | uniq -c | grep -v '1 '
