# Token collateral Price V2 contracts

this is the price provider proxy oracle (interface peek()) for the token collateral V2 contracts.

**Example:**

In RoC Project Token collateral is RIFPro. 
IN Flipmoney Project Token Collateral is BPro Max.

To use we need to know the  address of MoCV2 Contract and TP Address in 
ROC Project TP address is the address of token pegged USDRIF.

**Note**: This only works with 1 only token pegged.

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

Fill config/rocTestnetV2.json with:

*mocV2:* MoC V2 contract address
*tpAddress:* Token pegged for example in ROC is USDRIF Token Address

```
{
  "mocV2": "0xa416934264515bb381E3b746f10f22D5c6f9431a",
  "tpAddress": "0x8dbf326e12a9fF37ED6DDF75adA548C2640A6482",
  "governor": "0x4eAC4518e81B3A5198aADAb998D2610B46aAA609",
  "admin": "0xffb65F6E24806B7e1A988EeD1Ad07BB2654fF695",
...
}
```

Deploy Proxy MoC Medianizer V2 Token Collateral Technical Price Provider

```
export MNEMONIC=my PK
cd scripts/v2_token_collateral
truffle exec 1_deploy_ProxyV2TokenCollateralTecPriceProvider.js --network rocTestnetV2
```

### Check deploy

```
cd scripts/v2_token_collateral
truffle exec 2_check_deploy.js --network rocTestnetV2
```

You will get a response like this:

```
Using network 'rocTestnetV2'.

MoC Medianizer from: 0x72B6F48328Ff1f8234AE75511c3cAc7768583526
Price from contract: 0.850054189862249188
Valid?: true


```
