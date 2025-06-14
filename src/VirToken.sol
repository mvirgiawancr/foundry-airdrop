// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title VirToken
 * @author mvirgiawancr
 * @notice This contract implements a simple ERC20 token named VirToken.
 * @notice This token will be airdropped to users who have participated in the Merkle Airdrop.
 */
contract VirToken is ERC20, Ownable {
    constructor() ERC20("VirToken", "VIR") Ownable(msg.sender) {}
}
