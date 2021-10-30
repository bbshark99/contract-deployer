//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IDaughterContract {
  function name() external view returns (string memory);
  function birthYear() external view returns (uint256);

  function initialize(string memory, uint256) external;
}
