pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";

contract GOGA is ERC721,OGBoardAccessor {

    using SafeMath for uint256;

    struct Asset {
      string name;
    }

    mapping(uint256 -> Asset) assetInfo;
    mapping(uint256 -> uint256) projectToAsset;

    function createAsset() public onlyGOGSystemAccounts {

    }

}
