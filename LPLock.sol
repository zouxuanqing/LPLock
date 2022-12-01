// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
}

contract LPLock {
    address public immutable LP;
    address public immutable Owner;
    uint256 public endTime;
    
    constructor(address lp, address owner) {
        LP = lp;
        Owner = owner;
    }

    function Lock(uint256 endtime) external returns (bool) {
        require(msg.sender == Owner, 'Not owner');

        endTime = endtime;

        return true;
    }

    function Withdraw() external returns (bool) {
        require(block.timestamp >= endTime, 'Too early');
        require(msg.sender == Owner, 'Not owner');

        IERC20(LP).transfer(msg.sender, IERC20(LP).balanceOf(address(this)));

        return true;
    }
}