pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";

contract Exchange is GOGBoardAccessor {

    using SafeMath for uint256;

    bool pause;
    uint rate;
    uint fee;
    address beneficiary;
    GOGT gogT;

    modifier whenNotPaused {

    }

    function changeRate(uint rate) {

    }

    function changeFee(uint fee) {

    }

    function buyGOGT(uint value) {

    }

    function sellGOGT(uint value) {

    }

    function withdraw() {

    }

    function changeBeneficiary(address beneficiary) {

    }

    function functionPause() {

    }

    function unFunctionPause() {

    }
}
