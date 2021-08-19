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

| Enviroment    | Network | Contract Name        | Proxy Contract Address                       | Implementation Contract Address              |
| ------------- | ------- | :------------------: | :------------------------------------------: | :------------------------------------------: |
| mocTestnet    | Testnet | `ProxyMoCMedianizer` | `0xE25F5C08029cDAA3F86e782D79aC3B4578bFaa64` | `0x5604d381E745907Ca0fd50d952B1e88C5B7Ab8DC` |
| mocMainnet    | Mainnet | `ProxyMoCMedianizer` | *it's still pending*                         | *it's still pending*                         |
| ethTestnet    | Testnet | `ProxyMoCMedianizer` | `0xB55866090B93F00a9d7C725D906ea55dBDA3e8D7` | `0x8e2fea7a925f5F7aF7006e351289Fcd0135B1d76` |
| ethMainnet    | Mainnet | `ProxyMoCMedianizer` | `0x84c260568cFE148dBcFb4C8cc62C4e0b6d998F91` | `0xbCb80B5551e56B7241275211068d3f56615E4590` |
| tetherTestnet | Testnet | `ProxyMoCMedianizer` | `0xB48042419F737f831E93605048B85D1964822269` | `0xEF8e441B577B4e797F485AE684Eb5D5106Cc55Ad` |
| tetherMainnet | Mainnet | `ProxyMoCMedianizer` | `0x45c907727eD15Bd901560Ff439293E6b89de877e` | `0xc78599497c42245627C69cc7CBb27F95Bb2B9646` |
| rifTestnet    | Testnet | `ProxyMoCMedianizer` | *it's still pending*                         | *it's still pending*                         |
| rifMainnet    | Mainnet | `ProxyMoCMedianizer` | *it's still pending*                         | *it's still pending*                         |

## Procedure 

first install required packages

```
npm install
```

compile truffle

```
npm run truffle-compile
```

### Scripts

| Oracle | Network | Deploy script           | Check script           |
| ------ | ------- | ----------------------- | ---------------------- |
| MoC    | Testnet | `deploy-moc-testnet`    | `check-moc-testnet`    |
| MoC    | Mainnet | `deploy-moc-mainnet`    | `check-moc-mainnet`    |
| Eth    | Testnet | `deploy-eth-testnet`    | `check-eth-testnet`    |
| Eth    | Mainnet | `deploy-eth-mainnet`    | `check-eth-mainnet`    |
| Tether | Testnet | `deploy-tether-testnet` | `check-tether-testnet` |
| Tether | Mainnet | `deploy-tether-mainnet` | `check-tether-mainnet` |
| RIF    | Testnet | `deploy-rif-testnet`    | `check-rif-testnet`    |
| RIF    | Mainnet | `deploy-rif-mainnet`    | `check-rif-mainnet`    |

### Deploy

```
export MNEMONIC=<my-private-key>
npm run <deploy-script>
```

Replace `<my-private-key>` with the private key that will do the deploy

Replace `<deploy-script>` with the *Deploy script* that comes out of the table above, depending on the *Oracle* and the *Network*

### Check

```
npm run <check-script>
```

Replace `<check-script>` with the *Check script* that comes out of the table above, depending on the *Oracle* and the *Network*

Example:

```
user@workstation:~/Proxy_Oracle$ npm run check-moc-testnet

> proxy-oracle@1.0.0 check-moc-testnet /home/user/Proxy_Oracle
> cd migrations/; truffle exec 3_check_ProxyMoCMedianizer.js --network mocTestnet

Using network 'mocTestnet'.

Configuration path:  /home/user/Proxy_Oracle/migrations/configs/mocTestnet.json
ProxyMoCMedianizer from: 0xb76c405Dfd042D88FD7b8dd2e5d66fe7974A1458
Price from contract: 45574.27795462
Valid?: true
user@workstation:~/Proxy_Oracle$
```
