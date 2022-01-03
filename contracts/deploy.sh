#!/usr/bin/env bash

NWK=se

#se
#dev
#main

DEBOT_NAME=fidosafeDebot

if [ $NWK == "se" ]
then
    NETWORK=127.0.0.1
    SIGNER=norton
    PUBKEY=0x1bdfe03401657bfb1aae235be487b9641f0056965eb5573c17ed3685750e375a
elif [ $NWK == "dev" ]
then
    NETWORK=net.ton.dev
    KEYS=keys
    SIGNER=norton
    PUBKEY=0x1bdfe03401657bfb1aae235be487b9641f0056965eb5573c17ed3685750e375a
else
    NETWORK=main.ton.dev
    KEYS=prod.keys
    SIGNER=prod_signer
    PUBKEY=0xfd4f7a9caa84e540dd0879b49f391eab9d77444821ec3029b5beeaa89959a638
fi


tondev sol compile RootTokenContract.sol
tondev sol compile TONTokenWallet.sol

TW_CODE=$(base64 -w 0 TONTokenWallet.tvc)
TW_CODE=$(tonos-cli decode stateinit --tvc TONTokenWallet.tvc | tail -n +5 | ../node_modules/node-jq/bin/jq -r .code)

NONCE=$(date +%s)
echo $TW_CODE

tondev sol compile FidosafeDAO.sol
tondev js wrap FidosafeDAO.abi.json --output ../src/contract_wrappers/FidosafeDAO.js

echo "Deploying the root token contract..."
ROOT_TOKEN_ADDRESS=$(tondev contract deploy RootTokenContract.abi.json -n $NWK -s $SIGNER -v 200000000 -d _randomNonce:$NONCE,name:"576562206d756c7469736967204669646f736166652e636f6d",symbol:"4649444f",decimals:9,wallet_code:\"$TW_CODE\" -i root_public_key_:$PUBKEY,root_owner_address_:\"0:0000000000000000000000000000000000000000000000000000000000000000\" | grep "Address:" | cut -d " " -f 4)
echo "Root token address: ${ROOT_TOKEN_ADDRESS}"

tondev sol compile FidosafeDAO.sol
DAO_ADDRESS=$(tondev contract deploy -n $NWK -s $SIGNER FidosafeDAO.sol -i maxTokensToSale:1000000000000000,tokenAddress:\"$ROOT_TOKEN_ADDRESS\" -d _randomNonce:$NONCE -v 500000000 | grep "Address:" | cut -d " " -f 4)
echo "DAO address: ${DAO_ADDRESS}"
echo "---------"
echo "---------"
echo "Run this as soon as you provision the claimer accounts:"
echo "tondev contract run -n $NWK -s $SIGNER --address $ROOT_TOKEN_ADDRESS RootTokenContract.abi.json transferOwner -i root_public_key_:0,root_owner_address_:\\\"$DAO_ADDRESS\\\""