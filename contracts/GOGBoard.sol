pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract GOGBoard is Ownable {

    using SafeMath for uint256;
    /**
    * boardMember's Info
    */
    struct BoardMember{
      address memberAddress;
      uint64 memberTime;
      String memberName;
    }

    /**
    * the propose struct
    */
    struct Propose {
      bytes type;
      uint numberOfVotes;
      mapping (address -> bool) voted;
      uint agree;
      uint startTime;
      bool proposalPassed;
      bool executed;
    }

    BoardMember[] boardMembers;
    mapping (uint8 -> Propose) voteToPropose;
    mapping (address -> uint) memberToIndex;
    uint sGMarginOfVotesForMajority;
    uint minimumQuorumForProposals;
    uint addMarginOfVotesForMajority;
    uint deleteMarginOfVotesForMajority;
    uint cMMarginOfVotesForMajority;
    address chairMan;
    address secretaryGeneral;
    mapping (address -> bool) systemAddress;
    bool isPause;

    modifier onlyMembers {
        require(memberId[msg.sender] != 0);
        _;
    }

    modifier onlyAdmin {

    }

    modifier onlyBoardMember {

    }

    /**
     * Constructor function
     */
    function GOGBoard (
      uint sGMarginOfVotesForMajority,
      uint minimumQuorumForProposals,
      uint addMarginOfVotesForMajority,
      uint deleteMarginOfVotesForMajority,
      uint cMMarginOfVotesForMajority,
    )
      public
    {

    }

    function setSGMarginOfVotesForMajority (uint sGMarginOfVotesForMajority) public onlyAdmin {

    }

    function setMinimumQuorumForProposals(uint minimumQuorumForProposals) public onlyAdmin {

    }

    function setAddMarginOfVotesForMajority (uint addMarginOfVotesForMajority) public onlyAdmin  {

    }

    function setDeleteMarginOfVotesForMajority(uint deleteMarginOfVotesForMajority) public onlyAdmin {

    }

    function setCMMarginOfVotesForMajority(uint cMMarginOfVotesForMajority) public onlyAdmin {

    }

    function addSystemAddress(address systemAddress) public onlyAdmin  {

    }

    function removeSystemAddress(address systemAddress) public onlyAdmin  {

    }

    function vote(bytes type, bool isAgree) public onlyMember  {

    }

    function propose (bytes type, address memberVoted) public onlyMember  {

    }

    function execute (bytes type) public onlyMember {

    }

    function isChairMan(address chairManAddress) public view returns (bool) {

    }

    function isSecretaryGeneral(address secretaryGeneralAddress) public  view returns (bool) {

    }

    function isBoardMember(address boardMember) public view returns (bool) {

    }

    function pause () public onlyAdmin {

    }

    function unPause() public onlyAdmin {

    }

    function isPaused () public view returns (bool) {

    }

    function _addMember(address targetMember)  private onlyAdmin {
    }

    function _removeMember(address targetMember) private onlyAdmin  {

    }

}
