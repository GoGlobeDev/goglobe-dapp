pragma solidity ^0.4.23;

import "./SafeMath.sol";
import "./GOGBoardAccessor.sol";

contract Lawyer is GOGBoardAccessor {

    using SafeMath for uint256;

    struct LawyerInfo {
      bool isActive;
      string name;
      string url;
      string desc;
    }

    uint256 tokenId;
    //address to tokenId
    mapping (address => uint) lawyers;
    //tokenId to the lawyerInfo
    mapping (uint => LawyerInfo) lawyerInfos;

    event AddLawyer(address indexed _operator, address _lawyerAddress, uint _tokenId, string _name);
    event TerminateLawyer(address indexed _operator, address _lawyerAddress);
    event ActiveLawyer(address indexed _operator, address _lawyerAddress);
    event ChangeAddress(address indexed _operator, address indexed _changeAddress, uint indexed _tokenId);

    function addLawyer(address lawyerAddress, string _name, string _url, string _desc) public whenNotPaused onlyAdmin returns (uint256){
      tokenId = tokenId.add(1);
      lawyers[lawyerAddress] = tokenId;
      LawyerInfo memory lawyerInfo = LawyerInfo({
        isActive: true,
        name: _name,
        url: _url,
        desc: _desc
      });
      lawyerInfos[lawyers[lawyerAddress]] = lawyerInfo;
      emit AddLawyer(msg.sender, lawyerAddress, tokenId, _name);
      return tokenId;
    }

    function terminateLawyer(address lawyerAddress) public whenNotPaused onlyAdmin{
      lawyerInfos[lawyers[lawyerAddress]].isActive = false;
      emit TerminateLawyer(msg.sender, lawyerAddress);
    }

    function activeLawyer(address lawyerAddress) public whenNotPaused onlyAdmin{
      lawyerInfos[lawyers[lawyerAddress]].isActive = true;
      emit ActiveLawyer(msg.sender, lawyerAddress);
    }

    function isLawyer(address lawyerAddress) public view returns (bool){
      return (lawyers[lawyerAddress] != 0 && lawyerInfos[lawyers[lawyerAddress]].isActive == true);
    }

    function getTokenId(address lawyerAddress) public view returns (uint256) {
      return lawyers[lawyerAddress];
    }

    function changeAddress(address lawyerAddress, uint _tokenId) public whenNotPaused onlyAdmin{
      require(_tokenId < tokenId);
      lawyers[lawyerAddress] = _tokenId;
      emit ChangeAddress(msg.sender, lawyerAddress, _tokenId);
    }
}
