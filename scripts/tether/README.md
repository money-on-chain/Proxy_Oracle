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

You will get a response like this:

```
Using network 'tetherTestnet'.

Configuration path:  /configs/tetherTestnet.json
MoC Medianizer from: 0x3Cdc0DbA0e52205bc92e5d0dA705a11bD7970D89
Price from contract: 62059.211225821749128906
Valid?: true
```
