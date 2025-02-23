const Auction = artifacts.require("./Auction.sol");

module.exports = function (deployer) {
    deployer.deploy(Auction, "Pablo Picasso \"Dove\"", web3.utils.toWei("0.1", "ether"), 3600);
};