#!/usr/bin/env bash
echo "Starting to flatten our contracts"
node_modules/.bin/truffle-flattener contracts/ProxyMoCMedianizer.sol > scripts/contract_flatten/ProxyMoCMedianizer_flat.sol
node_modules/.bin/truffle-flattener zos-lib/contracts/upgradeability/AdminUpgradeabilityProxy.sol > scripts/contract_flatten/AdminUpgradeabilityProxy_flat.sol
echo "Finish successfully! Take a look in folder scripts/contract_flatten/..."