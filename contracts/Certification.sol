pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGBoardAccessor.sol";

contract Certification is GOGBoardAccessor {

    using SafeMath for uint256;

    mapping(uint => uint[]) lawyerToGOGA;
    mapping(uint => uint) GOGAToLawyer;
    mapping(uint => uint) GOGAToOperator;
    mapping(uint => uint[]) operatorToGOGA;

    modifier onlyLawyer {
      _;
    }

    modifier onlyOperator {
      _;
    }

    function certificateByLawyer(address lawyerAddress, uint256 tokenId) public returns (bool){

    }

    function setOperator(address operatorAddress, uint256 tokenId) public returns (bool){

    }

    function isCertificated(uint256 tokenId) public returns (bool){

    }


}
