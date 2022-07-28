#!/bin/bash
BIN=/root/go/bin/cohod
. /root/.bashrc
SEQ=5202

COUNTER=0
 for k in {1..5000}
  do
   $BIN tx bank send $(cohod keys show test1 -a --keyring-backend test) $(cohod keys show test$k -a --keyring-backend test) 10000ucoho  --chain-id $CHAIN_ID --yes --keyring-backend test --note "$MONIKER"
   echo "Send test1 to test$k"
   COUNTER=$((COUNTER+1))
   SEQ=$((SEQ+1))
  done

echo "Total tx: $COUNTER"
