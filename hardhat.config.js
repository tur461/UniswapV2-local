require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  networks: {
    local: {
      url: 'http://127.0.0.1:1337'
    }
  },
  solidity: "0.8.19",
};
