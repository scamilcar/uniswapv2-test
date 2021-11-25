// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "../lib/ds-test/src/test.sol";
import "./Uniswap.sol";
import {IERC20} from "./interfaces.sol";

contract UniswapTest is DSTest {

    address constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address constant WBTC = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599;
    uint    constant AMOUNT_IN = 1000000*10**18;
    uint    constant AMOUNT_OUT_MIN = 1;
    address constant TOKEN_IN = DAI;
    address constant TOKEN_OUT = WBTC;
    address DESTINATION = address(this);

    Uniswap uniswap;
    IERC20 tokenIn;
    IERC20 tokenOut;

    function setUp() public {
        uniswap = new Uniswap();
        tokenIn = IERC20(TOKEN_IN);
        tokenOut = IERC20(TOKEN_OUT);
    }

    function test_logAddy() public {
        emit log_named_address("addy", address(this));
    }

    function test_balanceOf() public {
        uint balance = tokenIn.balanceOf(address(this));
        emit log_named_uint("balance", balance);
    }

    /*function test_swap() public {
        tokenIn.approve(address(uniswap), AMOUNT_IN);
        uniswap.swap(
            TOKEN_IN, 
            TOKEN_OUT,
            AMOUNT_IN, 
            AMOUNT_OUT_MIN, 
            DESTINATION);
    }*/
}
