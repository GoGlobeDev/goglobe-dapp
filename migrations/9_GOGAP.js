var gogA = artifacts.require("./GOGA.sol");
var gogAP = artifacts.require("./GOGAP.sol");
var GOGBoard = artifacts.require("./GOGBoard.sol");
// var Certification = artifacts.require("./Certification.sol");
// var GOGAuction = artifacts.require("./GOGAuction.sol");

module.exports = async function (deployer) {
  let gogAPAddress;
  let gogAAddress;
  let gogBoard;
  // let certification;
  // let gogAuction;

  await deployer.deploy(gogAP,"gogAP","gogAP");
  gogAPAddress = await gogAP.deployed();
  gogAAddress = await gogA.deployed();
  gogBoard = await GOGBoard.deployed();
  // certification = await Certification.deployed();
  // gogAuction = await GOGAuction.deployed();
  await gogAPAddress.setGOGBoard(gogBoard.address);
  await gogAPAddress.updateGogA(gogAAddress.address);
  await gogBoard.addSystemAddress(gogAPAddress.address);
  // await gogAPAddress.updateCertification(certification.address);
  // await gogAPAddress.updateGogAuction(gogAuction.address);
};

// var gogAP = artifacts.require("./GOGAP.sol");
//
// module.exports = function (deployer) {
//   deployer.deploy(gogAP,"gogAP","gogAP");
// };
