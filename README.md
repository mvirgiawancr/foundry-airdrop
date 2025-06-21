# Smart Contract VIR Coin Airdrop Collection

This is a smart contract project for creating a decentralized airdrop system using Foundry. Based on the Cyfrin Solidity Course, this project implements a Merkle tree-based airdrop distribution system where eligible addresses can claim VIR (Vir Coin) tokens through cryptographic proofs.

📌 Features

- Merkle tree-based airdrop distribution for gas-efficient claims
- VIR token (Vir Coin) with ERC-20 standard compliance
- Cryptographic signature verification for secure claims
- Multi-network deployment support (Anvil, zkSync, Sepolia)
- Comprehensive testing suite across multiple environments
- Gas-optimized contract deployment and verification
- Built with Foundry for robust Ethereum development

🚀 Getting Started

## 1. Install Requirements

Make sure you have installed:

- Git
- Foundry
- Optional: Gitpod for cloud development

## 2. Clone the Repository

```bash
git clone https://github.com/mvirgiawancr/foundry-vir-coin-airdrop.git
cd foundry-vir-coin-airdrop
forge build
```

## 3. Configure Environment Variables

Create a `.env` file based on `.env.example`, then add:

```env
SEPOLIA_RPC_URL=<your_rpc_url>
PRIVATE_KEY=<your_private_key>
ETHERSCAN_API_KEY=<your_etherscan_api_key>
ZKSYNC_SEPOLIA_RPC_URL=<your_zksync_rpc_url>
```

🔧 Usage

## 1. Start a Local Node

```bash
make anvil
```

## 2. Connect MetaMask to Anvil Local Network

To view your VIR Coin airdrop system in MetaMask while using Anvil:

Open MetaMask and add a new network with these settings:

- **Network Name**: Anvil Local
- **RPC URL**: http://127.0.0.1:8545
- **Chain ID**: 31337
- **Currency Symbol**: ETH

Import an Anvil test account to MetaMask:

1. Click on "Import Account" in MetaMask
2. Enter one of the private keys provided by Anvil when it starts (e.g., the default key: `0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d`)
3. This account should have 10,000 test ETH

After deploying contracts on your local network, you can add the VIR token to MetaMask to view your balance.

## 3. Generate Merkle Proofs

Before deployment, generate merkle proofs for eligible addresses:

```bash
# Using make
make merkle

# Or using commands directly
forge script script/GenerateInput.s.sol:GenerateInput && forge script script/MakeMerkle.s.sol:MakeMerkle
```

Update the merkle root in deployment scripts after generation.

## 4. Deploy Smart Contracts

### For local deployment:

```bash
# Deploy VIR Coin and Airdrop contracts
make deploy
```

### For testnet deployment:

```bash
make deploy ARGS="--network sepolia"
```

### For zkSync local deployment:

```bash
# Setup zkSync prerequisites first
foundryup-zksync
make zk-anvil
make deploy-zk
```

### For zkSync Sepolia deployment:

```bash
make deploy-zk-sepolia
```

## 5. Interacting with Airdrop

### Local Anvil Network:

```bash
# Sign your airdrop claim
make sign

# Claim your airdrop
make claim

# Check balance
make balance
```

### zkSync Local Network:

```bash
# Run complete interaction script
chmod +x interactZk.sh && ./interactZk.sh
```

## 6. Testing

Run various test suites:

```bash
# Local unit tests
forge test

# zkSync tests
make zktest

# Test coverage
forge coverage

# Coverage with detailed report
forge coverage --report debug
```

📊 Scripts and Utilities

## Gas Estimation

```bash
forge snapshot
```

## Code Formatting

```bash
forge fmt
```

## Static Analysis with Slither

```bash
slither . --config-file slither.config.json
```

## 7. Adding VIR Token to MetaMask

To view your VIR tokens in MetaMask:

1. Go to the "Tokens" tab in MetaMask
2. Click "Import Token"
3. Enter the following details:
   - **Token Address**: The deployed VIR contract address
   - **Token Symbol**: VIR
   - **Token Decimals**: 18

For the airdrop system, after contracts are deployed:

- The VIR token will be available for viewing in MetaMask
- You can monitor your token balance after claiming
- If using Anvil, your tokens will persist only as long as your local node is running

**Note**: When using Anvil, your contract state will persist only as long as your local node is running. Restarting Anvil will reset the blockchain state unless you've configured it to persist data.

🧩 Contract Architecture

## MerkleAirdrop

The core airdrop contract that handles:

- **Merkle Proof Verification**: Validate eligibility through cryptographic proofs
- **Claim Processing**: Secure token distribution to verified addresses
- **Signature Verification**: Additional security layer for claim validation
- **Duplicate Prevention**: Ensure addresses can only claim once

## VirCoin (VIR)

ERC-20 compliant token with features:

- Standard token functionality (transfer, approve, etc.)
- Mintable for airdrop distribution
- Burnable for token supply management
- Decimal precision of 18

Key features:

- Gas-efficient claiming through Merkle proofs
- Cryptographic signature verification for enhanced security
- Prevention of double-claiming
- Multi-network compatibility (Ethereum, zkSync)

🔗 Dependencies
This project uses the following libraries:

```bash
forge install foundry-rs/forge-std --no-commit
forge install openzeppelin/openzeppelin-contracts --no-commit
forge install dmfxyz/murky --no-commit
forge install cyfrin/foundry-devops --no-commit
```

🌐 Example Deployed Contracts
**Sepolia Testnet:**

- VIR Coin: 0x[contract_address]
- Merkle Airdrop: 0x[contract_address]

**zkSync Sepolia:**

- VIR Coin: 0x[contract_address]
- Merkle Airdrop: 0x[contract_address]

🛡️ Security Notes

- Use test funds only on testnets - never real funds for development
- Always verify contract addresses before any interactions
- Monitor gas costs when deploying and testing
- Verify merkle proofs are generated correctly
- Test thoroughly before considering mainnet deployment
- Keep private keys secure and never commit them to version control

📚 Learning Objectives
This project demonstrates:

- **Airdrop Mechanisms**: Understanding Merkle tree-based distribution
- **Smart Contract Interactions**: Multiple contract system design
- **Cryptographic Proofs**: Merkle proof generation and verification
- **Testing Strategies**: Comprehensive test suite development
- **Multi-Network Deployment**: Ethereum and zkSync compatibility

📜 License
This project is created for educational purposes and is free to use for further development.

💙 Thank You!
If you find this project helpful, don't forget to ⭐ the repository on GitHub!

Made with 💖 by Virgi

**Note**: This is an educational project based on the Cyfrin Foundry Solidity Course. Focus on learning the core concepts of DeFi, airdrop distribution mechanisms and signature verification in smart contracts using ECDSA signatures.
