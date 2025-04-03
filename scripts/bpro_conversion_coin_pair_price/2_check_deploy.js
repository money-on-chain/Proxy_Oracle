/* eslint-disable no-console */
const ProxyAdmin = artifacts.require('ProxyAdmin');
const ProxyCoinPairPrice = artifacts.require('./ProxyCoinPairPriceBproUsdConversion2.sol');

const BigNumber = require('bignumber.js');
const { getConfig, getNetwork } = require('./helper');

module.exports = async callback => {
  try {
    const network = getNetwork(process.argv);
    const configPath = `${__dirname}/configs/${network}.json`;
    const config = getConfig(network, configPath);

    console.log(`MoC CoinPairPrice from: ${config.proxyAddresses.ProxyMoCCoinPairPrice}`);

    // Get value from contract
    const proxyCoinPairPrice = await ProxyCoinPairPrice.at(config.proxyAddresses.ProxyMoCCoinPairPrice);

    const PriceFromCoinPairPrice = await proxyCoinPairPrice.peek();

    const mocPrecision = 10 ** 18;
    const pricePrecision = BigNumber(PriceFromCoinPairPrice[0].toString()).div(mocPrecision);
    console.log(`Price from contract: ${pricePrecision.toString()}`);

    //console.log(`Price from contract: ${PriceFromCoinPairPrice[0].toString()}`);
    console.log(`Valid?: ${PriceFromCoinPairPrice[1].toString()}`);

    const lastPubBlock = await proxyCoinPairPrice.getLastPublicationBlock();
    console.log(`Last Pub Bloc: ${lastPubBlock.toString()}`);

  } catch (error) {
    callback(error);
  }
  callback();
};
