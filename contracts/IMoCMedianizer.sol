pragma solidity 0.5.8;

/**
 * @dev Interface of MoC Medianizer, compatible with MOC.
 */
interface IMoCMedianizer {
  function poke() external;
  function read() external view returns (bytes32);
  function peek() external view returns (bytes32, bool);
  function compute() external view returns (bytes32, bool);
}