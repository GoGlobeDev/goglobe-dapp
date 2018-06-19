pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGT.sol";

contract Exchange is GOGBoardAccessor {

    using SafeMath for uint256;

    bool exchangeFunctionPause = false;
    uint256 rate;
    // 0 -10000 integer for gogT
    uint256 fee;
    //the minimum wei you could transfer
    uint256 minimumWei;
    //just for service charge
    address beneficiary;
    //the one who has the gogT
    address payee;
    GOGT gogT;

    modifier whenFuntionNotPaused {
      require(!exchangeFunctionPause);
      _;
    }

    event UpdateRate(address indexed _operator, uint _rate);
    event UpdateFee(address indexed _operator, uint _fee);
    event UpdateBeneficiary(address indexed _operator, address _beneficiary);
    event UpdatePayee(address indexed _operator, address _payee);
    event UpdateGOGTAddress(address indexed _operator, address _gogTAddress);
    event UpdateMinimumWei(address indexed _operator, uint _minimumWei);
    event BuyGOGT(address indexed _dealer, uint256 _ethValue, uint256 _fee, uint256 _gogTValue);
    event SellGOGT(address indexed _dealer, uint256 _ethValue, uint256 _fee, uint256 _gogTValue);
    event WithDraw(address indexed _dealer, uint256 _value);

    constructor(uint256 _rate, uint256 _fee) public {
      rate = _rate;
      fee = _fee;
    }

    function checkBalance() public view onlyBoardMember returns(uint){
      return address(this).balance;
    }

    function updateRate(uint _rate) public whenNotPaused onlyAdmin {
      rate = _rate;
      emit UpdateRate(msg.sender, _rate);
    }

    function updateFee(uint _fee) public whenNotPaused onlyAdmin {
      fee = _fee;
      emit UpdateFee(msg.sender, _fee);
    }

    function updateBeneficiary(address _beneficiary) public whenNotPaused onlyAdmin{
      require(address(0) != _beneficiary);
      beneficiary = _beneficiary;
      emit UpdateBeneficiary(msg.sender, _beneficiary);
    }

    function updatePayee(address _payee) public whenNotPaused onlyAdmin {
      require(address(0) != _payee);
      payee = _payee;
      emit UpdatePayee(msg.sender, _payee);
    }

    function updateGOGTAddress(address gogTAddress) public whenNotPaused onlyAdmin {
      require(address(0) != gogTAddress);
      gogT = GOGT(gogTAddress);
      emit UpdateGOGTAddress(msg.sender, gogTAddress);
    }

    function updateMinimumWei(uint256 _minimumWei) public whenNotPaused onlyAdmin {
      require(_minimumWei > 0);
      minimumWei = _minimumWei;
      emit UpdateMinimumWei(msg.sender, _minimumWei);
    }

    function buyGOGT() public payable whenNotPaused {
      //msg.value trans to contract
      /*this.transfer(msg.value);*/
      require(msg.value >= minimumWei);
      uint total = msg.value.mul(rate);
      uint transFee = total.mul(fee).div(10000);
      uint gogTValue = total.sub(transFee);
      gogT.burn(payee, total);
      gogT.mint(beneficiary, transFee);
      gogT.mint(msg.sender, gogTValue);
      emit BuyGOGT(msg.sender, msg.value, transFee, gogTValue);
    }

    function sellGOGT(uint gogValue) public payable whenNotPaused whenFuntionNotPaused {
      uint transFee = fee.mul(gogValue).div(10000);
      uint total = gogValue.sub(transFee).div(rate); //eth
      require(total >= minimumWei);
      require(address(this).balance >= total);
      gogT.burn(msg.sender, gogValue);
      gogT.mint(beneficiary, transFee);
      gogT.mint(payee, gogValue.sub(transFee));
      msg.sender.transfer(total);
      emit SellGOGT(msg.sender, total, transFee, gogValue);
    }

    /**
    *  admin withDraw the eth
    */
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
