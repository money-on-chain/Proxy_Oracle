/* eslint-disable no-console */
const ProxyAdmin = artifacts.require('ProxyAdmin');
const ProxyDummyOracle = artifacts.require('./ProxyDummyOracle.sol');

const BigNumber = require('bignumber.js');
const { getConfig, getNetwork } = require('./helper');

module.exports = async callback => {
  try {
    const network = getNetwork(process.argv);
    const configPath = `${__dirname}/configs/${network}.json`;
    const config = getConfig(network, configPath);

    console.log(`ProxyDummyOracle from : ${config.proxyAddresses.ProxyDummyOracle}`);

    // Get value from contract
    const proxyDummyOracle = await ProxyDummyOracle.at(config.proxyAddresses.ProxyDummyOracle);

    const PriceFromDummy = await proxyDummyOracle.peek();

    const mocPrecision = 10 ** 18;
    const pricePrecision = BigNumber(PriceFromDummy[0].toString()).div(mocPrecision);
    console.log(`Price from contract: ${pricePrecision.toString()}`);

    console.log(`Valid?: ${PriceFromDummy[1].toString()}`);

  } catch (error) {
    callback(error);
  }
  callback();
};
