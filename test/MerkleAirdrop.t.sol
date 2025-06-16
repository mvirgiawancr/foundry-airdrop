// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {VirToken} from "../src/VirToken.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ZkSyncChainChecker} from "foundry-devops/src/ZkSyncChainChecker.sol";
import {DeployMerkleAirdrop} from "../script/DeployMerkleAirdrop.s.sol";

contract MerkleAirdropTest is ZkSyncChainChecker, Test {
    MerkleAirdrop private merkleAirdrop;
    VirToken private token;

    uint256 private constant AMOUNT_TO_CLAIM = 25e18;
    uint256 private constant AMOUNT_TO_MINT = AMOUNT_TO_CLAIM * 4;
    bytes32 private constant MERKLE_ROOT = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;

    bytes32 proofOne = 0x0fd7c981d39bece61f7499702bf59b3114a90e66b51ba2c53abdf7b62986c00a;
    bytes32 proofTwo = 0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576;
    bytes32[] proof = [proofOne, proofTwo];
    address private user;
    uint256 private userPrivateKey;
    address private gasPayer;

    function setUp() public {
        if (!isZkSyncChain()) {
            DeployMerkleAirdrop deployer = new DeployMerkleAirdrop();
            (merkleAirdrop, token) = deployer.run();
        } else {
            token = new VirToken();
            merkleAirdrop = new MerkleAirdrop(MERKLE_ROOT, token);
            token.mint(token.owner(), AMOUNT_TO_MINT);
            token.transfer(address(merkleAirdrop), AMOUNT_TO_MINT);
        }

        (user, userPrivateKey) = makeAddrAndKey("user");
        gasPayer = makeAddr("gasPayer");
    }

    function testClaimAirdrop() public {
        uint256 initialBalance = token.balanceOf(user);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(userPrivateKey, merkleAirdrop.getMessage(user, AMOUNT_TO_CLAIM));

        vm.prank(gasPayer);
        merkleAirdrop.claim(user, AMOUNT_TO_CLAIM, proof, v, r, s);
        uint256 finalBalance = token.balanceOf(user);

        assertEq(finalBalance - initialBalance, AMOUNT_TO_CLAIM);
    }
}
