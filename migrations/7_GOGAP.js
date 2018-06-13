var gogA = artifacts.require("./GOGA.sol");
var gogAP = artifacts.require("./GOGAP.sol");
var GOGBoard = artifacts.require("./GOGBoard.sol");

module.exports = async function (deployer) {
  let gogAPAddress;
  let gogAAddress;
  let gogBoard;

  await deployer.deploy(gogAP,"gogAP","gogAP");
  gogAPAddress = await gogAP.deployed();
  gogAAddress = await gogA.deployed();
  gogBoard = await GOGBoard.deployed();
  await gogAPAddress.setGOGBoard(gogBoard.address);
  await gogAPAddress.updateGogA(gogAAddress.address);
  await gogBoard.addSystemAddress(gogAPAddress.address);
};
