pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/math/SafeMath.sol';
import './GOGBoard.sol';

contract GOGBoardAccessor {

  using SafeMath for uint256;

  /*** STORAGE ***/

  // @dev GOGBoard contract.
  GOGBoard gogBoard;

  // @dev check if GOG SYSTEM is not paused.
  modifier whenVideoBaseNotPaused() {
    require(address(gogBoard) != address(0) &&
            !gogBoard.paused());
    _;
  }

  // @dev check if the sender is one of the board members of GoGlobe.
  modifier onlyGOGBoardMembers() {
    require(address(gogBoard) != address(0) &&
            gogBoard.findBoardMember(msg.sender) >= 0);
    _;
  }

  // @dev check if the sender is one of the system accounts of GOGBoard.
  modifier onlyGOGSystemAccounts() {
    require(address(gogBoard) != address(0) &&
            gogBoard.findSystemAccount(msg.sender) >= 0);
    _;
  }

  // @dev check if the sender is from GOGBoard contract.
  modifier onlyFromGOGBoard() {
    require(address(gogBoard) != address(0) &&
            msg.sender == address(gogBoard));
    _;
  }

  // @dev set GOGBoard contract. Only when gogBoard is empty
  // @param _gogBoard to be set.
  function setGOGBoard(address _gogBoard)
      public {
    require(address(gogBoard) == address(0));
    GOGBoard myGOGBoard = GOGBoard(_gogBoard);
    require(myGOGBoard.supportsGOGBoard());
    gogBoard = myGOGBoard;
  }

  // @dev reset GOGBoard contract.
  function resetGOGBoard()
      public {
    require(address(gogBoard) != address(0) && msg.sender == gogBoard.owner());
    delete gogBoard;
  }

  // @dev get the address of the current gogBoard contract.
  function getGOGBoard()
      public
      view
      onlyGOGSystemAccounts
      returns(address) {
    return address(gogBoard);
  }
}
