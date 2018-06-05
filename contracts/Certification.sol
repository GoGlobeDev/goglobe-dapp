pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";

contract Certification is GOGBoardAccessor {

    using SafeMath for uint256;

    mapping(uint -> uint[]) lawyerToGOGA;
    mapping(uint -> uint) GOGAToLawyer;
    mapping(uint -> uint) GOGAToOperator;
    mapping(uint -> uint[]) operatorToGOGA;

    modifier onlyLawyer {

    }

    modifier onlyOperator {
      
    }

    function certificateByLawyer(address lawyerAddress, uint256 tokenId) public returns (bool){

    }

    function setOperator(address operatorAddress, uint256 tokenId) public returns (bool){

    }

    function isCertificated(uint256 tokenId) public returns (bool){

    }


}
