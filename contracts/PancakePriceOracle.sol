pragma solidity 0.5.8;

import "areopagus/contracts/Governance/Governed.sol";
import "./IMoCMedianizer.sol";

import "./IPancakeRouter.sol";
import "./IPancakeFactory.sol";
import "./IERC20.sol";


contract PancakePriceOracle is Governed {
  /**
    @notice Checks that _address is not zero; fails otherwise
    @param _address Address to be checked
  */
  modifier isValidAddress(address _address, string memory message) {
    require(_address != address(0), message);
    _;
  }


  // -------------------------------
  IPancakeRouter public pancakeRouter;
  address[] public path; // = new address[](2);

  /**
    @param _governor address of the governor
    @param _pancakeRouter address of Pancake Router
    @param token0 address of token 0 (pair: token0 / token1)
    @param token1 address of token 1 (pair: token0 / token1)
   */
  function initialize(
    address _governor,
    address _pancakeRouter,
    address token0,
    address token1
  ) public initializer
    isValidAddress(_governor, "governor cannot be null")
    isValidAddress(_pancakeRouter, "pancake router cannot be null")
    isValidAddress(token0, "token0 cannot be null")
    isValidAddress(token1, "token1 cannot be null")
  {
    Governed.initialize(_governor);
    pancakeRouter = IPancakeRouter(_pancakeRouter);
    path = new address[](2);
    _setPair(token0, token1);
  }

  // ************************************
  // *** --- Restricted functions --- ***
  // ************************************

  // *** Faltan ACCESS CONTROLS ****
  function setPair(address newToken0, address newToken1) public onlyAuthorizedChanger {
    _setPair(newToken0, newToken1);
  }

  // *********************
  // *** --- Utils --- ***
  // *********************

  /**
    @dev Returns decimals of token0 / token1
  */
  function getPairDecimals() public view returns (uint8 token0decimals, uint8 token1decimals) {
    token0decimals = IERC20(path[0]).decimals();
    token1decimals = IERC20(path[1]).decimals();
  }

  // *************************
  // *** --- Internals --- ***
  // *************************

  /**
    @notice set Pancake pair to query price after checking existance and liquidity
  */
  function _setPair(address token0, address token1) private {
    // Check tokens
    require(token0 != address(0) && token1 != address(0), "Pair: token address (0) not allowed");
    require(_getTokenDecimals(token0) == 18, "Pair: Token0 must have 18 decimals");
    require(_getTokenDecimals(token1) == 18, "Pair: Token1 must have 18 decimals");

    // Check pair existance
    address pairAddress = _getPairAddress(token0, token1);
    require(pairAddress != address(0), "Pair: Not created yet");

    path[0] = token0;
    path[1] = token1;
  }

  function _getPairAddress(address token0, address token1) private view returns (address) {
    IPancakeFactory pancakeFactory = IPancakeFactory(_getFactoryAddress());
    return pancakeFactory.getPair(token0, token1);
  }

  function _getFactoryAddress() private view returns (address) {
    return pancakeRouter.factory();
  }

  function _getTokenDecimals(address token) private view returns (uint8) {
    return IERC20(token).decimals();
  }

  // ********************************************
  // *** --- PriceProvider Implementation --- ***
  // ********************************************

  /**
  @notice Query the current price of path[0]/path[1] on Pancakeswap
  @return price = Price of 1 unit of token0 expressed in token1.
  @return isValid = Returns true or false if reserves are less than minimumReserves.
   */
  function peek() external view returns (bytes32 price, bool isValid) {
    uint256[] memory amounts = pancakeRouter.getAmountsOut(1 ether, path);
    price = bytes32(amounts[1]);
    isValid = true;
  }
}
