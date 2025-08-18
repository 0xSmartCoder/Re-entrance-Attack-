pragma solidity ^0.8.28;

contract Victim {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public {
        require(balances[msg.sender] >= _amount, "Not enough balance");

        // ❌ External call before state update
        (bool sent, ) = msg.sender.call{value: _amount}("");
        require(sent, "Failed to send");

        balances[msg.sender] -= _amount;
    }
}
