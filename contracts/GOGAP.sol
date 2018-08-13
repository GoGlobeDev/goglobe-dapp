pragma solidity ^0.4.23;

import "./SafeMath.sol";
import "./GOGBoardAccessor.sol";
import "./ERC721.sol";
import "./GOGA.sol";
import "./Certification.sol";
import "./GOGFAuction.sol";
import "./GOGSAuction.sol";

contract GOGAP is GOGBoardAccessor,ERC721 {

    using SafeMath for uint256;

    uint256 tokenId;
    mapping(uint => uint[]) aToP;
    mapping(uint => uint) pToA;
    //the split part whether or not merged
    mapping(uint => bool) pMerged;
    GOGA gogA;
    Certification certification;
    GOGFAuction gogFAuction;
    GOGSAuction gogSAuction;

    modifier onlyOwnerOfGOGA(uint256 gogATokenId) {
      require(msg.sender == gogA.ownerOf(gogATokenId));
      _;
    }

    modifier onlyGOGACertification(uint256 gogATokenId) {
      require(certification.isCertificated(gogATokenId));
      _;
    }

    event UpdateGogA(address indexed _operator, address _gogAAddress);
    event UpdateCertification(address indexed _operator, address _certificationAddress);
    event UpdateGOGFAuction(address indexed _operator, address _gogAuctionAddress);
    event UpdateGOGSAuction(address indexed _operator, address _gogAuctionAddress);
    event UpdateTokenId(address indexed _operator, uint _newTokenId);
    event CreatePFromA(address indexed _operator, uint indexed _aTokenId, uint copies);
    event MergePToA(address indexed _operator, uint[] _copies);

    constructor(string _name, string _symbol) ERC721(_name, _symbol) public {}

    function getPFromA(uint256 _tokenId) public view returns(uint256[]) {
      return aToP[_tokenId];
    }

    function getAFromP(uint256 _pTokenId) public view returns(uint256) {
      return pToA[_pTokenId];
    }

    function updateGogA(address gogAAddress) public whenNotPaused onlyAdmin {
      require(address(0) != gogAAddress);
      gogA = GOGA(gogAAddress);
      emit UpdateGogA(msg.sender, gogAAddress);
    }

    function updateCertification(address certificationAddress) public whenNotPaused onlyAdmin {
      require(address(0) != certificationAddress);
      certification = Certification(certificationAddress);
      emit UpdateCertification(msg.sender, certificationAddress);
    }

    function updateGOGFAuction(address gogFAuctionAddress) public whenNotPaused onlyAdmin {
      require(address(0) != gogFAuctionAddress);
      gogFAuction = GOGFAuction(gogFAuctionAddress);
      emit UpdateGOGFAuction(msg.sender, gogFAuctionAddress);
    }

    function updateGOGSAuction(address gogSAuctionAddress) public whenNotPaused onlyAdmin {
      require(address(0) != gogSAuctionAddress);
      gogSAuction = GOGSAuction(gogSAuctionAddress);
      emit UpdateGOGSAuction(msg.sender, gogSAuctionAddress);
    }

    function createPFromA(uint256 gogATokenId, uint256 copies) public whenNotPaused onlyOwnerOfGOGA(gogATokenId) onlyGOGACertification(gogATokenId) returns(uint256[]){
      tokenId = tokenId.add(1);
      require(!exists(tokenId));
      uint tokenId_ = tokenId;
      uint[] memory resTokenId = new uint[](copies);
      for (uint i = 0; i < copies; i++) {
        tokenId = tokenId_.add(i);
        _mint(msg.sender, tokenId);
        resTokenId[i] = tokenId;
        pToA[tokenId] = gogATokenId;
        pMerged[tokenId] = true;
        _approve(address(gogFAuction), tokenId);
        _approve(address(gogSAuction), tokenId);
      }
      aToP[gogATokenId] = resTokenId;
      emit CreatePFromA(msg.sender, gogATokenId, copies);
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
      emit MergePToA(msg.sender, copies);
    }

    function updateTokenId(uint256 _tokenId) public whenNotPaused onlyAdmin {
      require(_tokenId > tokenId);
      tokenId = _tokenId;
      emit UpdateTokenId(msg.sender, _tokenId);
    }

    function transferFrom(address _from, address _to, uint _tokenId) public onlySystemAddress{
      _transferFrom(_from, _to, _tokenId);
    }
}
