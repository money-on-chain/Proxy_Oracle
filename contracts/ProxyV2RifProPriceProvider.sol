pragma solidity 0.5.8;
pragma experimental ABIEncoderV2;

import "openzeppelin-eth/contracts/math/SafeMath.sol";
import "openzeppelin-eth/contracts/math/Math.sol";

import "areopagus/contracts/Governance/Governed.sol";
import "./IPriceProvider.sol";
import "./IMoCV2.sol";


contract ProxyV2RifProPriceProvider is Governed {

  using SafeMath for uint256;
  uint256 public constant RATE_PRECISION = uint256(10**18);

  IMoCV2 public mocV2;
  address public tpAddress;

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
    IMoCV2 _mocV2,
    address _tpAddress
  )
    public
    initializer
    isValidAddress(_governor, "governor cannot be null")
    isValidAddress(_tpAddress, "tpAddress cannot be null")
  {
    mocV2 = _mocV2;
    tpAddress = _tpAddress;
    Governed.initialize(_governor);
  }

  function peek() external view returns (bytes32, bool) {

    IMoCV2.PeggedTokenIndex memory tpIndex = mocV2.peggedTokenIndex(tpAddress);

    if (!tpIndex.exists) {
      // If not exist is not a valid price
      return (0, false);
    }

    IMoCV2.PegContainerItem memory tpItem = mocV2.pegContainer(tpIndex.index);

    IPriceProvider priceProvider = IPriceProvider(tpItem.priceProvider);
    (bytes32 price, bool isValid) = priceProvider.peek();

    // Only if has a valid price
    if (isValid && price != bytes32(0)) {

      uint256 tecPrice = mocV2.getPTCac();
      if (bytes32(tecPrice) != bytes32(0)) {
        uint256 calculatedPrice = uint256(tecPrice).mul(uint256(price)).div(RATE_PRECISION);
        return (bytes32(calculatedPrice), calculatedPrice != 0);
      }
    }
    return (0, false);
  }
}