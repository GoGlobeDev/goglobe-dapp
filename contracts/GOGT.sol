pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./ERC20.sol";
import "./GOGBoardAccessor.sol";

contract GOGT is GOGBoardAccessor,ERC20 {

    using SafeMath for uint256;

    constructor(string _name, string _symbol, uint8 _decimals, uint256 _totalSupply) ERC20(_name, _symbol, _decimals, _totalSupply) public {
    }

    function approve(address spender, uint256 value) public whenNotPaused returns (bool) {
      return _approve(spender,value);
    }

    function increaseApproval(address spender, uint addedValue) public whenNotPaused returns (bool){
      return _increaseApproval(spender, addedValue);
    }

    function decreaseApproval(address spender, uint subtractedValue) public whenNotPaused returns (bool) {
      return _decreaseApproval(spender, subtractedValue);
    }

    function transfer(address to, uint256 value) public whenNotPaused returns (bool){
      return _transfer(to, value);
    }

    function transferFrom(address from, address to, uint256 value) public whenNotPaused returns (bool){
      return _transferFrom(from, to, value);
    }

    function changeCouldMint(bool couldMint) public whenNotPaused onlyAdmin {
      _changeCouldMint(couldMint);
    }

    function mint(address to, uint256 amount) public whenNotPaused onlyAdmin returns (bool) {
      return _mint(to, amount);
    }

    function burn(address who, uint256 value) public whenNotPaused onlyAdmin returns (bool) {
      return _burn(who, value);
    }
}
