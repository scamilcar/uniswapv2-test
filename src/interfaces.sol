// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

interface IUniswapV2Router01 {
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);


}

interface IERC20 {
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender,address recipient,uint256 amoun) external returns (bool);
    function balanceOf(address account) external view returns (uint256);

}
