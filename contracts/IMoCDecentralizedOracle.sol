pragma solidity 0.5.8;

/**
 * @dev Interface of MoC Decentralized oracle
 */
interface IMoCDecentralizedOracle {
  function peek() external view returns (bytes32, bool);
}