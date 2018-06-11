pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGBoardAccessor.sol";
import "./Lawyer.sol";
import "./Operator.sol";
import "./GOGA.sol";

contract Certification is GOGBoardAccessor {

    using SafeMath for uint256;

    mapping(uint => uint[]) lawyerToGOGAProject;
    mapping(uint => uint) gogAProjectToLawyer;
    mapping(uint => uint) gogAToOperator;
    mapping(uint => uint[]) operatorToGOGA;
    Lawyer lawyer;
    Operator operator;
    GOGA gogA;

    modifier onlyLawyer {
      require(lawyer.isLawyer(msg.sender));
      _;
    }

    modifier onlyOperator {
      require(operator.isOperator(msg.sender));
      _;
    }

    function updateLawyer(address lawyerAddress) public whenNotPaused onlyAdmin {
      require(address(0) != lawyerAddress);
      lawyer = Lawyer(lawyerAddress);
    }

    function updateOperator(address operatorAddress) public whenNotPaused onlyAdmin {
      require(address(0) != operatorAddress);
      operator = Operator(operatorAddress);
    }

    function updateGOGA(address _gogA) public whenNotPaused onlyAdmin {
      require(address(0) != _gogA);
      gogA = GOGA(_gogA);
    }

    function certificateByLawyer(address lawyerAddress, uint256 projectTokenId) public whenNotPaused onlyLawyer returns (bool){
      lawyerToGOGAProject[lawyer.getTokenId(lawyerAddress)].push(projectTokenId);
      gogAProjectToLawyer[projectTokenId] = lawyer.getTokenId(lawyerAddress);
    }

    function setOperator(address operatorAddress, uint256 tokenId) public whenNotPaused onlyAdmin returns (bool){
      gogAToOperator[tokenId] = operator.getTokenId(operatorAddress);
      operatorToGOGA[operator.getTokenId(operatorAddress)].push(tokenId);
    }

    function isCertificated(uint256 tokenId) public view returns (bool){
      return (gogAToOperator[gogA.getProjectByTokenId(tokenId)] != 0 && gogAToOperator[tokenId] != 0);
    }
}
