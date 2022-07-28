#!/bin/bash
# * * * * * /bin/bash /root/withdraw_and_delegate.sh >> balance.log
#
BIN=/root/go/bin/cohod
. /root/.bashrc
MINBALANCE=1000000
KEYRING_BACKEND=os
CHAIN_ID=darkmatter-1
MONIKER=<>
KEY_NAME=<>
KEYPASSWD=<>
VAL_OPER=<>
KEY_WAL=<>
echo "Start.."
echo $KEY_WAL
REWARDS=$($BIN query distribution rewards $(echo $KEY_WAL) $(echo $VAL_OPER) --chain-id=darkmatter-1 -o json | jq '.rewards[].amount' | bc)
sleep 10
R=${REWARDS%%.*}
echo "Rewards: $R"
COMMISSION=$($BIN query distribution commission $(echo $VAL_OPER) -o json | jq '.commission[].amount' | bc)
sleep 10
C=${COMMISSION%%.*}
echo "Commission: $C"

REWARDS_TOTAL=$(echo "$R+$C" | bc)
echo $REWARDS_TOTAL

if [[ $(bc -l <<< "$REWARDS_TOTAL>10000000") -eq 1 ]]; then
	echo $KEYPASSWD | $BIN tx distribution withdraw-rewards $(echo $VAL_OPER) --from $(echo $KEY_WAL) --commission --chain-id=darkmatter-1 --yes
	sleep 20
else
	echo "Total rewards is too low, dont withdraw"
fi

BALANCE_S=$($BIN query bank balances  $(echo $KEY_WAL) -o json 2>/dev/null | jq '.balances[].amount')
BALANCE=$(echo $BALANCE_S | bc)
echo "Balance: "$BALANCE 
BALANCE_TO_DELEGATE=$(echo "$BALANCE-$MINBALANCE" | bc)
DENOM="ucoho"
DELEGATE_AMOUNT=$BALANCE_TO_DELEGATE$DENOM
echo "To Delegate: "$DELEGATE_AMOUNT

if [[ $(bc -l <<< "$BALANCE_TO_DELEGATE>10000000") -eq 1 ]]; then
	echo "Delegating now.."
	echo $KEYPASSWD | $BIN tx staking delegate $(echo $VAL_OPER) $DELEGATE_AMOUNT --gas auto --chain-id=darkmatter-1 --from="$KEY_NAME" --yes
else
	echo "Balance is too  low, dont delegate"
fi

echo "Done"
