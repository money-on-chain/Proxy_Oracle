# Proxy Oracle

This is a proxy contract to MoC Medianizer or Decentralized Oracle, can change (upgrade) the moc medianizer to decentralized oracle
when new version is ready (soon).

**MoC Medianizer:** Current implementations of oracles.

**Decentralized Oracle:** Next generations or oracles.


## Interface

Take a look to Oracle Interface. It return tuple, the price in wei and boolean if is valid result.
Note: If its not valid consider not used or raise an error because the price is out of time limit.

```
pragma solidity 0.5.8;

/**
 * @dev Interface of MoCs Oracles
 */
interface IMoCBaseOracle {
  function peek() external view returns (bytes32, bool);
}
```

## Already deployed contract

Enviroment   | Network    | Contract Name       | Proxy Contract Address                     | Implementation Contract Address
------------ | ---------- | ------------------- | -------------------------------------------|--------------------------------
mocTestnet   | Testnet    | ProxyMoCMedianizer  | 0xE25F5C08029cDAA3F86e782D79aC3B4578bFaa64 | 0x5604d381E745907Ca0fd50d952B1e88C5B7Ab8DC
mocMainnet   | Testnet    | ProxyMoCMedianizer  |  | 
ethTestnet   | Testnet    | ProxyMoCMedianizer  | 0xB55866090B93F00a9d7C725D906ea55dBDA3e8D7 | 0x8e2fea7a925f5F7aF7006e351289Fcd0135B1d76
ethMainnet   | Testnet    | ProxyMoCMedianizer  |  | 

## Deploy 

first install required packages

```
npm install
```

compile truffle

```
npm run truffle-compile
```

### MoC Testnet

Deploy Proxy MoC Medianizer Moc Testnet

```
export MNEMONIC=my PK
npm run deploy-moc-testnet
```

### MoC Mainnet

Deploy Proxy MoC Medianizer Moc Mainnet

```
export MNEMONIC=my PK
npm run deploy-moc-mainnet
```

### Eth Testnet

Deploy Proxy MoC Medianizer Eth Testnet

```
export MNEMONIC=my PK
npm run deploy-eth-testnet
```

### Eth Mainnet

Deploy Proxy MoC Medianizer Eth Mainnet

```
export MNEMONIC=my PK
npm run deploy-eth-mainnet
```