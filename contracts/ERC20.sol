pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";

contract ERC20 {

    using SafeMath for uint256;

    string name;
    string symbol;
    uint256 totalSupply;
    bool couldMint = false;
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) internal allowed;

    event Mint(address indexed to, uint256 amount);
    event Burn(address indexed burner, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

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

    function _approve(address spender, uint256 value) internal returns (bool) {
      require(balances[msg.sender] >= value);
      allowed[msg.sender][spender] = value;
      Approval(msg.sender, spender, value);
      return true;
    }

    function _decreaseApproval(address spender, uint subtractedValue) internal returns (bool) {
      if(allowed[msg.sender][spender] <= subtractedValue) {
        delete allowed[msg.sender];
      } else {
        allowed[msg.sender][spender] = allowed[msg.sender][spender].sub(subtractedValue);
      }
      Approval(msg.sender, spender, allowed[msg.sender][spender]);
    }

    function _increaseApproval(address spender, uint addedValue) internal returns (bool) {
      require(balances[msg.sender].sub(allowed[msg.sender][spender]) >= addedValue);
      allowed[msg.sender][spender] = allowed[msg.sender][spender].add(addedValue);
      Approval(msg.sender, spender, allowed[msg.sender][spender]);
      return true;
    }

    function _transfer(address to, uint256 value) internal returns (bool) {
      require(address(0) != to);
      require(value <= balances[msg.sender]);
      balances[msg.sender] = balances[msg.sender].sub(value);
      balances[to] = balances[to].add(value);
      Transfer(msg.sender, to, value);
      return true;
    }

    function _transferFrom(address from, address to, uint256 value) internal returns (bool) {
      require(address(0) != to);
      require(value <= balances[from]);
      require(value <= allowed[from][msg.sender]);
      balances[from] = balances[from].sub(value);
      balances[to] = balances[to].add(value);
      allowed[from][msg.sender] = allowed[from][msg.sender].sub(value);
      Transfer(from, to, value);
      return true;
    }

    function _mint(address to, uint256 amount) internal {
      require(couldMint);
      totalSupply = totalSupply.add(amount);
      balances[to] = balances[to].add(amount);
      Mint(to, amount);
      Transfer(address(0), to, amount);
      return true;
    }

    function _changeCouldMint(bool _couldMint) internal {
      couldMint = _couldMint;
    }

    function _burn(address who, uint256 value) internal {
      require(value <= balances[who]);
      balances[who] = balances[who].sub(value);
      totalSupply = totalSupply.sub(value);
      Burn(who, value);
      Transfer(who, address(0), value);
    }

}
