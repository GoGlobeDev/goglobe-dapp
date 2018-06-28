pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGBoardAccessor.sol";

contract GOGProject is GOGBoardAccessor{

    using SafeMath for uint256;

    uint tokenId;
    mapping(uint => bool) tokenExist;

    event CreateProject(address indexed _operator, uint indexed _tokenId);
    event UpdateTokenId(address indexed _operator, uint indexed _tokenId);

    function createProject() public whenNotPaused onlyAdmin returns (uint){
      tokenId = tokenId.add(1);
      tokenExist[tokenId] = true;
      emit CreateProject(msg.sender, tokenId);
      return tokenId;
    }

    function existTokenId(uint _tokenId) public view returns (bool) {
      return tokenExist[_tokenId];
    }

    function updateTokenId(uint _tokenId) public whenNotPaused onlyAdmin {
      require(_tokenId > tokenId);
      tokenId = _tokenId;
      emit UpdateTokenId(msg.sender, _tokenId);
    }
}
