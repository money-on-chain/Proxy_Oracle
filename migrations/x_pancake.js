/* eslint-disable no-console */
const AdminUpgradeabilityProxy = artifacts.require('AdminUpgradeabilityProxy');
const PancakePriceOracle = artifacts.require('./PancakePriceOracle.sol');
const IPancakeFactory = artifacts.require('./IPancakeFactory.sol');
const IPancakePair = artifacts.require('./IPancakePair.sol');

const {getConfig, getNetwork, saveConfig} = require('./helper');

const vtcb = '0x76eDbF5ec4825833479E44A26F7A4D1285295eC7';
const wbnb = '0xae13d989daC2f0dEbFf460aC112a837C89BAa7cd';


module.exports = async callback => {
    try {
        const network = getNetwork(process.argv);
        const configPath = `${__dirname}/configs/${network}.json`;
        const config = getConfig(network, configPath);

        //const pf = await IPancakeFactory.at(config.pancake_factory);
        // Deploy new PancakePriceOracle implementation
        const pancakePriceOracle = await PancakePriceOracle.new();

        // Save implementation address to config file
        config.implementationAddresses = config.implementationAddresses || {};
        config.implementationAddresses.pancakePriceOracle = pancakePriceOracle.address;
        saveConfig(config, configPath);

	// this one or the following..
        //await pancakePriceOracle.initialize(config.governor, config.pancake_router, vtcb,wbnb);
        // Initialize contract
        const initData = await pancakePriceOracle.contract.methods.initialize(
                config.governor,
                config.pancake_router,
                vtcb,
                wbnb).encodeABI();
        console.log('PancakePriceOracle Initialize..');
        
        const proxy = await AdminUpgradeabilityProxy.new(
            pancakePriceOracle.address,
            config.admin,
            initData);
        
        // Save proxy address to config file
        config.proxyAddresses = config.proxyAddresses || {};
        config.proxyAddresses.pancakePriceOracle= proxy.address;
        saveConfig(config, configPath);
	    
        console.log('PancakePriceOracle proxy address: ', proxy.address);
        console.log('PancakePriceOracle implementation address: ',
                    pancakePriceOracle.address);
    } catch (error) {
        callback(error);
    }

    callback();
};
