// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "../lib/ds-test/src/test.sol";
import {Swap} from "./Swap.sol";
import {AddLiquidity} from "./AddLiquidity.sol";
import "./interfaces/interfaces.sol";

contract UniswapTest is DSTest {
    
    //*** GLOBAL ***
    address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address constant USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    address constant WBTC = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599;
    address constant CRV = 0xD533a949740bb3306d119CC777fa900bA034cd52;
    address constant WHALE = 0x28C6c06298d514Db089934071355E5743bf21d60;
    address FACTORY = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    Swap swapBot;
    AddLiquidity addLiquidityBot;
    //*** SWAP ***
    address constant TOKEN_IN = USDC;
    address constant TOKEN_OUT = USDT;
    uint    constant AMOUNT_IN = 100000*10**6;
    uint    constant AMOUNT_OUT_MIN = 90000*10**6;
    IERC20 tokenIn;
    IERC20 tokenOut;
    //*** ADD LIQUIDITY *** 
    address TOKEN_A = DAI;
    address TOKEN_B = CRV;
    uint AMOUNT_A = 1000*10**18;
    uint AMOUNT_B = 100*10**6;
    IERC20 tokenA;
    IERC20 tokenB;
    
    function setUp() public {
        swapBot = new Swap();
        addLiquidityBot = new AddLiquidity();
        tokenIn = IERC20(TOKEN_IN);
        tokenOut = IERC20(TOKEN_OUT);
        tokenA = IERC20(TOKEN_A);
        tokenB = IERC20(TOKEN_B);
    }

    // Should assert that this test contract is the whale 
    function test_logAddy() public {
        assertEq(address(this), WHALE);
    }

    // Should swap TOKEN_IN for TOKEN_OUT and assert that post-swap balance of TOKEN_OUT is >= AMOUNT_OUT_MIN
    function test_swap() public {
        tokenIn.approve(address(swapBot), AMOUNT_IN);
        swapBot.swap(
            TOKEN_IN, 
            TOKEN_OUT,
            AMOUNT_IN, 
            AMOUNT_OUT_MIN
            );
        uint postBalanceOut = tokenOut.balanceOf(address(swapBot));
        assertTrue(postBalanceOut >= AMOUNT_OUT_MIN);
        emit log_named_uint("balanceOut", tokenOut.balanceOf(address(swapBot)));
    }

    // Should add liquidity for TOKEN_A and TOKEN_B and assert that the balance of the pair LP is >= 0
    function test_addLiquidity() public {
        tokenA.approve(address(addLiquidityBot), AMOUNT_A);
        tokenB.approve(address(addLiquidityBot), AMOUNT_B);
        addLiquidityBot.addLiquidity(
            TOKEN_A, 
            TOKEN_B,
            AMOUNT_A, 
            AMOUNT_B
            );
        address DAICRV = IUniswapV2Factory(FACTORY).getPair(TOKEN_A, TOKEN_B);
        uint balanceLP = IERC20(DAICRV).balanceOf(address(addLiquidityBot));
        assertTrue(balanceLP >= 0);
    }

    // Should get the address of TOKEN_A/TOKEN_B pair
    function test_getPair() public {
        address DAICRV = IUniswapV2Factory(FACTORY).getPair(TOKEN_A, TOKEN_B);
        emit log_named_address("DAICRV", DAICRV);
    }
}
