var Exchange = artifacts.require("./Exchange.sol");
var gogT = artifacts.require("./GOGT.sol");
var GOGBoard = artifacts.require("./GOGBoard.sol");

module.exports = async function (deployer) {
  let exchange;
  let gogTAddress;
  let gogBoard;

  await deployer.deploy(Exchange,1,100);
  // await deployer.deploy(gogT,"GOGT", "GOGT Token",6, 10000000000000000);
  gogBoard = await GOGBoard.deployed();
  exchange = await Exchange.deployed();
  gogTAddress = await gogT.deployed();
  await gogTAddress.setGOGBoard(gogBoard.address);
  await exchange.setGOGBoard(gogBoard.address);
  await exchange.updateGOGTAddress(gogTAddress.address);
  await gogBoard.addSystemAddress(exchange.address);
};
