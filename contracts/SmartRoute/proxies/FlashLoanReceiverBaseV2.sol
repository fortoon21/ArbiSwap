// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.15;

import { IERC20 } from "../../intf/IERC20.sol";
import { SafeERC20 } from "../../lib/SafeERC20.sol";
import { SafeMath } from "../../lib/SafeMath.sol";
import { IFlashLoanReceiverV2 } from "../intf/IFlashLoanReceiverV2.sol";
import { ILendingPoolAddressesProviderV2 } from "../intf/ILendingPoolAddressesProviderV2.sol";
import { ILendingPoolV2 } from "../intf/ILendingPoolV2.sol";
import "../../lib/Withdrawable.sol";

/**
    !!!
    Never keep funds permanently on your FlashLoanReceiverBase contract as they could be
    exposed to a 'griefing' attack, where the stored funds are used by an attacker.
    !!!
 */
abstract contract FlashLoanReceiverBaseV2 is IFlashLoanReceiverV2 {
    using SafeERC20 for IERC20;
    using SafeMath for uint256;

    ILendingPoolAddressesProviderV2 public immutable override ADDRESSES_PROVIDER;
    ILendingPoolV2 public immutable override LENDING_POOL;

    constructor(address provider) {
        ADDRESSES_PROVIDER = ILendingPoolAddressesProviderV2(provider);
        LENDING_POOL = ILendingPoolV2(ILendingPoolAddressesProviderV2(provider).getLendingPool());
    }

    receive() external payable {}
}
