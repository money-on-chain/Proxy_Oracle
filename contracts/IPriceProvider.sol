pragma solidity 0.5.8;

/**
 * @notice Get price of a Token. See https://github.com/money-on-chain/OMoC-Decentralized-Oracle
 * @dev Interface of OMoC-Decentralized-Oracle, compatible with MOC.
 */
interface IPriceProvider {
  function peek() external view returns (bytes32, bool);
}