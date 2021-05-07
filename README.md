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

Token pair      | Base Token address                          | Secondary Token address                     | MO
--------------- | ------------------------------------------- | ------------------------------------------- | -----
DOC/WRBTC        | 0xe700691dA7b9851F2F35f8b8182c69c53CcaD9Db | 0x967f8799aF07DF1534d48A95a5C9FEBE92c53ae0  | Yes
DOC/RDOC         | 0xe700691dA7b9851F2F35f8b8182c69c53CcaD9Db | 0x2d919F19D4892381D58edeBeca66D5642Cef1a1f  | Yes
DOC/BPRO         | 0xe700691dA7b9851F2F35f8b8182c69c53CcaD9Db | 0x440CD83C160De5C96Ddb20246815eA44C7aBBCa8  | Yes
WRBTC/BPRO       | 0x967f8799aF07DF1534d48A95a5C9FEBE92c53ae0 | 0x440CD83C160De5C96Ddb20246815eA44C7aBBCa8  | Yes
DOC/RIF          | 0xe700691dA7b9851F2F35f8b8182c69c53CcaD9Db | 0x2acc95758f8b5f583470ba265eb685a8f45fc9d5  | Yes
RDOC/RIFP        | 0x2d919F19D4892381D58edeBeca66D5642Cef1a1f | 0xf4d27c56595Ed59B66cC7F03CFF5193e4bd74a61  | Yes
RIF/RIFP         | 0x2acc95758f8b5f583470ba265eb685a8f45fc9d5 | 0xf4d27c56595Ed59B66cC7F03CFF5193e4bd74a61  | Yes
WRBTC/RIF        | 0x967f8799aF07DF1534d48A95a5C9FEBE92c53ae0 | 0x2acc95758f8b5f583470ba265eb685a8f45fc9d5  | No


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