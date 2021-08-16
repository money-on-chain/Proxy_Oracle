# Tether Calculated Price USDT/DOC

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


Deploy Proxy MoC Medianizer Tether testnet

```
export MNEMONIC=my PK
cd scripts/tether
truffle exec 1_deploy_ProxyMedianizerMocStateCalculatedPrice.js --network tetherTestnet
```

### Check deploy

```
cd scripts/tether
truffle exec 2_check_deploy.js --network tetherTestnet
```
