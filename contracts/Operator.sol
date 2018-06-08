pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGBoardAccessor.sol";

contract Operator is GOGBoardAccessor {

    using SafeMath for uint256;

    struct OperatorInfo {
      bool isActive;
    }

    mapping (address => uint) Operators;
    mapping (uint => OperatorInfo) OperatorInfos;
    uint length;

    function addOperator(address operatorAddress) public {

    }

    function terminateOperator(address operatorAddress) public {

    }

    function activeOperator(address operatorAddress) public {

    }

    function isOperator(address operatorAddress) public {

    }
}
