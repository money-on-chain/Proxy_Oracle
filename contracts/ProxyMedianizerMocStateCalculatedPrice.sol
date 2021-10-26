pragma solidity 0.5.8;

import "openzeppelin-eth/contracts/math/SafeMath.sol";
import "openzeppelin-eth/contracts/math/Math.sol";
import "./ProxyMoCMedianizer.sol";
import "./IMocState.sol";


contract ProxyMedianizerMocStateCalculatedPrice is ProxyMoCMedianizer {

  using SafeMath for uint256;
  IMocState public mocState;
  uint256 public constant RATE_PRECISION = uint256(10**18);

  function initialize(
    address _medianizer,
    address _governor,
    IMocState _mocState
  )
    public
    initializer
    isValidAddress(_medianizer, "medianizer cannot be null")
    isValidAddress(_governor, "governor cannot be null")
  {
    medianizer = _medianizer;
    mocState = _mocState;
    Governed.initialize(_governor);
  }

  function peek() external view returns (bytes32, bool) {

    // Getting Price from MoCState (MoC Os Platform)
    // MocState BtcPriceProvider is complient with IMoCMedianizer interface
    IMoCMedianizer priceMocState = IMoCMedianizer(mocState.getBtcPriceProvider());
    (bytes32 btcPrice, bool isValid) = priceMocState.peek();

    // Only if MocState BtcPriceProvider has a valid price
    if (isValid && btcPrice != bytes32(0)) {

      // The price from medianizer
      IMoCMedianizer imedianizer = IMoCMedianizer(medianizer);
      (bytes32 medianizerPrice, bool medianizerIsValid) = imedianizer.peek();

      if (medianizerIsValid && medianizerPrice != bytes32(0)) {
        uint256 calculatedPrice = uint256(btcPrice).mul(RATE_PRECISION).div(uint256(medianizerPrice));
        return (bytes32(calculatedPrice), calculatedPrice != 0);
      }

    }
    return (0, false);
  }

}