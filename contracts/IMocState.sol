pragma solidity 0.5.8;

/**
 * @notice Interface for MocState price providers relevant methods
 */
interface IMocState {

  /**
  * @dev BPro USD PRICE
  * @return the BPro USD Price [using mocPrecision]
  */
  function bproUsdPrice() external view returns(uint256);

  /**
  * @dev BTC price of BPro
  * @return the BPro Tec Price [using reservePrecision]
  */
  function bproTecPrice() external view returns(uint256);

  /**
  * @dev Gets the BTCPriceProviderAddress
  * @return btcPriceProvider blocks there are in a day
  **/
  function getBtcPriceProvider() external view returns(address);
}