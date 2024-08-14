#!/usr/bin/env bash

FLATTENER="node_modules/.bin/truffle-flattener"
OUTPUTDIR="scripts/contract_flatten/"
CONTRACTS="contracts/ProxyMoCMedianizer.sol contracts/ProxyMedianizerMocStateCalculatedPrice.sol contracts/ProxyDummyOracle.sol zos-lib/contracts/upgradeability/AdminUpgradeabilityProxy.sol contracts/ProxyMedianizerBproUsdConversion2.sol contracts/ProxyOracleBproUsd2.sol"
HEADER="scripts/license.txt"

# Working directory: the root of the project
cd "$(dirname "$0")/.."

echo "Starting to flatten our contracts"

# Iterate the contract list 
for CONTRACT in $CONTRACTS; do

    echo File: $(basename "$CONTRACT")

    # Output file
    OUTPUTFILE=$OUTPUTDIR$(basename "$CONTRACT" .sol)_flat.sol

    # Insert header/license to flat file
    cat $HEADER > $OUTPUTFILE

    # Flattener...
    $FLATTENER $CONTRACT >> $OUTPUTFILE

done

echo "Finish successfully! Take a look in folder $OUTPUTDIR..."
