// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TrustFund {
    // Address that deployed the contract - making it the (owner)
    address public owner;

    // Hardcoded allowed addresses 
    address public constant allowedAddress = 0x3cC92b7496571fC479EB4714784a6839CD3e57f2;

    // Mapping to track last withdrawal time per address
    mapping(address => uint256) public lastWithdrawalTime;

    // Mutex for re-entrancy protection
    bool private locked;

    // Modifier - this restrict access to only allowed addresses
    modifier onlyAllowed() {
        require(msg.sender == owner || msg.sender == allowedAddress, "Not authorised");
        _;
    }

    // Modifier - this enforces a 30-minute cooldown between withdrawals
    modifier cooldownPassed() {
        require(
            block.timestamp >= lastWithdrawalTime[msg.sender] + 30 minutes,
            "Must wait 30 minutes between withdrawals"
        );
        _;
    }

    // Modifier - this is to prevent re-entrancy attacks
    modifier noReentrant() {
        require(!locked, "Re-entrancy detected!");
        locked = true;
        _;
        locked = false;
    }

    // Constructor to set the deployer as owner
    constructor() {
        owner = msg.sender;
    }

    // Function to accept SepETH from anyone
    receive() external payable {}

    // Function to withdraw SepETH, max 1.0 per call, with both a cooldown and an access check
    function withdraw(uint256 amount) external onlyAllowed cooldownPassed noReentrant {
        require(amount <= 1 ether, "Cannot withdraw more than 1 SepETH at once");
        require(address(this).balance >= amount, "Insufficient contract balance");

        // Update withdrawal time
        lastWithdrawalTime[msg.sender] = block.timestamp;

        // Transfer SepETH
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Withdrawal failed");
    }
}
