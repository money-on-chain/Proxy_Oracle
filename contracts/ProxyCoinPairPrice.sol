pragma solidity 0.5.8;

import "areopagus/contracts/Governance/Governed.sol";
import "./ICoinPairPrice.sol";


contract ProxyCoinPairPrice is Governed {
  address public coinpairprice;

  /**
    @notice Checks that _address is not zero; fails otherwise
    @param _address Address to be checked
  */
  modifier isValidAddress(address _address, string memory message) {
    require(_address != address(0), message);
    _;
  }

  function initialize(
    address _coinpairprice,
    address _governor
  )
    public
    initializer
    isValidAddress(_coinpairprice, "Coin pair price cannot be null")
    isValidAddress(_governor, "Governor cannot be null")
  {
    coinpairprice = _coinpairprice;
    Governed.initialize(_governor);
  }

  function peek() external view returns (bytes32, bool) {
    ICoinPairPrice icoinpairprice = ICoinPairPrice(coinpairprice);
    return icoinpairprice.peek();
  }

  function getLastPublicationBlock() external view returns (uint256) {
    ICoinPairPrice icoinpairprice = ICoinPairPrice(coinpairprice);
    return icoinpairprice.getLastPublicationBlock();
  }

  function setCoinPairPrice(address _newCoinPairPrice) public onlyAuthorizedChanger {
    require(_newCoinPairPrice != address(0), "Coin Pair Price cannot be null");
    coinpairprice = _newCoinPairPrice;
  }

}
