pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGBoardAccessor.sol";

contract Operator is GOGBoardAccessor {

    using SafeMath for uint256;

    struct OperatorInfo {
      bool isActive;
    }

    uint256 tokenId = 1;
    mapping (address => uint) operators;
    mapping (uint => OperatorInfo) operatorInfos;

    function addOperator(address operatorAddress) public whenNotPaused onlyAdmin returns (uint256){
      tokenId = tokenId.add(1);
      operators[operatorAddress] = tokenId;
      OperatorInfo memory operatorInfo = OperatorInfo({
        isActive: true
      });
      operatorInfos[operators[operatorAddress]] = operatorInfo;
      return operators[operatorAddress];
    }

    function terminateOperator(address operatorAddress) public whenNotPaused onlyAdmin{
      operatorInfos[operators[operatorAddress]].isActive = false;
    }

    function activeOperator(address operatorAddress) public whenNotPaused onlyAdmin{
      operatorInfos[operators[operatorAddress]].isActive = true;
    }

    function isOperator(address operatorAddress) public view returns (bool){
      return (operators[operatorAddress] != 0 && operatorInfos[operators[operatorAddress]].isActive == true);
    }


    function getTokenId(address operatorAddress) public view returns (uint256) {
      return operators[operatorAddress];
    }

    function changeAddress(address operatorAddress, uint _tokenId) public whenNotPaused onlyAdmin{
      require(_tokenId < tokenId);
      operators[operatorAddress] = _tokenId;
    }
}
