var gogT = artifacts.require("./GOGT.sol");

module.exports = function (deployer) {
  deployer.deploy(gogT,"GOGT", "GOGT Token",6, 100000000000000000000000000000000000);
};
