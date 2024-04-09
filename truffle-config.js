const HDWalletProvider = require("@truffle/hdwallet-provider");

const mnemonic = process.env.MNEMONIC || "lab direct float merit wall huge wheat loyal maple cup battle butter";

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // for more about customizing your Truffle configuration!
  compilers: {
    solc: {
      version: "0.5.8",
      evmVersion: "byzantium",
      settings: {
        optimizer: {
          enabled: true,
          runs: 100,
        },
      },
    },
  },
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*",
      gas: 6721975,
      gasPrice: 20000000000,
    },
    // Local node with Docker
    // https://github.com/rsksmart/artifacts/tree/master/Dockerfiles/RSK-Node
    rskRegtestLocal: {
      host: "localhost",
      port: 4444,
      network_id: "*",
    },
    mocTestnet: {
      host: "https://public-node.testnet.rsk.co",
      provider: () => new HDWalletProvider(mnemonic, "https://public-node.testnet.rsk.co"),
      network_id: "*",
      gas: 6800000,
      gasPrice: 68000000,
      skipDryRun: true,
      confirmations: 1,
    },
    mocMainnet: {
      host: "https://public-node.rsk.co",
      provider: () => new HDWalletProvider(mnemonic, "https://public-node.rsk.co"),
      network_id: "*",
      gas: 6800000,
      gasPrice: 60000000,
      skipDryRun: true,
      confirmations: 1,
    },
    ethTestnet: {
      host: "https://public-node.testnet.rsk.co",
      provider: () => new HDWalletProvider(mnemonic, "https://public-node.testnet.rsk.co"),
      network_id: "*",
      gas: 6800000,
      gasPrice: 68000000,
      skipDryRun: true,
      confirmations: 1,
    },
    ethMainnet: {
      host: "https://public-node.rsk.co",
      provider: () => new HDWalletProvider(mnemonic, "https://public-node.rsk.co"),
      network_id: "*",
      gas: 3800000,
      gasPrice: 60000000,
      skipDryRun: true,
      confirmations: 1,
    },
    tetherTestnet: {
      host: "https://public-node.testnet.rsk.co",
      provider: () => new HDWalletProvider(mnemonic, "https://public-node.testnet.rsk.co"),
      network_id: "*",
      gas: 6800000,
      gasPrice: 68000000,
      skipDryRun: true,
      confirmations: 1,
    },
    tetherMainnet: {
      host: "https://public-node.rsk.co",
      provider: () => new HDWalletProvider(mnemonic, "https://public-node.rsk.co"),
      network_id: "*",
      gas: 3800000,
      gasPrice: 60000000,
      skipDryRun: true,
      confirmations: 1,
    },
    dummyTestnet: {
      host: "https://public-node.testnet.rsk.co",
      provider: () => new HDWalletProvider(mnemonic, "https://public-node.testnet.rsk.co"),
      network_id: "*",
      gas: 6800000,
      gasPrice: 68000000,
      skipDryRun: true,
      confirmations: 1,
    },
    dummyMainnet: {
      host: "https://public-node.rsk.co",
      provider: () => new HDWalletProvider(mnemonic, "https://public-node.rsk.co"),
      network_id: "*",
      gas: 3800000,
      gasPrice: 60000000,
      skipDryRun: true,
      confirmations: 1,
    },
    rifTestnet: {
      host: "https://public-node.testnet.rsk.co",
      provider: () => new HDWalletProvider(mnemonic, "https://public-node.testnet.rsk.co"),
      network_id: "*",
      gas: 6800000,
      gasPrice: 68000000,
      skipDryRun: true,
      confirmations: 1,
    },
    rifMainnet: {
      host: "https://public-node.rsk.co",
      provider: () => new HDWalletProvider(mnemonic, "https://public-node.rsk.co"),
      network_id: "*",
      gas: 3800000,
      gasPrice: 60000000,
      skipDryRun: true,
      confirmations: 1,
    },
    bscTestnet: {
      host: "https://data-seed-prebsc-1-s1.binance.org:8545/",
      provider: () => new HDWalletProvider(process.env.PRIVATE_KEY, "https://data-seed-prebsc-1-s1.binance.org:8545/"),
      network_id: "97",
      gas: 7000000,
      gasPrice: 10000000000,
      skipDryRun: true,
      confirmations: 1,
    },
    dummyPolygonMumbai: {
      host: 'https://rpc-mumbai.maticvigil.com/',
      provider: new HDWalletProvider(mnemonic, 'https://rpc-mumbai.maticvigil.com/'),
      network_id: 80001,
      gas: 2000000,
      //gas: 6000000,
      gasPrice: 33000000000,
      skipDryRun: true,
      confirmations: 2,
      disableConfirmationListener: true,
      networkCheckTimeout: 100000,
      timeoutBlocks: 200,
    }
  },
};
