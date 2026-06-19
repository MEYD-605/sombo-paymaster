// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Script, console} from "forge-std/Script.sol";
import {SomboPaymaster} from "../src/SomboPaymaster.sol";
import {IEntryPoint} from "account-abstraction/interfaces/IEntryPoint.sol";

contract DeployScript is Script {
    // ERC-4337 EntryPoint v0.7 on Sepolia
    address constant ENTRY_POINT = 0x0000000071727De22E5E9d8BAf0edAc6f37da032;
    // Initial deposit to EntryPoint (0.01 ETH)
    uint256 constant INITIAL_DEPOSIT = 0.01 ether;

    function run() external {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerKey);

        SomboPaymaster paymaster = new SomboPaymaster(IEntryPoint(ENTRY_POINT), msg.sender);
        console.log("SomboPaymaster deployed at:", address(paymaster));

        paymaster.depositFunds{value: INITIAL_DEPOSIT}();
        console.log("Deposited", INITIAL_DEPOSIT, "wei to EntryPoint");

        vm.stopBroadcast();
    }
}
