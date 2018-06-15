pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGAP.sol";
import "./GOGT.sol";

contract GOGAuction is GOGBoardAccessor{

  using SafeMath for uint256;

  struct Auction {
    bool isOnAuction;
    uint ethValue;
    uint gogTValue;
    uint endTime;
    address seller;
  }

  mapping (uint => Auction) tokenToAuction;
  GOGAP gogAP;
  GOGT gogT;

  modifier onlyAuctionOn(uint _tokenId) {
    require(tokenToAuction[_tokenId].isOnAuction);
    _;
  }

  modifier onlyOwnerOfGOGA(uint256 gogAPTokenId) {
    require(msg.sender == gogAP.ownerOf(gogAPTokenId));
    _;
  }

  event CreateAuction(address indexed _operator, uint indexed _tokenId, uint ethVlaue, uint gogValue);
  event CancleAuction(address indexed _operator, uint indexed _tokenId);
  event Bid(address indexed _operator, address indexed _seller, uint indexed _tokenId, uint ethVlaue, uint gogValue);

  function updateGOGAP(address gogAPAddress) public onlyAdmin {
    require(address(0) != gogAPAddress);
    gogAP = GOGAP(gogAPAddress);
  }

  function updateGOGT(address gogTAddress) public onlyAdmin {
    require(address(0) != gogTAddress);
    gogT = GOGT(gogTAddress);

  }

  function _createAuction(uint _tokenId, uint _ethValue, uint _gogTValue, uint defaultDuration) private onlyOwnerOfGOGA(_tokenId){
    require(!tokenToAuction[_tokenId].isOnAuction);
    require(defaultDuration > 0);
    require(_ethValue > 0);
    require(_gogTValue > 0);
    Auction memory auction = Auction({
      isOnAuction: true,
      ethValue: _ethValue,
      gogTValue: _gogTValue,
      seller: msg.sender,
      endTime: now + defaultDuration
    });
    tokenToAuction[_tokenId] = auction;
    gogAP.transferFrom(msg.sender, address(this), _tokenId);
    emit CreateAuction(msg.sender, _tokenId, _ethValue,_gogTValue);
  }

  function _cancleAuction(uint _tokenId) private onlyAuctionOn(_tokenId) {
    require(tokenToAuction[_tokenId].seller == msg.sender || isAdmin());
    delete tokenToAuction[_tokenId];
    emit CancleAuction(msg.sender, _tokenId);
  }

  function _bid(uint _tokenId) private onlyAuctionOn(_tokenId){
    Auction storage auction = tokenToAuction[_tokenId];
    require(now > auction.endTime);
    require(msg.value == auction.ethValue);
    gogT.burn(msg.sender, auction.gogTValue);
    gogT.mint(auction.seller,auction.gogTValue);
    gogAP.transferFrom(address(this), msg.sender, _tokenId);
    auction.seller.transfer(msg.value);
    emit Bid(msg.sender, auction.seller, _tokenId, auction.ethValue, auction.gogTValue);
    delete tokenToAuction[_tokenId];
  }

  function createAuction(uint _tokenId, uint _ethValue, uint _gogTValue, uint defaultDuration) public whenNotPaused{
    _createAuction(_tokenId, _ethValue, _gogTValue, defaultDuration);
  }

  function createAuctionList(uint[] _tokenIds, uint _ethValue, uint _gogTValue, uint defaultDuration) public whenNotPaused onlyAdmin{
    for (uint i = 0; i < _tokenIds.length; i ++) {
      _createAuction(_tokenIds[i], _ethValue, _gogTValue, defaultDuration);
    }
  }

  function cancleAuction(uint _tokenId) public whenNotPaused {
    _cancleAuction(_tokenId);
  }

  function bid(uint _tokenId) public payable whenNotPaused {
    _bid(_tokenId);
  }

}
