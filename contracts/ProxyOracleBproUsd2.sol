pragma solidity 0.5.8;

import "areopagus/contracts/Governance/Governed.sol";
import "./IMocState.sol";
import "./IMoCMedianizer.sol";


contract ProxyOracleBproUsd2 is Governed {

  IMocState public mocState;

  /**
    @notice Checks that _address is not zero; fails otherwise
    @param _address Address to be checked
  */
  modifier isValidAddress(address _address, string memory message) {
    require(_address != address(0), message);
    _;
  }

  function initialize(
    address _governor,
    IMocState _mocState
  )
    public
    initializer
    isValidAddress(_governor, "governor cannot be null")
  {
    mocState = _mocState;
    Governed.initialize(_governor);
  }

  function peek() external view returns (bytes32, bool) {

    // Getting Price from MoCState (MoC Os Platform)
    // MocState BtcPriceProvider is compliant with IMoCMedianizer interface
    IMoCMedianizer priceMocState = IMoCMedianizer(mocState.getBtcPriceProvider());
    (bytes32 btcPrice, bool isValid) = priceMocState.peek();

    // Only if MocState BtcPriceProvider has a valid price
    if (isValid && btcPrice != bytes32(0)) {

      uint256 bproUsdPrice = mocState.bproUsdPrice();
      if (bytes32(bproUsdPrice) != bytes32(0)) {
        return (bytes32(bproUsdPrice), bproUsdPrice != 0);
      }

    }

    return (0, false);
  }

}