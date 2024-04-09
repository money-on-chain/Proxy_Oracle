pragma solidity 0.5.8;

import "openzeppelin-eth/contracts/math/SafeMath.sol";
import "openzeppelin-eth/contracts/math/Math.sol";
import "./ProxyMoCMedianizer.sol";
import "./IMocState.sol";

/*
Note: This is for V1 protocol
*/

contract ProxyMedianizerBproUsdConversion is ProxyMoCMedianizer {

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

    // The price from medianizer
    IMoCMedianizer imedianizer = IMoCMedianizer(medianizer);
    (bytes32 medianizerPrice, bool medianizerIsValid) = imedianizer.peek();

    if (medianizerIsValid && medianizerPrice != bytes32(0)) {
      uint256 bproUsdPrice = mocState.bproUsdPrice();
      uint256 calculatedPrice = uint256(bproUsdPrice).mul(uint256(medianizerPrice)).div(RATE_PRECISION);
      return (bytes32(calculatedPrice), calculatedPrice != 0);
    }
    return (0, false);
  }

}