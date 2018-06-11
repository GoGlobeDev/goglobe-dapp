pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGBoardAccessor.sol";
import "./ERC721.sol";
import "./GOGA.sol";

contract GOGAP is GOGBoardAccessor,ERC721 {

    using SafeMath for uint256;

    uint256 tokenId = 1;
    mapping(uint => uint[]) aToP;
    mapping(uint => uint) pToA;
    mapping(uint => bool) pMerged;
    GOGA gogA;

    modifier onlyOwnerOfGOGA(uint256 gogATokenId) {
      require(msg.sender == gogA.ownerOf(gogATokenId));
      _;
    }

    constructor(string _name, string _symbol) ERC721(_name, _symbol) public {}

    function updateGogA(address gogAAddress) public whenNotPaused onlyAdmin {
      require(address(0) != gogAAddress);
      gogA = GOGA(gogAAddress);
    }

    function createPFromA(uint256 gogATokenId, uint256 copies) public whenNotPaused onlyOwnerOfGOGA(gogATokenId) returns(uint256[]){
      uint tokenId_ = ++tokenId;
      require(exists(tokenId_));
      uint[] memory resTokenId = new uint[](copies);
      for (uint i = 0; i < copies; i++) {
        tokenId = tokenId.add(i);
        _mint((address(this)), tokenId);
        resTokenId[i] = tokenId;
        pToA[tokenId] = gogATokenId;
        pMerged[tokenId] = true;
      }
      aToP[gogATokenId] = resTokenId;
      return resTokenId;
    }

    function mergePToA(uint[] copies) public whenNotPaused{
      uint length = copies.length;
      require(length > 0);
      uint gogATokenId = pToA[copies[0]];
      require(length == aToP[gogATokenId].length);
      for (uint i = 0; i < length; i++) {
        require(msg.sender == ownerOf(copies[i]));
        pMerged[copies[i]] = false;
      }
      for (uint j = 0; j < length; j++) {
        require(!pMerged[aToP[gogATokenId][j]]);
      }
      gogA.burn(gogA.ownerOf(gogATokenId), gogATokenId);
      gogA.mint(msg.sender, gogATokenId);
      for (uint k = 0; k < length; k++) {
        _burn(msg.sender,copies[k]);
      }
    }

    function updateTokenId(uint256 _tokenId) public whenNotPaused onlyAdmin {
      require(_tokenId > tokenId);
      tokenId = _tokenId;
    }
}
