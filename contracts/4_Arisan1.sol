// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Arisan {
    address public owner;
    address[] public members;
    address public winner;
    uint256 public balance;

    mapping(address => bool) public isMember;
    mapping(address => uint256) public contributions;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    modifier onlyWinner() {
        require(msg.sender == winner, "Only the winner can withdraw funds");
        _;
    }

    constructor() payable  {
        owner = msg.sender;
        members.push(owner);
        balance += msg.value;
    }

    // Fungsi untuk mendaftarkan anggota
    function registerMember(address _member) external onlyOwner {
        require(!isMember[_member], "Address is already a member");
        members.push(_member);
        isMember[_member] = true;
    }

    // Fungsi untuk menyetor dana ke arisan
    function contribute(uint256 _amount) external payable {
        require(isMember[msg.sender], "You must be a member to contribute");
        require(msg.value >= _amount, "Contribution must be greater or equal than amount provided");
        balance += msg.value;
        contributions[msg.sender] += msg.value;
    }

    // Fungsi untuk mengocok pemenang
    function pickWinner() external onlyOwner {
        require(members.length > 0, "No members registered");
        require(balance > 0, "No funds available for distribution");
        
        uint256 randomIndex = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % members.length;
        winner = members[randomIndex];
    }

    // Fungsi untuk pemenang menarik saldo
    function withdraw() external onlyWinner {
        uint256 amount = balance;
        balance = 0;
        payable(msg.sender).transfer(amount);
    }
}