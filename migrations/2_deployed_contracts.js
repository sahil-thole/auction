const Auction = artifacts.require("Auction");

module.exports = function (deployer , accounts ){
	const acc = "0x16ef9b047914377069a35A9FC858382901C1721b"
	deployer.deploy(Auction , acc);
};