//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IMomContract {
  event NewChildBorn(address, string, uint256);

  function children(uint256) external view returns(uint256);
  function getChildrenCount() external view returns(uint256);
}
