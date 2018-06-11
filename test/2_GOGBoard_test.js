const GOGBoard = artifacts.require("./GOGBoard.sol");
const AssertJump = require("./assert_jump.js");

contract('GOGBoard', async (accounts) => {

  it("should contract deployed correctly", async () => {
    const _contract = await GOGBoard.deployed();
    // supportsGOGBoard
    const _contractToken = await _contract.supportsGOGBoard.call();
    var _result = web3.toAscii(_contractToken);
    _result = _result.replace(/\u0000/g,'');
    assert.equal('GOGBOARD', _result);
  });

  it("should contract create propose correctly", async () => {
    const _contract = await GOGBoard.deployed();
    const _result = await _contract.createPropose(1, accounts[1],'add member accounts 1');
    const _event = _result.logs[0].event;
    assert.equal("ProposeEvent",_event);
  });

  it("should contract add vote correctly", async () => {

  });
});
