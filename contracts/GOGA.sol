pragma solidity ^0.4.23;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGBoardAccessor.sol";
import "./ERC721.sol";

contract GOGA is ERC721,GOGBoardAccessor {

    using SafeMath for uint256;

    struct Asset {
      string name;
    }

    mapping(uint256 => Asset) assetInfo;
    mapping(uint256 => uint256) projectToAsset;

    function createAsset() public {

    }

}
