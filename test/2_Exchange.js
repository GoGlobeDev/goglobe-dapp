// const Exchange = artifacts.require("./Exchange.sol");
// const GOGT = artifacts.require("./GOGT.sol");
// const AssertJump = require("./assert_jump.js");
//
// contract('Exchange', async (accounts) => {
//
//   it("should contract deployed correctly", async () => {
//     const _contract = await Exchange.deployed();
//     _contract.updateBeneficiary(accounts[1]);
//     _contract.updatePayee(accounts[0]);
//   });
//
//   it("should contract buy GOGT correctly", async () => {
//     const _contract = await Exchange.deployed();
//     const _gogTContract = await GOGT.deployed();
//     const _gogTValue = await _gogTContract.balanceOf.call(accounts[2]);
//     assert.equal(0,_gogTValue);
//     const _result = await _contract.buyGOGT({from:accounts[2], value: web3.toWei(1, "ether")});
//     const _event = _result.logs[0].event;
//     assert.equal("BuyGOGT",_event);
//     const _initialContractBalance = await web3.eth.getBalance(_contract.address);
//     assert.equal(1,web3.fromWei(_initialContractBalance,"ether").toString());
//     const _gogTValue1 = await _gogTContract.balanceOf.call(accounts[2]);
//     assert.equal(_gogTValue1 > 0, true);
//   });
//
//   it("should contract sell GOGT correctly", async () => {
//     const _contract = await Exchange.deployed();
//     const _gogTContract = await GOGT.deployed();
//     const _gogTValue = await _gogTContract.balanceOf.call(accounts[2]);
//     assert.equal(_gogTValue > 0, true);
//     const _result = await _contract.sellGOGT(_gogTValue, {from:accounts[2]});
//     const _event = _result.logs[0].event;
//     assert.equal("SellGOGT",_event);
//     const _initialContractBalance = await web3.eth.getBalance(_contract.address);
//     assert.equal(1 > web3.fromWei(_initialContractBalance,"ether").toString(),true);
//     const _gogTValue1 = await _gogTContract.balanceOf.call(accounts[2]);
//     assert.equal(_gogTValue1,0);
//   });
// });
