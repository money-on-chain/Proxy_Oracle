/* eslint-disable no-console */
//const AdminUpgradeabilityProxy = artifacts.require('AdminUpgradeabilityProxy');
const PancakePriceOracle = artifacts.require('./PancakePriceOracle.sol');

const { getConfig, getNetwork, saveConfig } = require('./helper');

const vtcb = '0x76eDbF5ec4825833479E44A26F7A4D1285295eC7';
const wbnb = '0xae13d989daC2f0dEbFf460aC112a837C89BAa7cd';


module.exports = async callback => {
  try {
    const network = getNetwork(process.argv);
    const configPath = `${__dirname}/configs/${network}.json`;
    const config = getConfig(network, configPath);

    // Deploy new ProxyMoCMedianizer implementation
    //const mocMedianizer = await ProxyMoCMedianizer.new();
    const pancakePriceOracle = await PancakePriceOracle.new();

    // Save implementation address to config file
    //config.implementationAddresses.PancakePriceOracle = pancakePriceOracle.address;
    config.PancakePriceOracle = pancakePriceOracle.address;
    saveConfig(config, configPath);

    // Initialize contract
    const initData = await pancakePriceOracle.contract.methods
      .initialize(
        config.governor,
	config.pancake_router,
	vtcb,
	wbnb,
      )
      .encodeABI();
    console.log('PancakePriceOracle Initialized');

/*    const proxyMoCMedianizer = await AdminUpgradeabilityProxy.new(
      pancakePriceOracle.address,
      config.admin,
      initData
    );
*/
    // Save proxy address to config file
//    config.proxyAddresses.ProxyMoCMedianizer = proxyMoCMedianizer.address;
//    saveConfig(config, configPath);

    //console.log('MoCMedianizer proxy address: ', proxyMoCMedianizer.address);
    console.log('MoCMedianizer implementation address: ', pancakePriceOracle.address);
  } catch (error) {
    callback(error);
  }

  callback();
};
