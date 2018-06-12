const Exchange = artifacts.require("./Exchange.sol");
const AssertJump = require("./assert_jump.js");

contract('Exchange', async (accounts) => {

  it("should contract deployed correctly", async () => {
    const _contract = await Exchange.deployed();
  });
});
