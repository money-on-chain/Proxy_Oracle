/* eslint-disable no-console */
const AdminUpgradeabilityProxy = artifacts.require('AdminUpgradeabilityProxy');

const ProxyMedianizerMocStateCalculatedPrice = artifacts.require('./ProxyMedianizerMocStateCalculatedPrice.sol');

const { getConfig, getNetwork, saveConfig } = require('./helper');

module.exports = async callback => {
  try {
    const network = getNetwork(process.argv);
    const configPath = `${__dirname}/configs/${network}.json`;
    const config = getConfig(network, configPath);

    // Deploy new ProxyMoCMedianizer implementation
    const mocMedianizer = await ProxyMedianizerMocStateCalculatedPrice.new();

    // Save implementation address to config file
    config.implementationAddresses.ProxyMoCMedianizer = mocMedianizer.address;
    saveConfig(config, configPath);

    // Initialize contract
    const initData = await mocMedianizer.contract.methods
      .initialize(
        config.medianizer,
        config.governor,
        config.mocstate
      )
      .encodeABI();
    console.log('ProxyMoCMedianizer Initialized');

    const proxyMoCMedianizer = await AdminUpgradeabilityProxy.new(
      mocMedianizer.address,
      config.admin,
      initData
    );

    // Save proxy address to config file
    config.proxyAddresses.ProxyMoCMedianizer = proxyMoCMedianizer.address;
    saveConfig(config, configPath);

    console.log('MoCMedianizer proxy address: ', proxyMoCMedianizer.address);
    console.log('MoCMedianizer implementation address: ', mocMedianizer.address);
  } catch (error) {
    callback(error);
  }

  callback();
};
