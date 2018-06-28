const GOGA = artifacts.require("./GOGA.sol");
const GOGAP = artifacts.require("./GOGAP.sol");
const AssertJump = require("./assert_jump.js");

contract('GOGAP', async (accounts) => {

  it("should contract deployed correctly", async () => {
    const _contractGOGA = await GOGA.deployed();
    const _contractGOGAP = await GOGAP.deployed();
    const _result = await _contractGOGA.createAsset(1, "asset No1","china","beijing","location xxx","baidu");
    // const _event = _result.logs[1].event;
    // assert.equal("CreateAsset",_event);
    // const _owner = await _contractGOGA.ownerOf.call(1);
    // assert.equal(true, _owner == accounts[0]);
  });

  // it("should contract createPFromA correctly", async () => {
  //   const _contractGOGA = await GOGA.deployed();
  //   const _contractGOGAP = await GOGAP.deployed();
  //   const _createP = await _contractGOGAP.createPFromA(1,10);
  //   const _createPEvent = _createP.logs[10].event;
  //   assert.equal("CreatePFromA",_createPEvent);
  //   const _pOfA = await _contractGOGAP.getPFromA.call(1);
  //   assert(_pOfA.length,10);
  // });

  // it("should contract mergePToA correctly", async () => {
  //   const _contractGOGA = await GOGA.deployed();
  //   const _contractGOGAP = await GOGAP.deployed();
  //   const _mergeP = await _contractGOGAP.mergePToA([1,2,3,4,5,6,7,8,9,10]);
  //   // const _mergePEvent = _mergeP.logs[10].event;
  //   // assert.equal("CreatePFromA",_createPEvent);
  //   const _pOfA = await _contractGOGAP.getPFromA.call(1);
  //   assert(_pOfA.length,0);
  // });
});
