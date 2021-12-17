//SPDX-License-Identifier: Unlicense
pragma solidity >=0.5.8;

interface IPancakeRouter {
  function factory() external pure returns (address);

  function getAmountsOut(uint256 amountIn, address[] calldata path) external view returns (uint256[] memory amounts);
}
