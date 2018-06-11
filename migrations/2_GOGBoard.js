var GOGBoard = artifacts.require("./GOGBoard.sol");

module.exports = function (deployer) {
  deployer.deploy(GOGBoard,3,1,1,1,1,5,"test");
};
