pragma solidity 0.5.8;

import "openzeppelin-eth/contracts/math/SafeMath.sol";
import "openzeppelin-eth/contracts/math/Math.sol";
import "./ProxyCoinPairPrice.sol";
import "./IMocState.sol";
import "./IMoCMedianizer.sol";

/*
Note: This is for V1 protocol
*/

contract ProxyCoinPairPriceBproUsdConversion2 is ProxyCoinPairPrice {

  using SafeMath for uint256;
  IMocState public mocState;
  uint256 public constant RATE_PRECISION = uint256(10**18);

  function initialize(
    address _coinpairprice,
    address _governor,
    IMocState _mocState
  )
    public
    initializer
    isValidAddress(_coinpairprice, "Coin Pair Price cannot be null")
    isValidAddress(_governor, "governor cannot be null")
  {
    coinpairprice = _coinpairprice;
    mocState = _mocState;
    Governed.initialize(_governor);
  }

  function peek() external view returns (bytes32, bool) {

    // The price from coin pair price
    ICoinPairPrice icoinpairprice = ICoinPairPrice(coinpairprice);
    (bytes32 coinpairpricePrice, bool coinpairpriceIsValid) = icoinpairprice.peek();

    if (coinpairpriceIsValid && coinpairpricePrice != bytes32(0)) {

      // Getting Price from MoCState (MoC Os Platform)
      // MocState BtcPriceProvider is compliant with IMoCMedianizer interface
      IMoCMedianizer priceMocState = IMoCMedianizer(mocState.getBtcPriceProvider());
      (bytes32 btcPrice, bool isValid) = priceMocState.peek();

      // Only if MocState BtcPriceProvider has a valid price
      if (isValid && btcPrice != bytes32(0)) {

        uint256 bproUsdPrice = mocState.bproUsdPrice();
        uint256 calculatedPrice = uint256(bproUsdPrice).mul(uint256(coinpairpricePrice)).div(RATE_PRECISION);
        return (bytes32(calculatedPrice), calculatedPrice != 0);

      }

    }
    return (0, false);
  }

}