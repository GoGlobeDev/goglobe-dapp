pragma solidity ^0.4.23;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGBoardAccessor.sol";

contract Lawyer is GOGBoardAccessor {

    using SafeMath for uint256;

    struct LawyerInfo {
      bool isActive;
    }

    mapping (address => uint) lawyers;
    mapping (uint => LawyerInfo) lawyerInfos;
    uint length;

    function addLawyer(address lawyerAddress) public {

    }

    function terminateLawyer(address lawyerAddress) public {

    }

    function activeLawyer(address lawyerAddress) public {

    }

    function isLawyer(address lawyerAddress) public {

    }
}
