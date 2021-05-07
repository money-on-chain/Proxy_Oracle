pragma solidity 0.5.8;

import "areopagus/contracts/Governance/ChangeContract.sol";

import "./ProxyMoCMedianizer.sol";


/**
  @notice Changer to change the medianizer of the contract
 */
contract ChangerMedianizer is ChangeContract {
  ProxyMoCMedianizer public proxyMedianizer;
  address public medianizer;

  /**
    @notice Initialize the changer.
    @param _proxyMedianizer Address of the proxyMedianizer to change
    @param _medianizer New medianizer
   */
  constructor(ProxyMoCMedianizer _proxyMedianizer, address _medianizer) public {
    proxyMedianizer = _proxyMedianizer;
    medianizer = _medianizer;
  }

  /**
    @notice Function intended to be called by the governor when ready to run
  */
  function execute() external {
    proxyMedianizer.setMedianizer(medianizer);
  }
}
