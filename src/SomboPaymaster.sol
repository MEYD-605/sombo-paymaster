// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {BasePaymaster} from "account-abstraction/core/BasePaymaster.sol";
import {IEntryPoint} from "account-abstraction/interfaces/IEntryPoint.sol";
import {IStakeManager} from "account-abstraction/interfaces/IStakeManager.sol";
import {PackedUserOperation} from "account-abstraction/interfaces/PackedUserOperation.sol";

/// @title SomboPaymaster
/// @notice Sponsoring paymaster — covers gas for all users (testnet demo)
/// @dev Oracle School Workshop — No.88 Sombo · Sepolia Testnet
contract SomboPaymaster is BasePaymaster {
    event GasSponsored(address indexed sender, uint256 maxCost);

    constructor(IEntryPoint _entryPoint, address _owner) BasePaymaster(_entryPoint, _owner) {}

    function _validatePaymasterUserOp(
        PackedUserOperation calldata userOp,
        bytes32, /* userOpHash */
        uint256 maxCost
    ) internal override returns (bytes memory context, uint256 validationData) {
        emit GasSponsored(userOp.sender, maxCost);
        return ("", 0); // 0 = valid, no time range restriction
    }

    function _postOp(
        PostOpMode, /* mode */
        bytes calldata, /* context */
        uint256, /* actualGasCost */
        uint256 /* actualUserOpFeePerGas */
    ) internal override {}

    /// @notice Deposit ETH to EntryPoint to fund gas sponsorship
    function depositFunds() external payable {
        IStakeManager(address(entryPoint())).depositTo{value: msg.value}(address(this));
    }

    /// @notice Withdraw deposit back to owner
    function withdrawDeposit(address payable to, uint256 amount) external onlyOwner {
        IStakeManager(address(entryPoint())).withdrawTo(to, amount);
    }
}
