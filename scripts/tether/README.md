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
MoC Medianizer from: 0xb0445b003F701a99eD1a733d8C3Eb2bDa58D7622
Price from contract: 0.999189012426422561
Valid?: true
```
