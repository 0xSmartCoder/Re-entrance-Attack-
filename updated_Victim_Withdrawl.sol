
function withdraw(uint _amount) public {
    require(balances[msg.sender] >= _amount, "Not enough balance");

    // ✅ State update before external call
    balances[msg.sender] -= _amount;

    (bool sent, ) = msg.sender.call{value: _amount}("");
    require(sent, "Failed to send");
}
