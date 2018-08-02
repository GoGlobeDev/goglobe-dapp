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
    mapping(uint => uint) gogAProjectToOperator;
    //operator do business with the GOGA's project
    mapping(uint => uint[]) operatorToGOGAProject;
    mapping(uint => uint) gogAPTokenToShareEth;
    mapping(uint => uint) gogAPTokenToShareGogT;
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
    event ShareOutBonus(address _operator, uint time, uint ethValue, uint gogValue, uint shareTokenId);
    event Withdraw(address indexed _operator, uint index _eth, uint index _gotT, uint[] _tokenId);

    /**
    *    check gogATokenId
    **/
    function isCertificated(uint256 _gogATokenId) public view returns (bool){
      uint _projectTokenId = gogA.getProjectByTokenId(_gogATokenId);
      return (gogAProjectToLawyer[_projectTokenId] != 0 && gogAProjectToOperator[_projectTokenId] != 0);
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
      gogAProjectToLawyer[projectTokenId] = lawyer.getTokenId(msg.sender);
      emit CertificateByLawyer(msg.sender, projectTokenId);
    }

    /**
    *    add token to operator
    **/
    function addTokenIdToOperator(address operatorAddress, uint256 projectTokenId) public whenNotPaused onlyAdmin returns (bool){
      gogAProjectToOperator[projectTokenId] = operator.getTokenId(operatorAddress);
      operatorToGOGAProject[operator.getTokenId(operatorAddress)].push(projectTokenId);
      emit AddTokenIdToOperator(msg.sender, operatorAddress, projectTokenId);
    }

    function shareOutBonus(uint _gogATokenId, uint gogTValue) public payable whenNotPaused onlyOperator {
      require(gogT.balanceOf(msg.sender) >= gogTValue);
      require(gogAProjectToOperator[gogA.getProjectByTokenId(_gogATokenId)] == operator.getTokenId(msg.sender));
      require(msg.value > 0);
      uint256[] memory gogATToken = gogAP.getPFromA(_gogATokenId);
      uint length = gogATToken.length;
      uint ethValue = msg.value.div(length);
      uint gogValue = gogTValue.div(length);
      gogT.burn(msg.sender,gogTValue);
      for (uint i = 0; i < length; i ++) {
        gogATTokenId = gogATToken[i];
        gogAPTokenToShareEth[gogATToken[i]] = gogAPTokenToShareEth[gogATToken[i]].add(ethValue);
        gogAPTokenToShareGogT[gogATToken[i]] = gogAPTokenToShareGogT[gogATToken[i]].add(gogValue);
        /*address owner = gogAP.ownerOf();
        owner.transfer(ethValue);
        gogT.mint(owner,gogValue);*/
        emit ShareOutBonus(msg.sender, now, ethValue, gogValue,gogATToken[i]);
      }
    }

    function withdraw(uint[] _gogAPToken) public payable whenNotPaused {
      withdrawTo(_gogAPToken,msg.sender);
    }

    function withdrawTo(uint[] _gogAPToken, address _toAddress) public payable whenNotPaused{
      require(address(0) != _toAddress);
      int totalEth = 0;
      int totalGogT = 0;
      for (int i = 0; i < _gogAPToken.length; i++) {
        require(_toAddress == gogAP.ownerOf(_gogAPToken[i]));
        totalEth = totalEth.add(gogAPTokenToShareEth[gogATToken[i]]);
        totalGogT = totalGogT.add(gogAPTokenToShareGogT[gogATToken[i]]);
      }
      if (totalEth > 0) {
        _toAddress.transfer(totalEth);
      }
      if (totalGogT > 0) {
        gogT.mint(totalGogT,_toAddress);
      }
      emit Withdraw(_toAddress,totalEth,totalGogT, _gogAPToken);
    }
}
