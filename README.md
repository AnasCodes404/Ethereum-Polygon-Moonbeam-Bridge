# Ethereum-Polygon-Moonbeam Bridge

This project implements a bridge that allows token transfers between Ethereum, Polygon, and Moonbeam networks. The bridge smart contract locks tokens on the source chain and releases them on the destination chain, providing a simple framework for cross-chain interactions.

## Getting Started

To use and integrate this project, follow the steps outlined below.

### Prerequisites

Before starting, ensure you have the following software installed:

- **Node.js** (v14 or higher)
- **NPM** (v6 or higher)
- **Hardhat** (v2.22.0 or higher)
- **Metamask** (for managing your accounts and private keys)

### Step 1: Clone the Project

```bash
git clone https://github.com/your-repo/ethereum-polygon-moonbeam-bridge.git
cd ethereum-polygon-moonbeam-bridge
```

### Step 2: Install Dependencies

Install the required packages and dependencies by running:

```bash
npm install
```

### Step 3: Set Up Environment Variables

Create a `.env` file in the project root with the following format:

```makefile
PRIVATE_KEY=your_private_key_here
```

Replace `your_private_key_here` with your private key (without the `0x` prefix) for deploying the smart contract. Make sure to never expose this key publicly.

### Step 4: Configure Hardhat

The `hardhat.config.js` file is already set up for the Ethereum, Polygon, and Moonbeam networks. If you want to add or modify networks, update the `hardhat.config.js` file as shown below:

```javascript
require('@nomiclabs/hardhat-waffle');
require('dotenv').config();

module.exports = {
  solidity: "0.8.20",
  networks: {
    moonbeam: {
      url: "https://rpc.api.moonbeam.network",
      accounts: [process.env.PRIVATE_KEY]
    },
    ethereum: {
      url: "https://mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID",
      accounts: [process.env.PRIVATE_KEY]
    },
    polygon: {
      url: "https://polygon-rpc.com/",
      accounts: [process.env.PRIVATE_KEY]
    }
  }
};
```

Make sure to replace `YOUR_INFURA_PROJECT_ID` with your Infura project ID (you can create one at Infura).

### Step 5: Compile the Contracts

To compile the smart contract, use the following command:

```bash
npx hardhat compile
```

This will compile the `Bridge.sol` contract and store the artifacts in the `artifacts/` folder.

### Step 6: Deploy the Smart Contracts

You can deploy the `Bridge.sol` smart contract on any of the supported networks (Ethereum, Polygon, or Moonbeam) using the following command:

```bash
npx hardhat run scripts/deploy.js --network <network_name>
```

For example, to deploy on Moonbeam, use:

```bash
npx hardhat run scripts/deploy.js --network moonbeam
```

Make sure you have enough funds in your account to cover the gas fees on the selected network.

### Step 7: Verify the Deployment

Once the contract is deployed, you'll see the contract address in the terminal:

```
Deploying contracts with the account: 0xYourAccountAddress
Bridge deployed to: 0xDeployedContractAddress
```

Take note of the deployed contract address as you'll need it for interacting with the contract.

### Step 8: Interacting with the Smart Contract

You can interact with the deployed bridge smart contract via scripts or directly from a web3 interface. Here's a sample code snippet for locking tokens on the source chain:

```javascript
const { ethers } = require('hardhat');

async function lockTokens(tokenAddress, amount, destinationChain) {
  const [signer] = await ethers.getSigners();
  const bridge = await ethers.getContractAt("Bridge", "0xDeployedContractAddress", signer);

  const tx = await bridge.lockTokens(tokenAddress, amount, destinationChain);
  await tx.wait();
  console.log(`Locked ${amount} tokens on ${destinationChain}`);
}
```

### Step 9: Testing the Integration

Before deploying to the mainnet, it's a good idea to test the smart contract on the following test networks:

- **Moonbase Alpha** (Moonbeam Testnet)
- **Polygon Mumbai Testnet**
- **Ropsten or Goerli** (Ethereum Testnets)

You can switch to the desired testnet by modifying the network parameter in your deployment commands.

## Contract Overview

The `Bridge.sol` contract provides the following key functionalities:

- **Locking Tokens**: Users can lock tokens on the source chain, emitting an event for off-chain monitoring.

  ```solidity
  function lockTokens(address token, uint256 amount, string memory destinationChain) external;
  ```

- **Releasing Tokens**: The contract owner can release the equivalent tokens on the destination chain.

  ```solidity
  function releaseTokens(address token, address user, uint256 amount) external;
  ```

- **Ownership Control**: The contract includes ownership restrictions to secure release operations.

### Integrating Your Own Token

If you want to integrate a custom token with this bridge, ensure that the token follows the ERC-20 standard. You can simply pass the token's contract address as a parameter in the `lockTokens` and `releaseTokens` functions.

## Additional Notes

- **Gas Fees**: Always check the gas fees on the respective network before deploying or interacting with contracts.
- **Security**: Make sure to audit the smart contract and test it thoroughly on test networks before deploying to the mainnet.

## License

This project is licensed under the MIT License.
# Ethereum-Polygon-Moonbeam-Bridge
