#!/bin/bash
BIN=/root/go/bin/cohod
. /root/.bashrc
MINBALANCE=1000000
KEYRING_BACKEND=os
CHAIN_ID=darkmatter-1
MONIKER=grassets
KEY_NAME=grassets
KEYPASSWD=<>
VAL_OPER=<>
KEY_WAL=<>


for i in {101..10000}
do
   echo "Create $i"
   $BIN keys add test$i --keyring-backend test --output json >> wallets.json
done
