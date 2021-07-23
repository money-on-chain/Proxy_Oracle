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
mocMainnet   | Mainnet    | ProxyMoCMedianizer  |  | 
ethTestnet   | Testnet    | ProxyMoCMedianizer  | 0xB55866090B93F00a9d7C725D906ea55dBDA3e8D7 | 0x8e2fea7a925f5F7aF7006e351289Fcd0135B1d76
ethMainnet   | Mainnet    | ProxyMoCMedianizer  | 0x84c260568cFE148dBcFb4C8cc62C4e0b6d998F91 | 0xbCb80B5551e56B7241275211068d3f56615E4590
tetherTestnet   | Testnet    | ProxyMoCMedianizer  | 0xB48042419F737f831E93605048B85D1964822269 | 0xEF8e441B577B4e797F485AE684Eb5D5106Cc55Ad
tetherMainnet   | Mainnet    | ProxyMoCMedianizer  | 0x45c907727eD15Bd901560Ff439293E6b89de877e | 0xc78599497c42245627C69cc7CBb27F95Bb2B9646 

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

### Tether Testnet

Deploy Proxy MoC Medianizer USDT Testnet

```
export MNEMONIC=my PK
npm run deploy-tether-testnet
```

### Tether Mainnet

Deploy Proxy MoC Medianizer USDT Mainnet

```
export MNEMONIC=my PK
npm run deploy-tether-mainnet
```