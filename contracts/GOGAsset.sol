pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract GOGAsset is ERC721Token, Ownable {
  struct Asset {
    // The unique token id of the asset.
    uint256 tokenId;

    // The asset id. The first 4 characters are city prefix, followed by
    // an underscore, and the asset id on that platform.
    bytes32 assetId;

    // The timestamp from the block when this asset is generated in the block.
    uint64 birthTime;

    // The timestamp for the expiration date of the asset.
    uint64 expireTime;
  }
  /// @dev Initialize with tokenId 0 asset.
  function GOGAsset() ERC721Token("GoGlobe Asset", "GOGA") public {
    Asset memory _invalidAsset = Asset({
        tokenId: 0,
        assetId: "INVALID",
        birthTime: 0,
        expireTime: 0
    });
    assets.push(_invalidAsset);
    _mint(msg.sender, _invalidAsset.tokenId);
    _burn(msg.sender, _invalidAsset.tokenId);
  }
}
