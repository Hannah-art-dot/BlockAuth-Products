/**
 * BlockAuth Products
 * Fake Product Identification using Blockchain
 * Project by: Hannah
 * This configuration file is customized for local Ganache development.
 *
 * More info: trufflesuite.com/docs/advanced/configuration
 */

const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",     // Localhost
      port: 7545,            // Ganache port
      network_id: "*",       // Any network
    }
  },

  // Set default mocha options here
  mocha: {
    // timeout: 100000
  },

  // Configure Solidity compiler
  compilers: {
    solc: {
      version: "0.8.12",    // BlockAuthProducts contract
    }
  },

  // Truffle DB disabled
  // db: { enabled: false }
};

