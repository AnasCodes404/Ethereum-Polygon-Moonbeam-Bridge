// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Bridge {
    address public owner;

    // Event emitted when tokens are locked
    event TokensLocked(address indexed user, uint256 amount, string destinationChain);

    // Event emitted when tokens are released
    event TokensReleased(address indexed user, uint256 amount);

    constructor() {
        owner = msg.sender; // Set the contract deployer as the owner
    }

    // Function to lock tokens on the source chain
    function lockTokens(address token, uint256 amount, string memory destinationChain) external {
        require(amount > 0, "Amount must be greater than zero");
        require(IERC20(token).balanceOf(msg.sender) >= amount, "Insufficient balance");
        require(IERC20(token).allowance(msg.sender, address(this)) >= amount, "Allowance not set");

        // Transfer tokens from the user to the bridge contract
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        emit TokensLocked(msg.sender, amount, destinationChain);
    }

    // Function to release tokens on the destination chain
    function releaseTokens(address token, address user, uint256 amount) external {
        require(msg.sender == owner, "Only owner can release tokens");
        require(IERC20(token).balanceOf(address(this)) >= amount, "Insufficient balance in contract");

        // Transfer tokens from the bridge contract to the user
        IERC20(token).transfer(user, amount);
        emit TokensReleased(user, amount);
    }
}
