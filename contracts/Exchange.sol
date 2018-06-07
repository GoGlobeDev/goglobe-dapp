pragma solidity ^0.4.23;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGT.sol";

contract Exchange is GOGBoardAccessor {

    using SafeMath for uint256;

    bool exchangeFunctionPause = false;
    uint rate;
    uint fee;
    address beneficiary;
    GOGT gogT;

    modifier whenFuntionNotPaused {
      require(!exchangeFunctionPause);
      _;
    }

    function changeRate(uint _rate) public whenNotPaused onlyAdmin {
      rate = _rate;
    }

    function changeFee(uint _fee) public whenNotPaused onlyAdmin {
      fee = _fee;
    }

    function changeBeneficiary(address _beneficiary) public whenNotPaused onlyAdmin{
      beneficiary = _beneficiary;
    }

    function buyGOGT(uint gogValue) public payable whenNotPaused {

    }

    function sellGOGT(uint gogValue) public payable whenNotPaused whenFuntionNotPaused {

    }

    function functionPause() public whenNotPaused onlyAdmin{
      exchangeFunctionPause = true;
    }

    function unFunctionPause() public whenNotPaused onlyAdmin{
      exchangeFunctionPause = false;
    }
}
