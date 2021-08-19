pragma solidity 0.5.8;

import "areopagus/contracts/Governance/Governed.sol";


contract ProxyDummyOracle is Governed {
  bytes32 public value;

  /**
    @notice Checks that _address is not zero; fails otherwise
    @param _address Address to be checked
  */
  modifier isValidAddress(address _address, string memory message) {
    require(_address != address(0), message);
    _;
  }

  function initialize(
    bytes32 _value,
    address _governor
  )
    public
    initializer
    isValidAddress(_governor, "governor cannot be null")
  {
    value = _value;
    Governed.initialize(_governor);
  }

  function peek() external view returns (bytes32, bool) {
    return (value, true);
  }

  function setValue(bytes32 _newValue) public onlyAuthorizedChanger {
    value = _newValue;
  }

}
