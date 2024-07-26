/* eslint-disable no-console */
const ProxyAdmin = artifacts.require('ProxyAdmin');
const ProxyMedianizer = artifacts.require('./ProxyV2RifProPriceProvider.sol');

const BigNumber = require('bignumber.js');
const { getConfig, getNetwork } = require('./helper');

module.exports = async callback => {
  try {
    const network = getNetwork(process.argv);
    const configPath = `${__dirname}/configs/${network}.json`;
    const config = getConfig(network, configPath);

    console.log(`MoC Medianizer from: ${config.proxyAddresses.ProxyV2RifProPrice}`);

    // Get value from contract
    const proxyMedianizer = await ProxyMedianizer.at(config.proxyAddresses.ProxyV2RifProPrice);

    const PriceFromMedianizer = await proxyMedianizer.peek();

    const mocPrecision = 10 ** 18;
    const pricePrecision = BigNumber(PriceFromMedianizer[0].toString()).div(mocPrecision);
    console.log(`Price from contract: ${pricePrecision.toString()}`);

    //console.log(`Price from contract: ${PriceFromMedianizer[0].toString()}`);
    console.log(`Valid?: ${PriceFromMedianizer[1].toString()}`);

  } catch (error) {
    callback(error);
  }
  callback();
};
