pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGBoardAccessor.sol";

contract Operator is GOGBoardAccessor {

    using SafeMath for uint256;

    struct OperatorInfo {
      bool isActive;
      string name;
      string desc;
      string url;
    }

    uint256 tokenId;
    mapping (address => uint) operators;
    mapping (uint => OperatorInfo) operatorInfos;

    function addOperator(address operatorAddress, string _name, string _desc, string _url) public whenNotPaused onlyAdmin returns (uint256){
      tokenId = tokenId.add(1);
      operators[operatorAddress] = tokenId;
      OperatorInfo memory operatorInfo = OperatorInfo({
        isActive: true,
        name: _name,
        desc: _desc,
        url: _url
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
