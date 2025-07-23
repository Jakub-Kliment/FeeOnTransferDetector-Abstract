// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;



library UniswapV2Library {
    // returns sorted token addresses, used to handle return values from pairs sorted in this order
    function sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
        require(tokenA != tokenB, "UniswapV2Library: IDENTICAL_ADDRESSES");
        (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), "UniswapV2Library: ZERO_ADDRESS");
    }

    // calculates the CREATE2 address for a pair without making any external calls
    // ZKEVM init hash code is computed differently than EVM using CREATE2
    function pairFor(address factory, address tokenA, address tokenB) internal pure returns (address pair) {
        (address token0, address token1) = sortTokens(tokenA, tokenB);

        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        bytes32 initCodeHash = hex"0100065f2f2a556816a482652f101ddda2947216a5720dd91a79c61709cbf2b8"; // abstract init code hash for uni v2
        bytes32 ctorHash = keccak256("");

        bytes32 hash = keccak256(abi.encodePacked(
            keccak256("zksyncCreate2"),
            bytes32(uint256(uint160(factory))),
            salt,
            initCodeHash,
            ctorHash
        ));

        pair = address(uint160(uint256(hash)));
    }
}
