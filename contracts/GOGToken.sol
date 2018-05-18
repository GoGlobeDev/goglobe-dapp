pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "zeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

/**
 * @title Goglobe ERC20 token
 *
 * @dev Implementation of the basic standard token.
 * @dev https://github.com/ethereum/EIPs/issues/20
 * @dev Based on code by FirstBlood: https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 */
contract GOGToken is DetailedERC20, StandardToken, Ownable {

  using SafeMath for uint256;

    // This notifies clients about the amount burnt
    event Burn(address indexed from, uint256 value);

    /**
     * Constrctor function
     * Initializes contract with initial supply tokens to the creator of the contract
     */
    function GOGToken() DetailedERC20('GoGlobe Token', 'GOGT', 6) public {
      totalSupply_ = 100000000;
      balances[msg.sender] = totalSupply_;
    }

    /**
     * Destroy tokens
     * Remove `_value` tokens from the system irreversibly
     * @param _value the amount of money to burn
     */
    function burn(uint256 _value) public returns (bool) {
      require(balances[msg.sender] >= _value);   // Check if the sender has enough
      balances[msg.sender] -= _value;            // Subtract from the sender
      totalSupply -= _value;                      // Updates totalSupply
      Burn(msg.sender, _value);
      return true;
    }

    /**
     * Destroy tokens from other account
     * Remove `_value` tokens from the system irreversibly on behalf of `_from`.
     * @param _from the address of the sender
     * @param _value the amount of money to burn
     */
    function burnFrom(address _from, uint256 _value) public returns (bool) {
      require(balances[_from] >= _value);                // Check if the targeted balance is enough
      require(_value <= allowance[_from][msg.sender]);    // Check allowance
      balances[_from] -= _value;                         // Subtract from the targeted balance
      allowance[_from][msg.sender] -= _value;             // Subtract from the sender's allowance
      totalSupply -= _value;                              // Update totalSupply
      Burn(_from, _value);
      return true;
    }
}
