# TrustFund-SmartContract
A solidity smart contract simulating a trust fund on the Ethereum Sepolia testnet

This project simulates a secure Ethereum smart contract that acts as a trust fund.

## Features
- Accepts SepETH from any address.
- Allows withdrawals only by two authorized addresses.
- Requires a **30-minute interval** between successive withdrawals. (per user not globally) 
- Designed to be **reentrancy-attack resistant**.

## Testnet Deployment
- **Network:** Ethereum Sepolia Testnet
- **Transaction Hash:** [0xaa08c2...8d5c3ac](https://sepolia.etherscan.io/tx/0xaa08c218be0ba9ef8d76431ffc422bced9c755695cdb3dd89da9de39a8d5c3ac)

## Files
- `TrustFund.sol`: Smart contract source code
- `transaction hash.txt`: Deployment verification

## Tech Stack
- Solidity - For Contract Development 
- Remix IDE - For writing the smart contract & deployment
- MetaMask - Enabled wallet integration for Seploia testnet
