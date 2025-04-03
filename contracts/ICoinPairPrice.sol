pragma solidity 0.5.8;

/**
 * @notice Get price of a Token. See https://github.com/money-on-chain/OMoC-Decentralized-Oracle
 * @dev Interface of OMoC-Decentralized-Oracle, compatible with MOC.
 */
interface ICoinPairPrice {
    /**
     * @notice returns the given `price` for the asset if `valid`
     * @return price assetPrice
     * @return valid true if the price is valid
     */
    function peek() external view returns (bytes32 price, bool valid);

    /**
     * @notice returns the last publication block of an asset price
     * @dev only valid for decentralized oracles
     * @return lastPublicationBlock
     */
    function getLastPublicationBlock() external view returns (uint256 lastPublicationBlock);
}