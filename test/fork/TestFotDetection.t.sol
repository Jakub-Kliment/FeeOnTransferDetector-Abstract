// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {TokenFees, FeeOnTransferDetector} from "../../src/FeeOnTransferDetector.sol";

contract FotDetectionTest is Test {
    FeeOnTransferDetector detector;
    address constant factoryV2 = 0x566d7510dEE58360a64C9827257cF6D0Dc43985E; // Uniswap V2 factory address
    address constant WETH = 0x3439153EB7AF838Ad19d56E1571FBD09333C2809; // WETH address on abstract

    function setUp() public {
        vm.createSelectFork(vm.envString("JSON_RPC_PROVIDER_ABSTRACT"));
        detector = new FeeOnTransferDetector(factoryV2);
    }

    function testPenguToken() public {
        address token = 0x9eBe3A824Ca958e4b3Da772D2065518F009CBa62;
        uint256 expectedBuyFeeBps = 0;
        uint256 expectedSellFeeBps = 0;

        TokenFees memory fees = detector.validate(token, WETH, 10000);
        assertEq(fees.buyFeeBps, expectedBuyFeeBps);
        assertEq(fees.sellFeeBps, expectedSellFeeBps);
    }

    function testUSDCToken() public {
        address USDC = 0x84A71ccD554Cc1b02749b35d22F684CC8ec987e1;
        uint256 expectedBuyFeeBps = 0;
        uint256 expectedSellFeeBps = 0;

        TokenFees memory fees = detector.validate(USDC, WETH, 10000);
        assertEq(fees.buyFeeBps, expectedBuyFeeBps);
        assertEq(fees.sellFeeBps, expectedSellFeeBps);
    }
}
