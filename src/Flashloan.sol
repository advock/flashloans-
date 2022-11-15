// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "lib/aave-v3-core/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "lib/aave-v3-core/contracts/interfaces/IPoolAddressesProvider.sol";
import "lib/aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

contract Flashloan is FlashLoanSimpleReceiverBase {
    address payable owner;

    constructor(address _addressProvider)
        FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_addressProvider))
    {
        owner = payable(msg.sender);
    }

    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external override returns (bool) {
        uint256 amountOwed = amount + premium;
        IERC20(asset).approve(address(POOL), amountOwed);

        return true;
    }

    function RequestFlashLoan(address _tokenAddress, uint256 _tokenAmount)
        public
    {
        address ReceiverAddress = address(this);
        address asset = _tokenAddress;
        uint256 amount = _tokenAmount;
        bytes memory params = " ";
        uint16 reffercalCode = 0;

        POOL.flashLoanSimple(
            ReceiverAddress,
            asset,
            amount,
            params,
            reffercalCode
        );
    }

    function getBalance(address tokenaddress) external view returns (uint256) {
        return IERC20(tokenaddress).balanceOf(address(this));
    }

    function widraw(address _tokenAddress) external {
        IERC20 token = IERC20(_tokenAddress);
        token.transfer(msg.sender, token.balanceOf(address(this)));
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "someone else ");
        _;
    }

    function Receive() external payable {}
}
//GOERLI_RPC_UR ='https://eth-goerli.g.alchemy.com/v2/kH74ovyVPFoFpi-ddofXYKhlVow_uy_S'
//PRIVATE_KEY = "7d39503c40b2a4490044ff4730381592c953a6560d23b3c39e507f29ed81304f"
//
