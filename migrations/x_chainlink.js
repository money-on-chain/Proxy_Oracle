/* eslint-disable no-console */
const AdminUpgradeabilityProxy = artifacts.require("AdminUpgradeabilityProxy");
const ChainlinkPriceOracle = artifacts.require("./ChainlinkPriceOracle.sol");

const { getConfig, getNetwork, saveConfig } = require("./helper");

const bnbUsd = "0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526"; // BSC Testnet Chainlink BNB/USD dataFeed
const aaveUsd = "0x298619601ebCd58d0b526963Deb2365B485Edc74"; // BSC Testnet Chainlink AAVE / USD dataFeed

const VALID_PRICE_PERIOD = 600;

async function deploy(config, dataFeed, prev) {
  // Deploy new ChainlinkPriceOracle implementation
  let chainlinkPriceOracle;
  if (!prev || !prev.impl) {
    console.log("Deploying implementation..");
    chainlinkPriceOracle = await ChainlinkPriceOracle.new();
  } else {
    chainlinkPriceOracle = {
      address: prev.impl.address,
      contract: prev.impl.contract,
    };
  }

  // Initialize contract
  const initData = await chainlinkPriceOracle.contract.methods.initialize(config.governor, bnbUsd, VALID_PRICE_PERIOD).encodeABI();
  console.log("ChainlinkPriceOracle Initialize while deploying proxy..");

  const proxy = await AdminUpgradeabilityProxy.new(chainlinkPriceOracle.address, config.admin, initData);

  const ret = { impl: chainlinkPriceOracle, proxy };
  console.log("ChainlinkPriceOracle proxy address: ", ret.proxy.address);
  console.log("ChainlinkPriceOracle implementation address: ", ret.impl.address);
  return ret;
}

module.exports = async callback => {
  try {
    const network = getNetwork(process.argv);
    const configPath = `${__dirname}/configs/${network}.json`;
    const config = getConfig(network, configPath);

    //[vtcb, wbnb]
    //[vtcb, wbnb, usdt]

    bnbUsd_chainlink = await deploy(config, bnbUsd);
    aaveUsd_chainlink = await deploy(config, aaveUsd, bnbUsd_chainlink);

    config.implementationAddresses = config.implementationAddresses || {};
    config.proxyAddresses = config.proxyAddresses || {};

    config.implementationAddresses.bnbUsd_chainlink = bnbUsd_chainlink.impl.address;
    config.proxyAddresses.bnbUsd_chainlink = bnbUsd_chainlink.proxy.address;

    config.implementationAddresses.aaveUsd_chainlink = aaveUsd_chainlink.impl.address;
    config.proxyAddresses.aaveUsd_chainlink = aaveUsd_chainlink.proxy.address;

    saveConfig(config, configPath);
  } catch (error) {
    callback(error);
  }

  callback();
};
