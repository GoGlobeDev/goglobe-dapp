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
      uint numberOfVotes;
      mapping (address -> bool) voted;
      uint agree;
      uint startTime;
      uint endTime;
      bool isVoting;
      address votedAddress;
      string votedName;
    }

    uint8 constant TYPE_ADD = 1;
    uint8 constant TYPE_DELETE = 2;
    uint8 constant TYPE_UPDATE_CHAIRMAN = 3;
    uint8 constant TYPE_UPDATE_SECRETARYGENERAL = 4;
    uint8 constant EXECUTE_RESULT_FAIL = 0;
    uint8 constant EXECUTE_RESULT_SUCCESS = 1;
    bool pause;
    uint minutesForDebate;
    uint minimumQuorumForProposals;
    uint sGMarginOfVotesForMajority;
    uint addMarginOfVotesForMajority;
    uint deleteMarginOfVotesForMajority;
    uint cMMarginOfVotesForMajority;
    address chairMan;
    address secretaryGeneral;
    mapping (uint8 -> Propose) voteToPropose;
    mapping (address -> uint) memberToIndex;
    mapping (address -> bool) systemAddress;
    BoardMember[] boardMembers;

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

    modifier whenCorrectType(uint8 _type) {
      require (TYPE_ADD == _type || TYPE_DELETE == _type || TYPE_UPDATE_CHAIRMAN == _type || TYPE_UPDATE_SECRETARYGENERAL == _type);
      _;
    }

    event SetSGMarginOfVotesForMajority(address indexed _operator, uint _sGMarginOfVotesForMajority);
    event SetMinimumQuorumForProposals(address indexed _operator, uint _minimumQuorumForProposals);
    event SetAddMarginOfVotesForMajority(address indexed _operator, uint _addMarginOfVotesForMajority);
    event SetDeleteMarginOfVotesForMajority(address indexed _operator, uint _deleteMarginOfVotesForMajority);
    event SetCMMarginOfVotesForMajority(address indexed _operator, uint _cMMarginOfVotesForMajority);
    event SetMinutesForDebate(address indexed _operator, uint _minutesForDebate);
    event AddSystemAddress(address indexed _operator, address indexed _systemAddress);
    event DeleteSystemAddress(address indexed _operator, address indexed _systemAddress);
    event Pause(address indexed _operator);
    event UnPause(address indexed _operator);
    event ProposeEvent(address indexed _operator, uint8 indexed _votedType, address _votedAddress);
    event VoteEvent(address indexed _operator, uint8 indexed _votedType, bool _isAgree);
    event AddMember(address indexed _operator, address indexed _votedMember);
    event DeleteMember(address indexed _operator, address indexed _votedMember);
    event UpdateChairMan(address indexed _operator, address indexed _votedMember);
    event UpdateSecretaryGeneral(address indexed _operator, address indexed _votedMember);
    event DeletePropose(address indexed _operator, uint8 indexed _votedType, uint8 _executeResult);

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
      BoardMember boardMemberNull = BoardMember ({
        memberAddress:address(0),
        memberTime:now,
        memberName:"null"
      });
      boardMembers.push(boardMember);
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
      systemAddress[systemAddress] = true;
      emit AddSystemAddress(msg.sender, systemAddress);
    }

    function removeSystemAddress(address systemAddress) public onlyAdmin  {
      delete systemAddress[systemAddress];
      emit DeleteSystemAddress(msg.sender, systemAddress);
    }

    function vote(uint8 type, bool isAgree) public onlyMember whenCorrectType(type) {
      Propose storage propose = voteToPropose[type];
      require (propose.isVoting == true && propose.voted[msg.sender] == false)
      propose.numberOfVotes += 1;
      if (isAgree) {
        propose.agree += 1;
      }
      emit VoteEvent(msg.sender, type, isAgree);
    }

    function propose (uint8 type, address memberVoted, string _votedName) public onlyMember whenCorrectType(type) {
      require(address(0) != memberVoted);
      Propose oldPropose = voteToPropose[type];
      require(!oldPropose.isVoting);
      Propose propose = Propose({
        numberOfVotes:0,
        agree:0,
        startTime:now,
        endTime:now + debatingPeriodInMinutes * 1 minutes,
        isVoting:true,
        votedAddress:memberVoted,
        votedName:_votedName
      });
      voteToPropose[type] = propose;
      emit ProposeEvent(msg.sender, type, memberVoted);
    }

    function execute(uint8 type) public onlyMember whenCorrectType(type) {
      Propose propose = voteToPropose[type];
      require(propose.isVoting == true && now >= endTime);
      uint8 executeResult = EXECUTE_RESULT_SUCCESS;
      if (minimumQuorumForProposals > voteToPropose.numberOfVotes) {
        executeResult = EXECUTE_RESULT_FAIL;
      } else {
        if(TYPE_ADD == type) {
          if (propose.agree >= addMarginOfVotesForMajority) {
            _addMember(propose.votedAddress, propose.votedName);
          } else {
            executeResult = EXECUTE_RESULT_FAIL;
          }
        } else if(TYPE_DELETE == type) {
          if(propose.agree >= deleteMarginOfVotesForMajority) {
            _removeMember(propose.votedAddress);
          } else {
            executeResult = EXECUTE_RESULT_FAIL;
          }
        } else if(TYPE_UPDATE_CHAIRMAN == type) {
          if (propose.agree >= cMMarginOfVotesForMajority) {
            _updateChairMan(propose.votedAddress);
          } else {
            executeResult = EXECUTE_RESULT_FAIL;
          }
        } else if (TYPE_UPDATE_SECRETARYGENERAL == type) {
          if (propose.agree >= sGMarginOfVotesForMajority) {
            _updateSecretaryGeneral(propose.votedAddress);
          } else {
            executeResult = EXECUTE_RESULT_FAIL;
          }
        }
      }
      _deleteVoted(type, executeResult);
    }

    function isChairMan(address _chairManAddress) public view returns (bool) {
      return chairManAddress == _chairManAddress;
    }

    function isSecretaryGeneral(address _secretaryGeneralAddress) public  view returns (bool) {
      return secretaryGeneralAddress == _secretaryGeneralAddress;
    }

    function isBoardMember(address boardMember) public view returns (bool) {
      return memberToIndex[boardMember] != 0;
    }

    function pause () public onlyAdmin {
      pause = true;
      emit Pause(msg.sender);
    }

    function unPause() public onlyAdmin {
      pause = false;
      emit UnPause(msg.sender);
    }

    function isPaused() public view returns (bool) {
      return pause;
    }

    function _addMember(address targetMember, string _memberName) private  {
      BoardMember boardMember = BoardMember ({
        memberAddress:msg.sender,
        memberTime:now,
        memberName:_memberName
      });
      uint length = boasrdMember.push(boardMember);
      memberToIndex[targetMember] = length - 1;
      emit AddMember(msg.sender, targetMember);
    }

    function _removeMember(address targetMember) private {
      uint location = memberToIndex[targetMember];
      delete boasrdMember[location];
      delete memberToIndex[targetMember];
      emit DeleteMember(msg.sender, targetMember);
    }

    function _updateChairMan(address targetMember) private {
      chairMan = targetMember;
      emit UpdateChairMan(msg.sender, targetMember);
    }

    function _updateSecretaryGeneral(address targetMember) private {
      secretaryGeneral = targetMember;
      emit UpdateSecretaryGeneral(msg.sender, targetMember);
    }

    function _deleteVoted(uint8 type, uint8 executeResult) private {
      Propose storage propose = voteToPropose[type];
      delete propose.voted;
      delete voteToPropose[type];
      emit DeletePropose(msg.sender, type, executeResult);
    }

}
