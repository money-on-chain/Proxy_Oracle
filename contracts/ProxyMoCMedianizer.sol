pragma solidity 0.5.8;

import "areopagus/contracts/Governance/Governed.sol";
import "./IMoCMedianizer.sol";


contract ProxyMoCMedianizer is Governed {
  address public medianizer;

  /**
    @notice Checks that _address is not zero; fails otherwise
    @param _address Address to be checked
  */
  modifier isValidAddress(address _address, string memory message) {
    require(_address != address(0), message);
    _;
  }

  function initialize(
    address _medianizer,
    address _governor
  )
    public
    initializer
    isValidAddress(_medianizer, "medianizer cannot be null")
    isValidAddress(_governor, "governor cannot be null")
  {
    medianizer = _medianizer;
    Governed.initialize(_governor);
  }

  function peek() external view returns (bytes32, bool) {
    IMoCMedianizer imedianizer = IMoCMedianizer(medianizer);
    return imedianizer.peek();
  }

  function setMedianizer(address _newMedianizer) public onlyAuthorizedChanger {
    require(_newMedianizer != address(0), "Medianizer cannot be null");
    medianizer = _newMedianizer;
  }

}
