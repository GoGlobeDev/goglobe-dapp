// const GOGBoard = artifacts.require("./GOGBoard.sol");
// const AssertJump = require("./assert_jump.js");
//
// contract('GOGBoard', async (accounts) => {
//
//   it("should contract deployed correctly", async () => {
//     const _contract = await GOGBoard.deployed();
//     // supportsGOGBoard
//     const _contractToken = await _contract.supportsGOGBoard.call();
//     var _result = web3.toAscii(_contractToken);
//     _result = _result.replace(/\u0000/g,'');
//     assert.equal('GOGBOARD', _result);
//   });
//
//   it("should contract create propose correctly", async () => {
//     const _contract = await GOGBoard.deployed();
//     const _result = await _contract.createPropose(1, accounts[1],'add member accounts 1');
//     const _event = _result.logs[0].event;
//     assert.equal("ProposeEvent",_event);
//     try {
//       await _contract.createPropose(1, accounts[2], 'from wrong person',{from: accounts[3]});
//       assert.fail("contract create propose wrong");
//     } catch (error) {
//     }
//   });
//
//   it("should contract add vote correctly", async () => {
//     const _contract = await GOGBoard.deployed();
//     await _contract.vote(1,true);
//     try{
//       await _contract.execute(1);
//       assert.fail("contract execute wrong");
//     }catch (error) {
//     }
//     const _resultUser = await _contract.isBoardMember.call(accounts[1]);
//     assert.equal(false,_resultUser);
//     sleep(1000*60);
//     await _contract.execute(1);
//     const _resultUser1 = await _contract.isBoardMember.call(accounts[1]);
//     assert.equal(true,_resultUser1);
//   });
//
//   it("should contract delete vote correctly", async () => {
//     const _contract = await GOGBoard.deployed();
//     const _result = await _contract.createPropose(2, accounts[1],'add member accounts 1');
//     const _resultUser1 = await _contract.isBoardMember.call(accounts[1]);
//     assert.equal(true,_resultUser1);
//     await _contract.vote(2,true);
//     sleep(1000*60);
//     await _contract.execute(2);
//     const _resultUser = await _contract.isBoardMember.call(accounts[1]);
//     assert.equal(false,_resultUser);
//   });
// });
//
// function sleep(numberMillis) {
//   var now = new Date();
//   var exitTime = now.getTime() + numberMillis;
//   while (true) {
//   now = new Date();
//   if (now.getTime() > exitTime)
//   return;
// }
// }
