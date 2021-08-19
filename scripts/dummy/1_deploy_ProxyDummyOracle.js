/* eslint-disable no-console */
const AdminUpgradeabilityProxy = artifacts.require('AdminUpgradeabilityProxy');

const ProxyDummyOracle = artifacts.require('./ProxyDummyOracle.sol');

const { getConfig, getNetwork, saveConfig } = require('./helper');

module.exports = async callback => {
  try {
    const network = getNetwork(process.argv);
    const configPath = `${__dirname}/configs/${network}.json`;
    const config = getConfig(network, configPath);

    // Deploy new ProxyDummyOracle implementation
    const dummyOracle = await ProxyDummyOracle.new();

    // Save implementation address to config file
    config.implementationAddresses.ProxyDummyOracle = dummyOracle.address;
    saveConfig(config, configPath);

    const mocPrecision = 10 ** 18;

    // Initialize contract
    const initData = await dummyOracle.contract.methods
      .initialize(
        web3.utils.padLeft(web3.utils.numberToHex(mocPrecision), 64),
        config.governor,
      )
      .encodeABI();
    console.log('ProxyDummyOracle Initialized');

    const proxyDummyOracle = await AdminUpgradeabilityProxy.new(
      dummyOracle.address,
      config.admin,
      initData
    );

    // Save proxy address to config file
    config.proxyAddresses.ProxyDummyOracle = proxyDummyOracle.address;
    saveConfig(config, configPath);

    console.log('DummyOracle proxy address: ', proxyDummyOracle.address);
    console.log('DummyOracle implementation address: ', dummyOracle.address);
  } catch (error) {
    callback(error);
  }

  callback();
};
