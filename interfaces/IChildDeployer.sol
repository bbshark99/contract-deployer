//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IChildDeployer {
  function parameters() external view returns (
    address mom,
    string memory name,
    uint256 birthYear
  );
}