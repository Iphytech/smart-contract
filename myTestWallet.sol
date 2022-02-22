//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract myToken {
    address public owner;
    mapping(address => uint256) public balance;

    event notify(address _from, address _to, uint256 _amount);

    constructor() {
        owner = msg.sender;
    }

    modifier isOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    function mint(address _to, uint256 _amount) public isOwner {
        balance[_to] += _amount;
    }

    function send(address _to, uint256 _amount) public {
        require(_amount <= balance[msg.sender], "Insufficient balance");
        balance[msg.sender] -= _amount;
        balance[_to] += _amount;
        emit notify(owner, _to, _amount);
    }
}
