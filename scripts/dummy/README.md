# DOC Dummy Price DOC/USD

## Usage

### Deploy

first install required packages

```
npm install
```

compile truffle

```
npm run truffle-compile
```


Deploy Proxy Dummy Oracle testnet

```
export MNEMONIC=my PK
cd scripts/dummy
truffle exec 1_deploy_ProxyDummyOracle.js --network dummyTestnet
```

### Check deploy

```
cd scripts/dummy
truffle exec 2_check_deploy.js --network dummyTestnet
```
