pragma solidity 0.5.8;

import "openzeppelin-eth/contracts/math/SafeMath.sol";
import "openzeppelin-eth/contracts/math/Math.sol";
import "./ProxyCoinPairPrice.sol";
import "./IMocState.sol";

/*
Note: This is for V1 protocol
*/

contract ProxyCoinPairPriceBproUsdConversion is ProxyCoinPairPrice {

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
    isValidAddress(_governor, "Governor cannot be null")
  {
    coinpairprice = _coinpairprice;
    mocState = _mocState;
    Governed.initialize(_governor);
  }

  function peek() external view returns (bytes32, bool) {

    // The price from Coin Pair Price
    ICoinPairPrice icoinpairprice = ICoinPairPrice(coinpairprice);
    (bytes32 coinpairpricePrice, bool coinpairpriceIsValid) = icoinpairprice.peek();

    if (coinpairpriceIsValid && coinpairpricePrice != bytes32(0)) {
      uint256 bproUsdPrice = mocState.bproUsdPrice();
      uint256 calculatedPrice = uint256(bproUsdPrice).mul(uint256(coinpairpricePrice)).div(RATE_PRECISION);
      return (bytes32(calculatedPrice), calculatedPrice != 0);
    }
    return (0, false);
  }

}