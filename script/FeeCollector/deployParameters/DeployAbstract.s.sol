// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {DeployFeeCollector, DeployParameters} from "../DeployFeeCollector.s.sol";

contract DeployArbitrum is DeployFeeCollector {
    function setUp() public override {
        params = DeployParameters({
            owner: OWNER,
            universalRouter: UNIVERSAL_ROUTER,
            permit2: PERMIT2,
            feeToken: 0x0 // modify token
        });
    }
}
