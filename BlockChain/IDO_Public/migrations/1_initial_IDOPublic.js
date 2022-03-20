const IDOPublic = artifacts.require("IDOPublic");

module.exports = function (deployer) {
  deployer.deploy(IDOPublic, "0xf00A36E6C1c7949dd68904E03A459e2c87f3a842");
};
