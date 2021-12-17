pragma solidity ^0.5.8;

interface IPancakeFactory {
  function getPair(address tokenA, address tokenB) external view returns (address pair);
}
