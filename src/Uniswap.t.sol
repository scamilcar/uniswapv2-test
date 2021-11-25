// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./Uniswap.sol";

contract UniswapTest is DSTest {
    Uniswap uniswap;

    function setUp() public {
        uniswap = new Uniswap();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
