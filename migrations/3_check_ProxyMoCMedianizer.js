/* eslint-disable no-console */
const ProxyMoCMedianizer = artifacts.require('./ProxyMoCMedianizer.sol');

const BigNumber = require('bignumber.js');
const { getConfig, getNetwork } = require('./helper');

module.exports = async callback => {
  try {
    const network = getNetwork(process.argv);
    const configPath = `${__dirname}/configs/${network}.json`;
    const config = getConfig(network, configPath);

    console.log(`ProxyMoCMedianizer from: ${config.proxyAddresses.ProxyMoCMedianizer}`);

    // Get value from contract
    const proxyMoCMedianizer = await ProxyMoCMedianizer.at(config.proxyAddresses.ProxyMoCMedianizer);

    const PriceFromProxy = await proxyMoCMedianizer.peek();

    const mocPrecision = 10 ** 18;
    const pricePrecision = BigNumber(PriceFromProxy[0].toString()).div(mocPrecision);
    console.log(`Price from contract: ${pricePrecision.toString()}`);

    console.log(`Valid?: ${PriceFromProxy[1].toString()}`);

  } catch (error) {
    callback(error);
  }
  callback();
};
