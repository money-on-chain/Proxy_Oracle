pragma solidity ^0.5.8;

interface IERC20 {
  function decimals() external view returns (uint8);

  function symbol() external view returns (string memory);
}
