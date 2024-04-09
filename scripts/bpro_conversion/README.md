# Bpro Calculated pair

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


Deploy Proxy MoC Medianizer 

```
export MNEMONIC=my PK
cd scripts/tether
truffle exec 1_deploy_ProxyMedianizerBproUsdConversion.js --network bproARSTestnet
```

### Check deploy

```
cd scripts/tether
truffle exec 2_check_deploy.js --network bproARSTestnet
```

You will get a response like this:

```
Using network 'bproARSTestnet'.

Configuration path:  /mnt/ca84bb20-3bbe-481b-8126-a4f766fed941/Documentos/Proyectos/Proxy_Oracle/scripts/bpro_conversion/configs/bproARSTestnet.json
MoC Medianizer from: 0x42D1aa307E56a7807e43D1E05F884119725F61BF
Price from contract: 86351355.208760510729311857
Valid?: true

```
