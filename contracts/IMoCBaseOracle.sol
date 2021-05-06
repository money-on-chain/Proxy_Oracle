pragma solidity 0.5.8;

/**
 * @dev Interface of MoCs Oracles
 */
interface IMoCBaseOracle {
  function peek() external view returns (bytes32, bool);
}