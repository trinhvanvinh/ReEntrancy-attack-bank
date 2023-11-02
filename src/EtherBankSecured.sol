// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;
import "openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";

contract EtherBankSecured is ReentrancyGuard {
    mapping(address => uint256) public balances;
    bool internal locked;
    modifier reentrancyGuard() {
        require(!locked);
        locked = true;
        _;
        locked = false;
    }

    function depositETH() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdrawETH() public reentrancyGuard nonReentrant {
        uint256 balance = balances[msg.sender];
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(balance);
    }
}
