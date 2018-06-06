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
      uint memberTime;
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
    uint minutesForDebate;
    uint sGMarginOfVotesForMajority;
    uint minimumQuorumForProposals;
    uint addMarginOfVotesForMajority;
    uint deleteMarginOfVotesForMajority;
    uint cMMarginOfVotesForMajority;
    address chairMan;
    address secretaryGeneral;
    mapping (address -> bool) systemAddress;
    bool pause;

    /**
    *  only admin could operate
    */
    modifier onlyAdmin {
      require(msg.sender == chairMan || msg.sender == secretaryGeneral);
      _;
    }

    /**
    *  only boardMember could operate
    */
    modifier onlyBoardMember {
      require(memberId[msg.sender] != 0);
      _;
    }

    /**
    *  only the contract not pause
    */
    modifier whenIsNotPaused {
      require(!pause);
      _;
    }

    event SetSGMarginOfVotesForMajority(address indexed _person, uint _sGMarginOfVotesForMajority);
    event SetMinimumQuorumForProposals(address indexed _person, uint _minimumQuorumForProposals);
    event SetAddMarginOfVotesForMajority(address indexed _person, uint _addMarginOfVotesForMajority);
    event SetDeleteMarginOfVotesForMajority(address indexed _person, uint _deleteMarginOfVotesForMajority);
    event SetCMMarginOfVotesForMajority(address indexed _person, uint _cMMarginOfVotesForMajority);
    event SetMinutesForDebate(address indexed _person, uint _minutesForDebate);

    /**
     * Constructor function
     */
    function GOGBoard (
      uint _sGMarginOfVotesForMajority,
      uint _minimumQuorumForProposals,
      uint _addMarginOfVotesForMajority,
      uint _deleteMarginOfVotesForMajority,
      uint _cMMarginOfVotesForMajority,
      uint _minutesForDebate,
      string _memberName
    )
      public
    {
      sGMarginOfVotesForMajority = _sGMarginOfVotesForMajority;
      minimumQuorumForProposals = _minimumQuorumForProposals;
      addMarginOfVotesForMajority = _addMarginOfVotesForMajority;
      deleteMarginOfVotesForMajority = _deleteMarginOfVotesForMajority;
      cMMarginOfVotesForMajority = _cMMarginOfVotesForMajority;
      minutesForDebate = _minutesForDebate;
      chairMan = msg.sender;
      secretaryGeneral = msg.sender;
      BoardMember boardMember = BoardMember ({
        memberAddress:msg.sender,
        memberTime:now,
        memberName:_memberName
      });
      uint length = boardMembers.push(boardMember);
      memberToIndex[msg.sender] = length - 1;
      pause = false;
    }

    function setSGMarginOfVotesForMajority (uint _sGMarginOfVotesForMajority) public onlyAdmin {
      sGMarginOfVotesForMajority = _sGMarginOfVotesForMajority;
      emit SetSGMarginOfVotesForMajority(msg.sender, _sGMarginOfVotesForMajority);
    }

    function setMinimumQuorumForProposals(uint _minimumQuorumForProposals) public onlyAdmin {
      minimumQuorumForProposals = _minimumQuorumForProposals;
      emit SetMinimumQuorumForProposals(msg.sender, _minimumQuorumForProposals);
    }

    function setAddMarginOfVotesForMajority (uint _addMarginOfVotesForMajority) public onlyAdmin  {
      addMarginOfVotesForMajority = _addMarginOfVotesForMajority;
      emit SetAddMarginOfVotesForMajority(msg.sender, _addMarginOfVotesForMajority);
    }

    function setDeleteMarginOfVotesForMajority(uint _deleteMarginOfVotesForMajority) public onlyAdmin {
      deleteMarginOfVotesForMajority = _deleteMarginOfVotesForMajority;
      emit SetDeleteMarginOfVotesForMajority(msg.sender, _deleteMarginOfVotesForMajority);
    }

    function setCMMarginOfVotesForMajority(uint _cMMarginOfVotesForMajority) public onlyAdmin {
      cMMarginOfVotesForMajority = _cMMarginOfVotesForMajority;
      emit SetCMMarginOfVotesForMajority(msg.sender, _cMMarginOfVotesForMajority);
    }

    function setMinutesForDebate(uint _minutesForDebate) public onlyAdmin {
      minutesForDebate = _minutesForDebate;
      emit SetMinutesForDebate(msg.sender, _minutesForDebate);
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
