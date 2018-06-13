var gogA = artifacts.require("./GOGA.sol");
var GOGBoard = artifacts.require("./GOGBoard.sol");

module.exports = async function (deployer) {
  let gogAAddress;
  let gogBoard;

  await deployer.deploy(gogA,"gogA","gogA");
  gogAAddress = await gogA.deployed();
  gogBoard = await GOGBoard.deployed();
  await gogAAddress.setGOGBoard(gogBoard.address);
};
