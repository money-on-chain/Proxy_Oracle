# DOC Dummy Price DOC/USD

## Usage

### Deploy

first install required packages

```
nvm install 8.17
npm install
```

compile truffle

```
npm run truffle-compile
```


Deploy Proxy Dummy Oracle testnet

```
export MNEMONIC=<my-private-key>
cd scripts/dummy
truffle exec 1_deploy_ProxyDummyOracle.js --network dummyTestnet
```

Replace `<my-private-key>` with the private key that will do the deploy

### Check deploy

```
cd scripts/dummy
truffle exec 2_check_deploy.js --network dummyTestnet
```

You will get a response like this:

```
Using network 'dummyTestnet'.

Configuration path: /configs/dummyTestnet.json
ProxyDummyOracle from: 0x0e8E63721E49dbde105a4085b3D548D292Edf38A
Price from contract: 1
Valid?: true
```
