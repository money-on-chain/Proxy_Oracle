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

| Pair         | Network | Proxy Contract Address                       | Implementation Contract Address              | Contract Name                            | Enviroment    |
| ------------ | ------- | :------------------------------------------: | :------------------------------------------: | ---------------------------------------- | ------------- |
| `BTC`/`USD`  | Testnet | `0xb76c405Dfd042D88FD7b8dd2e5d66fe7974A1458` | `0xC3A9B88BD40ab144B377B32045062847b79A84Be` | `ProxyMoCMedianizer`                     | mocTestnet    |
| `BTC`/`USD`  | Mainnet | `0x972a21C61B436354C0F35836195D7B67f54E482C` | `0xEC1Ac4d34319Ba7B6bbD920C168413320Edd0f4F` | `ProxyMoCMedianizer`                     | mocMainnet    |
| `ETH`/`USD`  | Testnet | `0xB55866090B93F00a9d7C725D906ea55dBDA3e8D7` | `0x8e2fea7a925f5F7aF7006e351289Fcd0135B1d76` | `ProxyMoCMedianizer`                     | ethTestnet    |
| `ETH`/`USD`  | Mainnet | `0x84c260568cFE148dBcFb4C8cc62C4e0b6d998F91` | `0xbCb80B5551e56B7241275211068d3f56615E4590` | `ProxyMoCMedianizer`                     | ethMainnet    |
| `BTC`/`USDT` | Testnet | `0xB48042419F737f831E93605048B85D1964822269` | `0xEF8e441B577B4e797F485AE684Eb5D5106Cc55Ad` | `ProxyMoCMedianizer`                     | tetherTestnet |
| `BTC`/`USDT` | Mainnet | `0x45c907727eD15Bd901560Ff439293E6b89de877e` | `0xc78599497c42245627C69cc7CBb27F95Bb2B9646` | `ProxyMoCMedianizer`                     | tetherMainnet |
| `RIF`/`USD`  | Testnet | `0xd153c1eDd498f66BC9d6D8069ECBBc2fb2fEcd4b` | `0xe664D22aa3d37b9Be1a545A1b540cFEd40B3E72b` | `ProxyMoCMedianizer`                     | rifTestnet    |
| `RIF`/`USD`  | Mainnet | `0xDb76a2816Def5Dd206Ba0A8a50b7b57f414ef17D` | `0x997eF33BE0D599AB3Df4792039a14fb3cF3CAEaC` | `ProxyMoCMedianizer`                     | rifMainnet    |
| `USDT`/`USD` | Testnet | `0xb0445b003F701a99eD1a733d8C3Eb2bDa58D7622` | `0xa81ffD4d154917a28575A0717530865E466b2636` | `ProxyMedianizerMocStateCalculatedPrice` | tetherTestnet |
| `USDT`/`USD` | Mainnet | `0x45c907727eD15Bd901560Ff439293E6b89de877e` | `0xc78599497c42245627C69cc7CBb27F95Bb2B9646` | `ProxyMedianizerMocStateCalculatedPrice` | tetherMainnet |
| `DOC`/`USD`  | Testnet | `0x0e8E63721E49dbde105a4085b3D548D292Edf38A` | `0xF13Fc9FDbbf059497815d834864ABc300aAe13e1` | `ProxyDummyOracle`                       | dummyTestnet  |
| `DOC`/`USD`  | Mainnet | `0xb1a98C46f9b9Ce9f4b26d5A44f8a70375e06aC02` | `0x2958a89d955E674A44bde1f834254586E736c451` | `ProxyDummyOracle`                       | dummyMainnet  |

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

| Oracle     | Network | Deploy script                      | Check script                      |
| ---------- | ------- | ---------------------------------- | --------------------------------- |
| MoC        | Testnet | `deploy-moc-testnet`               | `check-moc-testnet`               |
| MoC        | Mainnet | `deploy-moc-mainnet`               | `check-moc-mainnet`               |
| Eth        | Testnet | `deploy-eth-testnet`               | `check-eth-testnet`               |
| Eth        | Mainnet | `deploy-eth-mainnet`               | `check-eth-mainnet`               |
| Tether     | Testnet | `deploy-tether-testnet`            | `check-tether-testnet`            |
| Tether     | Mainnet | `deploy-tether-mainnet`            | `check-tether-mainnet`            |
| RIF        | Testnet | `deploy-rif-testnet`               | `check-rif-testnet`               |
| RIF        | Mainnet | `deploy-rif-mainnet`               | `check-rif-mainnet`               |
| Calculated | Testnet | `deploy-calculated-tether-testnet` | `check-calculated-tether-testnet` |
| Calculated | Mainnet | `deploy-calculated-tether-mainnet` | `check-calculated-tether-mainnet` | 
| Dummy      | Testnet | `deploy-dummy-testnet`             | `check-dummy-testnet`             |
| Dummy      | Mainnet | `deploy-dummy-mainnet`             | `check-dummy-mainnet`             |

### Deploy

```
export MNEMONIC=<my-private-key>
npm run <deploy-script>
```

Replace `<my-private-key>` with the private key that will do the deploy

Replace `<deploy-script>` with the *Deploy script* that comes out of the table above, depending on the *Oracle* and the *Network*

Example:

```
user@workstation:~/Proxy_Oracle$ npm run deploy-rif-testnet

> proxy-oracle@1.0.0 deploy-rif-testnet /home/user/Proxy_Oracle
> cd migrations/; truffle exec 2_deploy_ProxyMoCMedianizer.js --network rifTestnet

Using network 'rifTestnet'.

Configuration path:  /home/user/Proxy_Oracle/migrations/configs/rifTestnet.json
ProxyMoCMedianizer Initialized
MoCMedianizer proxy address:  0xd153c1eDd498f66BC9d6D8069ECBBc2fb2fEcd4b
MoCMedianizer implementation address:  0xe664D22aa3d37b9Be1a545A1b540cFEd40B3E72b
user@workstation:~/Proxy_Oracle$
```

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
