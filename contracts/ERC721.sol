pragma solidity ^0.4.23;

import './SafeMath.sol';
import './GOGBoard.sol';

contract ERC721 {

  using SafeMath for uint256;

  string name;
  string symbol;
  uint256[] internal allTokens;
  mapping (uint256 => uint256) internal ownedTokensIndex;
  mapping (uint256 => uint256) internal allTokensIndex;
  mapping (address => uint256) internal ownedTokensCount;
  mapping (uint256 => address) internal tokenOwner;
  mapping (uint256 => address) internal tokenApprovals;
  mapping (address => uint256[]) internal ownedTokens;
  mapping (address => mapping (address => bool)) internal operatorApprovals;

  event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
  event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

  modifier canTransfer (uint256 _tokenId) {
    require(_isApprovedOrOwner(msg.sender, _tokenId));
    _;
  }

  modifier onlyOwnerOf (uint256 _tokenId) {
    require(msg.sender == ownerOf(_tokenId));
    _;
  }

  constructor(string _name, string _symbol) public {
    name = _name;
    symbol = _symbol;
  }

  function totalSupply() public view returns (uint256) {
    return allTokens.length;
  }

  function tokensOf(address _owner) public view returns (uint256[]) {
    return ownedTokens[_owner];
  }

  function getApproved(uint256 _tokenId) public view returns (address) {
    return tokenApprovals[_tokenId];
  }

  function isApprovedForAll(address _owner, address _operator) public view returns (bool) {
    return operatorApprovals[_owner][_operator];
  }

  function tokenOfOwnerByIndex(address _owner, uint256 _index) public view returns (uint256) {
    require(_index < balanceOf(_owner));
    return ownedTokens[_owner][_index];
  }

  function tokenByIndex(uint256 _index) public view returns (uint256) {
    require(_index < totalSupply());
    return allTokens[_index];
  }

  function balanceOf(address _owner) public view returns (uint256) {
    require(address(0) != _owner);
    return ownedTokensCount[_owner];
  }

  function ownerOf(uint256 _tokenId) public view returns (address) {
    address owner = tokenOwner[_tokenId];
    require(address(0) != owner);
    return owner;
  }

  function exists(uint256 _tokenId) public view returns (bool) {
    address owner = tokenOwner[_tokenId];
    return owner != address(0);
  }

  function _approve(address _to, uint256 _tokenId) internal {
    address owner = ownerOf(_tokenId);
    require(_to != owner);
    require(msg.sender == owner || isApprovedForAll(owner,msg.sender));
    if (getApproved(_tokenId) != address(0) || _to != address(0)) {
      tokenApprovals[_tokenId] = _to;
      emit Approval(owner, _to, _tokenId);
    }
  }

  function _setApprovalForAll(address _to, bool _approved) internal {
    require(_to != msg.sender);
    operatorApprovals[msg.sender][_to] = _approved;
    emit ApprovalForAll(msg.sender, _to, _approved);
  }

  function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool){
    address owner = ownerOf(tokenId);
    return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner,spender));
  }

  function _clearApproval (address _owner, uint256 _tokenId) internal {
    require(_owner == ownerOf(_tokenId));
    if (tokenApprovals[_tokenId] != address(0)) {
      tokenApprovals[_tokenId] = address(0);
      emit Approval(_owner, address(0), _tokenId);
    }
  }

  function _removeTokenFrom(address _from, uint256 _tokenId) internal{
    require(ownerOf(_tokenId) == _from);
    ownedTokensCount[_from] = ownedTokensCount[_from].sub(1);
    tokenOwner[_tokenId] = address(0);
    uint256 tokenIndex = ownedTokensIndex[_tokenId];
    uint256 lastTokenIndex = ownedTokens[_from].length.sub(1);
    uint256 lastToken = ownedTokens[_from][lastTokenIndex];
    ownedTokens[_from][tokenIndex] = lastToken;
    ownedTokens[_from][lastTokenIndex] = 0;
    ownedTokens[_from].length --;
    ownedTokensIndex[_tokenId] = 0;
    ownedTokensIndex[lastToken] = tokenIndex;
  }

  function _addTokenTo(address _to, uint256 _tokenId) internal {
    require(tokenOwner[_tokenId] == address(0));
    tokenOwner[_tokenId] = _to;
    ownedTokensCount[_to] = ownedTokensCount[_to].add(1);
    uint256 length = ownedTokens[_to].length;
    ownedTokens[_to].push(_tokenId);
    ownedTokensIndex[_tokenId] = length;
  }

  function _transferFrom(address _from, address _to, uint256 _tokenId) internal canTransfer(_tokenId) {
    require(address(0) != _from);
    require(address(0) != _to);
    _clearApproval(_from,_tokenId);
    _removeTokenFrom(_from, _tokenId);
    _addTokenTo(_to, _tokenId);
    emit Transfer(_from, _to, _tokenId);
  }

  function _mint(address _to, uint256 _tokenId) internal {
    require(address(0) != _to);
    _addTokenTo(_to, _tokenId);
    emit Transfer(address(0), _to, _tokenId);
    allTokensIndex[_tokenId] = allTokens.length;
    allTokens.push(_tokenId);
  }

  function _burn(address _owner, uint256 _tokenId) internal {
    _clearApproval(_owner, _tokenId);
    _removeTokenFrom(_owner, _tokenId);
    emit Transfer(_owner, address(0), _tokenId);
    uint256 tokenIndex = allTokensIndex[_tokenId];
    uint256 lastTokenIndex = allTokens.length.sub(1);
    uint256 lastToken = allTokens[lastTokenIndex];
    allTokens[tokenIndex] = lastToken;
    allTokens[lastTokenIndex] = 0;
    allTokens.length --;
    allTokensIndex[_tokenId] = 0;
    allTokensIndex[lastToken] = tokenIndex;
  }
}
