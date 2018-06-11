var GOGT = artifacts.require("./GOGT.sol");

module.exports = function (deployer) {
  deployer.deploy(GOGT,"GOGT", "GOGT Token",6, 10000000000000000);
};
