pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGBoardAccessor.sol";
import "./ERC721.sol";

contract GOGA is ERC721,GOGBoardAccessor {

    using SafeMath for uint256;

    struct Asset {
      string name;
    }

    mapping(uint256 => Asset) assetInfo;
    mapping(uint256 => uint256[]) projectToAsset;
    mapping(uint256 => uint256) assetToProject;
    mapping(uint256 => uint256) assetToProjectIndex;

    function createAsset(uint256 projectId, string _name) public {
      uint256 tokenId = totalSupply();
      _mint(msg.sender, tokenId);
      uint length = projectToAsset[projectId].push(tokenId);
      assetToProjectIndex[tokenId] = length.sub(1);
      assetToProject[tokenId] = projectId;
      Asset memory asset = Asset({
        name: _name
      });
      assetInfo[tokenId] = asset;
    }

}
