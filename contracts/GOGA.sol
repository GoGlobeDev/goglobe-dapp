pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGBoardAccessor.sol";
import "./ERC721.sol";

contract GOGA is ERC721,GOGBoardAccessor {

    using SafeMath for uint256;
    struct Asset {
      string name;
    }

    uint256 tokenId;
    mapping(uint256 => Asset) assetInfo;
    mapping(uint256 => uint256[]) projectToAsset;
    mapping(uint256 => uint256) assetToProject;
    mapping(uint256 => uint256) assetInProjectIndex;

    event CreateAsset(address indexed _operator, uint256 indexed _projectId, string _name);

    constructor(string _name, string _symbol) ERC721(_name, _symbol) public {}

    function getProjectByTokenId(uint _tokenId) public view returns (uint) {
      return assetToProject[_tokenId];
    }

    function createAsset(uint256 projectId, string _name) public whenNotPaused returns(uint256){
      require(projectId > 0);
      tokenId = tokenId.add(1);
      require(!exists(tokenId));
      _mint(msg.sender, tokenId);
      uint length = projectToAsset[projectId].push(tokenId);
      assetInProjectIndex[tokenId] = length.sub(1);
      assetToProject[tokenId] = projectId;
      Asset memory asset = Asset({
        name: _name
      });
      assetInfo[tokenId] = asset;
      emit CreateAsset(msg.sender, projectId, _name);
      return tokenId;
    }

    function updateTokenId(uint256 _tokenId) public whenNotPaused onlyAdmin {
      require(_tokenId > tokenId);
      tokenId = _tokenId;
    }

    function burn(address _owner, uint256 _tokenId) public whenNotPaused onlySystemAddress {
      _burn(_owner, _tokenId);
    }

    function mint(address _to, uint256 _tokenId) public whenNotPaused onlySystemAddress {
      _mint(_to, _tokenId);
    }
}
