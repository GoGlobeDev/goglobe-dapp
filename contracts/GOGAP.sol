pragma solidity ^0.4.23;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGBoardAccessor.sol";

contract GOGA is GOGBoardAccessor {

    using SafeMath for uint256;

    mapping(uint => uint[]) aToP;
    mapping(uint => uint) pToA;
    GOGA gogA;

    function createPFromA() public {

    }

    function mergePToA() public {

    }




}
