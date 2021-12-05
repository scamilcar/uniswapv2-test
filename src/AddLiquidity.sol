// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "./interfaces/interfaces.sol";


contract AddLiquidity {

    address constant ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    event Log(string message, uint value);

    function addLiquidity(
        address _tokenA,
        address _tokenB,
        uint256 _amountA,
        uint256 _amountB
        ) external {
            
            IERC20(_tokenA).transferFrom(msg.sender, address(this), _amountA);
            IERC20(_tokenB).transferFrom(msg.sender, address(this), _amountB);
            IERC20(_tokenA).approve(ROUTER, _amountA);
            IERC20(_tokenB).approve(ROUTER, _amountB);

            (uint256 amountA, uint256 amountB, uint256 liquidity) =
                IUniswapV2Router01(ROUTER).addLiquidity(
                    _tokenA,
                    _tokenB,
                    _amountA,
                    _amountB,
                    1,
                    1,
                    address(this),
                    block.timestamp
                );
            emit Log("amountA", amountA);
            emit Log("amountB", amountB);
            emit Log("liquidity", liquidity);
    }
}