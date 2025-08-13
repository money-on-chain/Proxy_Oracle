pragma solidity 0.5.8;
pragma experimental ABIEncoderV2;

import "./IPriceProvider.sol";

/**
 * @notice Interface for MocState price providers relevant methods
 */
interface IMoCV2 {

    struct PegContainerItem {
        // total supply of Pegged Token
        uint256 nTP;
        // PegToken PriceFeed address
        IPriceProvider priceProvider;
    }

    struct PeggedTokenIndex {
        // Pegged Token index
        uint256 index;
        // true if Pegged Token exists
        bool exists;
    }

    function peggedTokenIndex(address tp) external view returns (PeggedTokenIndex memory);
    function pegContainer(uint256 index) external view returns (PegContainerItem memory);

    /**
    * @dev get Collateral Token price
    * @return pTCac [PREC]
    */
    function getPTCac() external view returns(uint256);


}