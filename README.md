# Proxy Oracle

Proxy Governed Oracle

## Interface

Take a look to Oracle Interface. It return tuple, the price in wei and boolean if is valid result.
Note: If its not valid consider not used or raise an error because the price is out time limit.

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
ethTestnet   | Testnet    | ProxyMoCMedianizer  |  | 
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

1. Deploy Proxy MoC Medianizer Moc Testnet

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