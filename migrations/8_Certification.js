// var gogA = artifacts.require("./GOGA.sol");
// var GOGBoard = artifacts.require("./GOGBoard.sol");
// var Certification = artifacts.require("./Certification.sol");
// var GOGAuction = artifacts.require("./GOGAuction.sol");
// var gogT = artifacts.require("./GOGT.sol");
// var Lawyer = artifacts.require("./Lawyer.sol");
// var Operator = artifacts.require("./Operator.sol");
//
// module.exports = async function (deployer) {
//   let gogAAddress;
//   let gogBoard;
//   let certification;
//   let gogAuction;
//   let gogTAddress;
//   let lawyer;
//   let operator;
//
//   await deployer.deploy(certification);
//   gogAAddress = await gogA.deployed();
//   gogBoard = await GOGBoard.deployed();
//   certification = await Certification.deployed();
//   gogAuction = await GOGAuction.deployed();
//   gogTAddress = await gogT.deployed();
//   lawyer = await Lawyer.deployed();
//   operator = await Operator.deployed();
//   await certification.setGOGBoard(gogBoard.address);
//   await certification.updateGogA(gogAAddress.address);
//   await certification.updateGogAuction(gogAuction.address);
//   await certification.updateGOGT(gogTAddress.address);
//   await certification.updateLawyer(lawyer.address);
//   await certification.updateOperator(operator.address);
// };

var certification = artifacts.require("./Certification.sol");

module.exports = function (deployer) {
  deployer.deploy(certification);
};
