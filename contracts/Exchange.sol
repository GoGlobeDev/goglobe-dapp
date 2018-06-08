pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGT.sol";

contract Exchange is GOGBoardAccessor {

    using SafeMath for uint256;

    bool exchangeFunctionPause = false;
    uint256 rate;
    uint256 fee;              // 0 -10000 integer for gogT
    uint256 minimumEth;      //the minimum eth you could transfer
    address beneficiary;    //just for service charge
    address payee;        //the one who has the gogT
    GOGT gogT;

    modifier whenFuntionNotPaused {
      require(!exchangeFunctionPause);
      _;
    }

    event BuyGOGT(address indexed _dealer, uint256 _ethValue, uint256 _fee, uint256 _gogTValue);
    event SellGOGT(address indexed _dealer, uint256 _ethValue, uint256 _fee, uint256 _gogTValue);
    event WithDraw(address indexed _dealer, uint256 _value);

    constructor(uint256 _rate, uint256 _fee) public {
      rate = _rate;
      fee = _fee;
    }

    function updateRate(uint _rate) public whenNotPaused onlyAdmin {
      rate = _rate;
    }

    function updateFee(uint _fee) public whenNotPaused onlyAdmin {
      fee = _fee;
    }

    function updateBeneficiary(address _beneficiary) public whenNotPaused onlyAdmin{
      require(address(0) != _beneficiary);
      beneficiary = _beneficiary;
    }

    function updatePayee(address _payee) public whenNotPaused onlyAdmin {
      require(address(0) != _payee);
      payee = _payee;
    }

    function updateGOGTAddress(address gogTAddress) public whenNotPaused onlyAdmin {
      require(address(0) != gogTAddress);
      gogT = gogTAddress;
    }

    function updateMinimumEth(uint256 _minimumEth) public whenNotPaused onlyAdmin {
      require(_minimumEth > 0);
      minimumEth = _minimumEth;
    }

    function checkBalance() public view onlyBoardMember {
      return address(this).balance;
    }

    function buyGOGT() public payable whenNotPaused {
      //msg.value trans to contract
      /*this.transfer(msg.value);*/
      require(msg.value > minimumEth ether);
      uint total = msg.value.mul(rate);
      uint transFee = total.mul(fee).div(10000);
      uint gogTValue = total - transFee;
      gogT.burn(payee, total);
      gogT.mint(beneficiary, transFee);
      gogT.mint(msg.sender, gogTValue);
      emit BuyGOGT(msg.sender, msg.value, transFee, gogTValue);
    }

    function sellGOGT(uint gogValue) public payable whenNotPaused whenFuntionNotPaused {
      uint transFee = fee.mul(gogValue).div(10000);
      uint total = gogValue.sub(transFee).div(rate); //eth
      require(address(this).balance >= total);
      gogT.burn(msg.sender, gogValue);
      gogT.mint(beneficiary, transFee);
      gogT.mint(payee, gogTValue);
      msg.sender.transfer(total);
      emit SellGOGT(msg.sender, total, transFee, gogValue);
    }

    function withDraw(uint256 value) public payable whenNotPaused onlyAdmin{
      require(value <= address(this).balance);
      msg.sender.transfer(value);
      emit WithDraw(msg.sender, value);
    }

    function functionPause() public whenNotPaused onlyAdmin{
      exchangeFunctionPause = true;
    }

    function unFunctionPause() public whenNotPaused onlyAdmin{
      exchangeFunctionPause = false;
    }
}
