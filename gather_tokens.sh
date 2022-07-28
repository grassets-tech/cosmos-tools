BIN=/root/go/bin/cohod
. /root/.bashrc
SEQ=5202

COUNTER=0
 for k in {5000..7000}
  do
   BALANCE_S=$($BIN query bank balances  $(cohod keys show test$k -a --keyring-backend test) -o json 2>/dev/null | jq '.balances[].amount')
   BALANCE=$(echo $BALANCE_S | bc)
   echo "Balance: "$BALANCE
   $BIN tx bank send $(cohod keys show test$k -a --keyring-backend test) $(cohod keys show test1 -a --keyring-backend test) ${BALANCE}ucoho  --chain-id $CHAIN_ID --yes --keyring-backend test --gas 55000 --note $MONIKER
   echo "Send $BALANCE_S  account: test$k"
   SEQ=$((SEQ+1))
  done
