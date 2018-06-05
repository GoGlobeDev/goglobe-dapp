pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";

contract ERC20 {

    using SafeMath for uint256;

    string name;
    string symbol;
    uint8 property;
    uint256 totalSupply;
    mapping (address -> uint256) balances;
    mapping (address -> mapping (address -> uint256)) internal allowed;

    event Mint(address indexed to, uint256 amount);
    event Burn(address indexed burner, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event MintFinished();

    modifier canMint {

    }
    modifier hasMintPermission {

    }

    function totalSupply() public view returns (uint256) {

    }

    function balanceOf(address _owner) public view returns (uint256) {

    }

    function allowance (address owner, address spender) public view returns (uint256){

    }

    function burn(address _who, uint256 _value) internal {

    }

    function decreaseApproval(address _spender, uint _subtractedValue) internal (bool) {

    }

    function increaseApproval(address _spender, uint _addedValue) internal (bool) {

    }

    function transfer (address _to, uint256 _value) internal (bool) {

    }

    function transferFrom (address _from, address _to, uint256 _value) internal (bool) {

    }

    function approve(address spender, uint256 value) internal (bool) {

    }

    function mint(address _to, uint256 _amount) internal{

    }

    function finishMinting() internal (bool) {

    }

}
