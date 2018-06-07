const GOGBoard = artifacts.require("./GOGBoard.sol");
const AssertJump = require("./assert_jump.js");

contract('GOGBoard', async (accounts) => {

  it("should contract deployed correctly", async () => {
    const _contract = await GOGBoard.deployed();
    // supportsGOGBoard
    const _contractToken = await _contract.supportsGOGBoard.call();
    assert.equal('GOGBOARD', _contractToken);
  }

});
