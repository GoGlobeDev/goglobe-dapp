var gogA = artifacts.require("./GOGA.sol");
var GOGBoard = artifacts.require("./GOGBoard.sol");
var GOGProject = artifacts.require("./GOGProject.sol");

module.exports = async function (deployer) {
  let gogAAddress;
  let gogBoard;
  let gogProject;

  await deployer.deploy(gogA,"gogA","gogA");
  gogAAddress = await gogA.deployed();
  gogBoard = await GOGBoard.deployed();
  gogProject = await GOGProject.deployed();
  await gogAAddress.setGOGBoard(gogBoard.address);
  await gogAAddress.setGOGProject(gogProject.address);
};
