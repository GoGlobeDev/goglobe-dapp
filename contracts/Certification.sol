pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGBoardAccessor.sol";
import "./Lawyer.sol";
import "./Operator.sol";
import "./GOGA.sol";
import "./GOGAP.sol";
import "./GOGT.sol";

contract Certification is GOGBoardAccessor {

    using SafeMath for uint256;

    //lawyer has checked the projects of the GOGA
    mapping(uint => uint[]) lawyerToGOGAProject;
    mapping(uint => uint) gogAProjectToLawyer;
    mapping(uint => uint) gogAToOperator;
    //operator do business with the GOGA
    mapping(uint => uint[]) operatorToGOGA;
    Lawyer lawyer;
    Operator operator;
    GOGA gogA;
    GOGAP gogAP;
    GOGT gogT;

    modifier onlyLawyer {
      require(lawyer.isLawyer(msg.sender));
      _;
    }

    modifier onlyOperator {
      require(operator.isOperator(msg.sender));
      _;
    }

    event UpdateLawyer(address indexed _operator, address _lawyerAddress);
    event UpdateOperator(address indexed _operator, address _operatorAddress);
    event UpdateGOGA(address indexed _operator, address _gogAAddress);
    event UpdateGOGAP(address indexed _operator, address _gogAPAddress);
    event UpdateGOGT(address indexed _operator, address _gogTAddress);
    event CertificateByLawyer(address indexed _lawyer, uint _projectId);
    event AddTokenIdToOperator(address indexed _admin, address indexed _operator, uint _tokenId);
    event ShareOutBonus(address indexed _operator, address indexed _receiver, uint indexed time, uint ethValue, uint gogValue);

    function isCertificated(uint256 tokenId) public view returns (bool){
      return (gogAToOperator[gogA.getProjectByTokenId(tokenId)] != 0 && gogAToOperator[tokenId] != 0);
    }

    function updateLawyer(address lawyerAddress) public whenNotPaused onlyAdmin {
      require(address(0) != lawyerAddress);
      lawyer = Lawyer(lawyerAddress);
      emit UpdateLawyer(msg.sender, lawyerAddress);
    }

    function updateOperator(address operatorAddress) public whenNotPaused onlyAdmin {
      require(address(0) != operatorAddress);
      operator = Operator(operatorAddress);
      emit UpdateOperator(msg.sender, operatorAddress);
    }

    function updateGOGA(address _gogA) public whenNotPaused onlyAdmin {
      require(address(0) != _gogA);
      gogA = GOGA(_gogA);
      emit UpdateGOGA(msg.sender, _gogA);
    }

    function updateGOGAP(address _gogAP) public whenNotPaused onlyAdmin {
      require(address(0) != _gogAP);
      gogAP = GOGAP(_gogAP);
      emit UpdateGOGAP(msg.sender, _gogAP);
    }

    function updateGOGT(address _gogT) public whenNotPaused onlyAdmin {
      require(address(0) != _gogT);
      gogT = GOGT(_gogT);
      emit UpdateGOGT(msg.sender, _gogT);
    }

    function certificateByLawyer(uint256 projectTokenId) public whenNotPaused onlyLawyer returns (bool){
      lawyerToGOGAProject[lawyer.getTokenId(msg.sender)].push(projectTokenId);
      gogAProjectToLawyer[projectTokenId] = lawyer.getTokenId(lawyerAddress);
      emit CertificateByLawyer(msg.sender, projectTokenId);
    }

    function addTokenIdToOperator(address operatorAddress, uint256 tokenId) public whenNotPaused onlyAdmin returns (bool){
      gogAToOperator[tokenId] = operator.getTokenId(operatorAddress);
      operatorToGOGA[operator.getTokenId(operatorAddress)].push(tokenId);
      emit AddTokenIdToOperator(msg.sender, operatorAddress, tokenId);
    }

    function shareOutBonus(uint _gogATokenId, uint gogTValue) public payable whenNotPaused onlyOperator {
      require(gogT.balanceOf(msg.sender) >= gogTValue);
      require(gogAToOperator[_gogATokenId] == operator.getTokenId(msg.sender));
      require(msg.value > 0);
      uint256[] memory gogATToken = gogAP.getPFromA(_gogATokenId);
      uint length = gogATToken.length;
      uint ethValue = msg.value.div(length);
      uint gogValue = gogTValue.div(length);
      gogT.burn(msg.sender, gogTValue);
      for (uint i = 0; i < length; i ++) {
        address owner = gogAP.ownerOf(_gogATokenId);
        owner.transfer(ethValue);
        gogT.mint(owner,gogValue);
        emit ShareOutBonus(msg.sender, owner, now, ethValue, gogValue);
      }
    }
}
