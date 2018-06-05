pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/math/SafeMath.sol';
import './GOGBoard.sol';

contract GOGBoardAccessor {

  using SafeMath for uint256;

  /*** STORAGE ***/

  // @dev GOGBoard contract.
  GOGBoard gogBoard;

  // @dev check if GOG SYSTEM is not paused.
  modifier whenNotPaused {
  }

  modifier onlyBoardMember {
  }

  modifier onlyChairMan {

  }

  modifier onlySecretaryGeneral {

  }

  modifier onlyAdmin {

  }

  modifier whenIsSystemAddress {

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
