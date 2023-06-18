require('@nomicfoundation/hardhat-chai-matchers');
require('hardhat-abi-exporter');

const FUJI_PRIVATE_KEY = '';
const DATAHUB_API_KEY = '';

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  abiExporter: {
    path: './abi/',
    clear: true,
  },
  networks: {
    fuji: {
      url: `https://avalanche-fuji.infura.io/v3/${DATAHUB_API_KEY}`,
      accounts: [`0x${FUJI_PRIVATE_KEY}`],
    },
  },
};
