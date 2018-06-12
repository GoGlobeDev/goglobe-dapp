var gogT = artifacts.require("./GOGT.sol");

module.exports = function (deployer) {
  deployer.deploy(gogT,"GOGT", "GOGT Token",6, 10000000000000000);
};
