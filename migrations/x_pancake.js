/* eslint-disable no-console */
const AdminUpgradeabilityProxy = artifacts.require('AdminUpgradeabilityProxy');
const PancakePriceOracle = artifacts.require('./PancakePriceOracle.sol');
const IPancakeFactory = artifacts.require('./IPancakeFactory.sol');
const IPancakePair = artifacts.require('./IPancakePair.sol');

const {getConfig, getNetwork, saveConfig} = require('./helper');

const vtcb = '0x76eDbF5ec4825833479E44A26F7A4D1285295eC7';
const wbnb = '0xae13d989daC2f0dEbFf460aC112a837C89BAa7cd';

const usdt = '0x7ef95a0FEE0Dd31b22626fA2e10Ee6A223F8a684';
const btcb = '0x6ce8dA28E2f864420840cF74474eFf5fD80E65B8';

const moc = '0x1C382A7C0481ff75C69EC1757Eff297C9255494B';


async function deploy(config, path, prev) {
    // Deploy new PancakePriceOracle implementation
    let pancakePriceOracle;
    if (!prev || !prev.impl) {
        console.log("Deploying implementation..");
        pancakePriceOracle = await PancakePriceOracle.new();
    } else {
	pancakePriceOracle = { 
		address: prev.impl.address,
		contract: prev.impl.contract
	}; 
    }

    // this one or the following..
    //await pancakePriceOracle.initialize(config.governor, config.pancake_router, vtcb,wbnb);
    // Initialize contract
    const initData = await pancakePriceOracle.contract.methods.initialize(
            config.governor,
            config.pancake_router,
	    path
	).encodeABI();
    console.log('PancakePriceOracle Initialize while deploying proxy..');
        
    const proxy = await AdminUpgradeabilityProxy.new(
        pancakePriceOracle.address,
        config.admin,
        initData);

    const ret ={ impl: pancakePriceOracle, proxy };
    console.log('PancakePriceOracle proxy address: ', ret.proxy.address);
    console.log('PancakePriceOracle implementation address: ', ret.impl.address);
    return ret;
}


module.exports = async callback => {
    try {
        const network = getNetwork(process.argv);
        const configPath = `${__dirname}/configs/${network}.json`;
        const config = getConfig(network, configPath);

        //[vtcb, wbnb]
        //[vtcb, wbnb, usdt]
        
	dep_moc_usdt = await deploy(config, [moc, wbnb, usdt]);
	dep_vtc_usdt = await deploy(config, [vtcb, wbnb, usdt], dep_moc_usdt);
	

        config.implementationAddresses = config.implementationAddresses || {};
        config.proxyAddresses = config.proxyAddresses || {};

        config.implementationAddresses.moc_usdt_pancake_oracle = dep_moc_usdt.impl.address;
        config.proxyAddresses.moc_usdt_pancake_oracle = dep_moc_usdt.proxy.address;

        config.implementationAddresses.vtc_usdt_pancake_oracle = dep_vtc_usdt.impl.address;
        config.proxyAddresses.vtc_usdt_pancake_oracle = dep_vtc_usdt.proxy.address;

        saveConfig(config, configPath);
    } catch (error) {
        callback(error);
    }

    callback();
};
