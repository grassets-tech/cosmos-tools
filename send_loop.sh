#!/bin/bash
BIN=/root/go/bin/cohod
. /root/.bashrc

COUNTER=0
i=1
while [ $i -le 5000 ]
do
 for k in {1..5000}
  do
   $BIN tx bank send $(cohod keys show test$k -a --keyring-backend test) $(cohod keys show test$i -a --keyring-backend test) 1ucoho  --chain-id $CHAIN_ID --yes --keyring-backend test --note "$MONIKER" --fees 300ucoho
   COUNTER=$((COUNTER+1))
   echo "Send test$k to test$i"
  done

  i=$((i+1))
  if [ $i -eq 5001 ];
   then
     i=1
  fi
echo "Total tx: $COUNTER"
done
