/* eslint-disable no-console */
const AdminUpgradeabilityProxy = artifacts.require('AdminUpgradeabilityProxy');

const ProxyV2TecPrice = artifacts.require('./ProxyV2TokenCollateralTecPriceProvider.sol');

const { getConfig, getNetwork, saveConfig } = require('./helper');

module.exports = async callback => {
  try {
    const network = getNetwork(process.argv);
    const configPath = `${__dirname}/configs/${network}.json`;
    const config = getConfig(network, configPath);

    // Deploy new implementation
    const proxyV2TecPrice = await ProxyV2TecPrice.new();

    // Save implementation address to config file
    config.implementationAddresses.ProxyV2TecPrice = proxyV2TecPrice.address;
    saveConfig(config, configPath);

    // Initialize contract
    const initData = await proxyV2TecPrice.contract.methods
      .initialize(
        config.governor,
        config.mocV2,
        config.tpAddress
      )
      .encodeABI();
    console.log('proxyV2TecPrice Initialized');

    const proxyMoCMedianizer = await AdminUpgradeabilityProxy.new(
      proxyV2TecPrice.address,
      config.admin,
      initData
    );

    // Save proxy address to config file
    config.proxyAddresses.ProxyV2TecPrice = proxyMoCMedianizer.address;
    saveConfig(config, configPath);

    console.log('ProxyV2TecPrice proxy address: ', proxyMoCMedianizer.address);
    console.log('ProxyV2TecPrice implementation address: ', proxyV2TecPrice.address);
  } catch (error) {
    callback(error);
  }

  callback();
};
