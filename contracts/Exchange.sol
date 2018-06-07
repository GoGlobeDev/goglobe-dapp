pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";

contract Exchange is GOGBoardAccessor {

    using SafeMath for uint256;

    bool pause;
    uint rate;
    uint fee;
    address beneficiary;
    GOGT gogT;

    modifier whenFuntionNotPaused {
      require(!pause);
      _;
    }

    function changeRate(uint rate) {

    }

    function changeFee(uint fee) {

    }

    function buyGOGT(uint value) {

    }

    function sellGOGT(uint value) {

    }

    function changeBeneficiary(address _beneficiary) public whenNotPaused onlyAdmin{
      beneficiary = _beneficiary;
    }

    function functionPause() {

    }

    function unFunctionPause() {

    }
}
