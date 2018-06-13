pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./GOGBoardAccessor.sol";

contract Lawyer is GOGBoardAccessor {

    using SafeMath for uint256;

    struct LawyerInfo {
      bool isActive;
    }

    uint256 tokenId;
    mapping (address => uint) lawyers;
    mapping (uint => LawyerInfo) lawyerInfos;

    function addLawyer(address lawyerAddress) public whenNotPaused onlyAdmin returns (uint256){
      tokenId = tokenId.add(1);
      lawyers[lawyerAddress] = tokenId;
      LawyerInfo memory lawyerInfo = LawyerInfo({
        isActive: true
      });
      lawyerInfos[lawyers[lawyerAddress]] = lawyerInfo;
      return lawyers[lawyerAddress];
    }

    function terminateLawyer(address lawyerAddress) public whenNotPaused onlyAdmin{
      lawyerInfos[lawyers[lawyerAddress]].isActive = false;
    }

    function activeLawyer(address lawyerAddress) public whenNotPaused onlyAdmin{
      lawyerInfos[lawyers[lawyerAddress]].isActive = true;
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
    }
}
