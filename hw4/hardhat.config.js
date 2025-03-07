require("@nomicfoundation/hardhat-toolbox");
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",

  networks: {
    ganache: {
      url: "http://127.0.0.1:7545",
      accounts: [
        "0xd16ccece9ab0dabd27c98b607fca0f845b46b5c0327ddc5e973faa0ca7a09399",
        "0x7306fa1227d7d6a28664046d4f0af4d9c221dbbad363d0c07ed9b43be23eb335",
        "0x25ee4564d83087ca9fe6f3ddc6bbf7f8822f741c0717d807e1154ca2e9ef536c"
      ], 
    },
    localhost: {
      url:"http://127.0.0.1:7545"
    },
  },
};
