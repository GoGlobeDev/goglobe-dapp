pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";

contract ERC20 {

    using SafeMath for uint256;

    string name;
    string symbol;
    uint8 property;
    uint256 totalSupply;
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) internal allowed;

    event Mint(address indexed to, uint256 amount);
    event Burn(address indexed burner, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event MintFinished();
    event Approval(address indexed owner, address indexed spender, uint256 value);

    modifier canMint {

    }
    modifier hasMintPermission {
    }

    function ERC20(string _name, string _symbol, uint8 _decimals, uint256 _totalSupply) public {
      name = _name;
      symbol = _symbol;
      decimals = _decimals;
      totalSupply = _totalSupply;
      balances[msg.sender] = totalSupply;
    }

    function totalSupply() public view returns (uint256) {
      return totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256) {
      return balances[_owner];
    }

    function allowance(address owner, address spender) public view returns (uint256){
      return allowed[owner][spender];
    }

    function approve(address spender, uint256 value) internal (bool) {
      require(balances[msg.sender] >= value);
      allowed[msg.sender][spender] = value;
      Approval(msg.sender, spender, value);
      return true;
    }

    function decreaseApproval(address _spender, uint _subtractedValue) internal (bool) {
      if(allowed[msg.sender][spender] <= _subtractedValue) {
        delete allowed[msg.sender];
      } else {
        allowed[msg.sender][spender] = allowed[msg.sender][spender].sub(_subtractedValue);
      }
      Approval(msg.sender, spender, allowed[msg.sender][spender]);
    }

    function increaseApproval(address _spender, uint _addedValue) internal (bool) {
      require(balances[msg.sender].sub(allowed[msg.sender][spender]) >= _addedValue);
      allowed[msg.sender][spender] = allowed[msg.sender][spender].add(_addedValue);
      Approval(msg.sender, spender, allowed[msg.sender][spender]);
      return true;
    }

    function transfer (address _to, uint256 _value) internal (bool) {
      require(address(0) != _to);

    }

    function transferFrom (address _from, address _to, uint256 _value) internal (bool) {

    }

    function mint(address _to, uint256 _amount) internal{

    }

    function finishMinting() internal (bool) {

    }

    function burn(address _who, uint256 _value) internal {

    }

}
