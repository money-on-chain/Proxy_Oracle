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
  address[] public path; 

  /**
    @param _governor address of the governor
    @param _pancakeRouter address of Pancake Router
    @param _path path of token addresses 
   */
  function initialize(
    address _governor,
    address _pancakeRouter,
    address [] memory _path
  ) public initializer
    isValidAddress(_governor, "governor cannot be null")
    isValidAddress(_pancakeRouter, "pancake router cannot be null")
  {
    Governed.initialize(_governor);
    pancakeRouter = IPancakeRouter(_pancakeRouter);
    _setPath(_path);
  }

  // ************************************
  // *** --- Restricted functions --- ***
  // ************************************

  function setPath(address [] memory _path) public onlyAuthorizedChanger {
    _setPath(_path);
  }

  // *********************
  // *** --- Utils --- ***
  // *********************

  /**
    @dev Returns decimals of token0 / token1
  */
  function getPairDecimals() public view returns (uint8[] memory decimals ) {
      uint x;
      decimals = new uint8[](path.length);
      for(x=0; x<path.length; x++) {
        decimals[0] = IERC20(path[x]).decimals();
      }
  }

  // *************************
  // *** --- Internals --- ***
  // *************************

  /**
    @notice set Pancake pair to query price after checking existance and liquidity
  */
  function _setPath(address [] memory newPath) private {
      uint x;
      path = new address[](newPath.length);

      path[0]=newPath[0];
      require(_getTokenDecimals(newPath[0]) == 18, "Tokens must have 18 decimals");

      for(x=1; x<newPath.length; x++) {
	path[x]=newPath[x];
        require( _getPairAddress(path[x-1], path[x])!=address(0), "PancakePriceOracle: No pair in pancake for this tokens");
        require(_getTokenDecimals(newPath[x]) == 18, "Tokens must have 18 decimals");
      }
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
    price = bytes32(amounts[path.length-1]);
    isValid = true;
  }
}
