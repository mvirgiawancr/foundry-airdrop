// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {VirToken} from "../src/VirToken.sol";

contract DeployMerkleAirdrop is Script {
    bytes32 public constant merkleRoot = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 public AMOUNT_TO_TRANSFER = 4 * 25e18;

    function deployMerkleAirdrop() public returns (MerkleAirdrop, VirToken) {
        vm.startBroadcast();

        VirToken virToken = new VirToken();
        MerkleAirdrop merkleAirdrop = new MerkleAirdrop(merkleRoot, virToken);
        virToken.mint(virToken.owner(), AMOUNT_TO_TRANSFER);
        virToken.transfer(address(merkleAirdrop), AMOUNT_TO_TRANSFER);

        vm.stopBroadcast();

        return (merkleAirdrop, virToken);
    }

    function run() external returns (MerkleAirdrop, VirToken) {
        return deployMerkleAirdrop();
    }
}
