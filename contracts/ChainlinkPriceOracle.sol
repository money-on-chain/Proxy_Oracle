pragma solidity 0.5.8;

import "areopagus/contracts/Governance/Governed.sol";
// import "./IMoCMedianizer.sol";
import "./AggregatorV3Interface.sol";

contract ChainlinkPriceOracle is Governed {
  /**
    @notice Checks that _address is not zero; fails otherwise
    @param _address Address to be checked
  */
  modifier isValidAddress(address _address, string memory message) {
    require(_address != address(0), message);
    _;
  }

  // -------------------------------
  AggregatorV3Interface public dataFeed;
  uint256 validPricePeriod;

  /**
    @param _governor address of the governor
    @param _dataFeed Address of dataFeed (a.k.a. Chainlink Aggregator / Pair price provider)
    @param _validPricePeriod Amount of seconds the price is still valid after publication in the dataFeed
   */
  function initialize(
    address _governor,
    address _dataFeed,
    uint256 _validPricePeriod
  ) public initializer
    isValidAddress(_governor, "governor cannot be null")
    isValidAddress(_dataFeed, "dataFeed cannot be null")
  {
    require(_validPricePeriod > 0, "validPricePeriod cannot be zero");
    Governed.initialize(_governor);
    dataFeed = AggregatorV3Interface(_dataFeed);
    validPricePeriod = _validPricePeriod;
  }

  // ************************************
  // *** --- Restricted functions --- ***
  // ************************************

  function setDataFeed(address newDataFeed) external onlyAuthorizedChanger {
    dataFeed = AggregatorV3Interface(newDataFeed);
  }

  // *********************
  // *** --- Utils --- ***
  // *********************

  /** @notice returns decimals of the specific pair */
  function getDecimals() external view returns (uint8) {
    return dataFeed.decimals();
  }

/** @notice returns description of the specific pair (tokenA/tokenB)*/
  function getDescription() external view returns (string memory) {
    return dataFeed.description();
  }

  // *************************
  // *** --- Internals --- ***
  // *************************

  function _isValidPrice(uint256 timestamp) private view returns (bool) {
    require(block.timestamp >= timestamp, "Price timestamp cannot be greater than block timestamp");
    return (block.timestamp - timestamp) < validPricePeriod;
  }

  // ********************************************
  // *** --- PriceProvider Implementation --- ***
  // ********************************************

  /**
  @notice Query the current detaFeed price 
  @return price: Price of 1 unit of token0 expressed in token1.
  @return isValid: If price was published in the accepted time window.
   */
  function peek()
    external
    view
    returns (
      bytes32 price,
      bool isValid
    )
  {
    (, int256 answer, , uint256 timestamp, ) = dataFeed.latestRoundData();

    return (bytes32(answer), _isValidPrice(timestamp));
  }
}
