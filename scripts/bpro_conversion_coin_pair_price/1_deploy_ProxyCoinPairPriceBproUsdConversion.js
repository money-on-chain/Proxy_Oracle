/* eslint-disable no-console */
const AdminUpgradeabilityProxy = artifacts.require('AdminUpgradeabilityProxy');

const ProxyCoinPairPriceBproUsdConversion = artifacts.require('./ProxyCoinPairPriceBproUsdConversion2.sol');

const { getConfig, getNetwork, saveConfig } = require('./helper');

module.exports = async callback => {
  try {
    const network = getNetwork(process.argv);
    const configPath = `${__dirname}/configs/${network}.json`;
    const config = getConfig(network, configPath);

    // Deploy new ProxyMoCCoinPairPrice implementation
    const mocCoinPairPrice = await ProxyCoinPairPriceBproUsdConversion.new();

    // Save implementation address to config file
    config.implementationAddresses.ProxyMoCCoinPairPrice = mocCoinPairPrice.address;
    saveConfig(config, configPath);

    // Initialize contract
    const initData = await mocCoinPairPrice.contract.methods
      .initialize(
        config.coinpairprice,
        config.governor,
        config.mocstate
      )
      .encodeABI();
    console.log('ProxyMoCCoinPairPrice Initialized');

    const proxyMoCCoinPairPrice = await AdminUpgradeabilityProxy.new(
      mocCoinPairPrice.address,
      config.admin,
      initData
    );

    // Save proxy address to config file
    config.proxyAddresses.ProxyMoCCoinPairPrice = proxyMoCCoinPairPrice.address;
    saveConfig(config, configPath);

    console.log('MoCCoinPairPrice proxy address: ', proxyMoCCoinPairPrice.address);
    console.log('MoCCoinPairPrice implementation address: ', mocCoinPairPrice.address);
  } catch (error) {
    callback(error);
  }

  callback();
};
