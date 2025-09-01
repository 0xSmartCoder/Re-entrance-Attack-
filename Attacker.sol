// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract VulnerableVault {
    mapping(address => uint) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // Vulnerable withdrawal — updates state AFTER sending funds

    function withdrawAll() external {
        uint bal = balances[msg.sender];
        require(bal > 0, "No balance");
        // external call FIRST (vulnerable)
        (bool ok,) = msg.sender.call{value: bal}("");
        require(ok, "Transfer failed");
        // state updated AFTER external call — BAD
        balances[msg.sender] = 0;
    }
}


Problem: external call happens before balances[msg.sender] = 0. If the receiver re-enter he can call  withdrawal agai.n