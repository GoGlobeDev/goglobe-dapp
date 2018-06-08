pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGBoardAccessor.sol";

contract GOGA is GOGBoardAccessor {

    using SafeMath for uint256;

    mapping(uint => uint[]) aToP;
    mapping(uint => uint) pToA;
    GOGA gogA;

    function updateGogA(address gogAAddress) public whenNotPaused onlyAdmin{
      require(address(0) != gogAAddress);
      gogA = GOGA(gogAAddress);
    }

    function createPFromA() public whenNotPaused{

    }

    function mergePToA() public whenNotPaused {

    }




}
