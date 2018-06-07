pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/math/SafeMath.sol';
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
  mapping (address => uint256[]) internal ownedTokens;
  mapping (address => mapping (address => bool)) internal operatorApprovals;

  event ApprovalForAll(address indexed _owner, address indexd _operator, bool _approved);
  event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

  modifier canTransfer (uint256 _tokenId) {
  }

  modifier onlyOwnerOf (uint 256 _tokenId) {
  }

  function isApprovedOrOwner() public view returns (bool){

  }

  function totalSupply() public view returns (uint256) {

  }

  function tokensOf(address _owner) public view returns (uint256[]) {

  }

  function getApproved(uint256 _tokenId) public view returns (address) {

  }

  function tokenOfOwnerByIndex(address _owner, uint256 _index) public view returns (uint256 _tokenId) {

  }

  function isApprovedForAll(address _owner, address _operator) public view returns (bool) {

  }

  function tokenByIndex(uint256 _index) public view returns (uint256) {

  }

  function balanceOf (address _owner) public view returns (uint256) {

  }

  function ownerOf(uint256 _tokenId) public view returns (address) {

  }

  function exists(uint256 _tokenId) public view returns (bool) {

  }

  function safeTransferFrom (address _from, address _to, uint256 _tokenId, bytes _data) internal {

  }

  function setApprovalForAll(address _to, bool _approved) internal {

  }

  function mint(address _to, uint256 _tokenId) internal {
  }

  function burn(address _owner, uint256 _tokenId) internal {

  }

  function transferFrom (address _from, address _to, uint256 _tokenId) internal{

  }

  function safeTransferFrom (address _from, address _to, uint256 _tokenId) internal{

  }

  function approve(address _to, uint256 _tokenId) internal{

  }

  function clearApproval (address _owner, uint256 _tokenId) internal {

  }

  function addTokenTo(address _to, uint256 _tokenId) internal {

  }

  function removeTokenFrom(address _from, uint256 _tokenId) internal{

  }

  function checkAndCallSafeTransfer (address _from, address _to, uint256 _tokenId, bytes _data) internal returns (bool) {

  }

}
