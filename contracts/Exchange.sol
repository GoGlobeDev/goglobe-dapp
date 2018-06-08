pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGT.sol";

contract Exchange is GOGBoardAccessor {

    using SafeMath for uint256;

    bool exchangeFunctionPause = false;
    uint rate;
    uint fee;              // 0 -10000 integer for gogT
    address beneficiary;  //just for service charge
    address payee;        //
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

    function buyGOGT() public payable whenNotPaused {
      //msg.value trans to contract
      /*this.transfer(msg.value);*/
      uint total = msg.value * rate;
      uint transFee = fee * total / 10000;
      uint gogT = total - transFee;


    }

    function sellGOGT(uint gogValue) public payable whenNotPaused whenFuntionNotPaused {
      uint transFee = fee * gogValue / 10000;
      uint total = (gogValue - transFee) / rate; //eth

    }

    function functionPause() public whenNotPaused onlyAdmin{
      exchangeFunctionPause = true;
    }

    function unFunctionPause() public whenNotPaused onlyAdmin{
      exchangeFunctionPause = false;
    }
}
