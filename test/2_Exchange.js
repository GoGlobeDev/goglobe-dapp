const Exchange = artifacts.require("./Exchange.sol");
const AssertJump = require("./assert_jump.js");

contract('Exchange', async (accounts) => {

  it("should contract deployed correctly", async () => {
    const _contract = await Exchange.deployed();
    _contract.updateBeneficiary(accounts[1]);
    _contract.updatePayee(accounts[0]);
  });

  it("should contract buy GOGT correctly", async () => {
    const _contract = await Exchange.deployed();
    const _address = accounts[2];
    let before = await web3.eth.getBalance(accounts[2]);
    console.log(web3.fromWei(before,"ether").toString());
    const result = await _contract.buyGOGT({from:accounts[2], value: web3.toWei(1, "ether")});
    let initialContractBalance = await web3.eth.getBalance(_contract.address);
    console.log(web3.fromWei(initialContractBalance,"ether").toString());
    console.log(web3.fromWei(initialContractBalance,"ether").toString());
  });
});
