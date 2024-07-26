/* eslint-disable no-console */
const AdminUpgradeabilityProxy = artifacts.require('AdminUpgradeabilityProxy');

const ProxyV2RifProPrice = artifacts.require('./ProxyV2RifProPriceProvider.sol');

const { getConfig, getNetwork, saveConfig } = require('./helper');

module.exports = async callback => {
  try {
    const network = getNetwork(process.argv);
    const configPath = `${__dirname}/configs/${network}.json`;
    const config = getConfig(network, configPath);

    // Deploy new implementation
    const proxyV2RifProPrice = await ProxyV2RifProPrice.new();

    // Save implementation address to config file
    config.implementationAddresses.ProxyV2RifProPrice = proxyV2RifProPrice.address;
    saveConfig(config, configPath);

    // Initialize contract
    const initData = await proxyV2RifProPrice.contract.methods
      .initialize(
        config.governor,
        config.mocV2,
        config.tpAddress
      )
      .encodeABI();
    console.log('proxyV2RifProPrice Initialized');

    const proxyMoCMedianizer = await AdminUpgradeabilityProxy.new(
      proxyV2RifProPrice.address,
      config.admin,
      initData
    );

    // Save proxy address to config file
    config.proxyAddresses.ProxyV2RifProPrice = proxyMoCMedianizer.address;
    saveConfig(config, configPath);

    console.log('ProxyV2RifProPrice proxy address: ', proxyMoCMedianizer.address);
    console.log('ProxyV2RifProPrice implementation address: ', proxyV2RifProPrice.address);
  } catch (error) {
    callback(error);
  }

  callback();
};
