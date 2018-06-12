var GOGBoard = artifacts.require("./GOGBoard.sol");

module.exports = function (deployer) {
  deployer.deploy(GOGBoard,1,1,1,1,1,1,"test");
};
