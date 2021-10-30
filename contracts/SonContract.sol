//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "../interfaces/IChildDeployer.sol";

contract SonContract {
  string public name;
  uint256 public birthYear;

  address public mom;

  constructor() {
    (address _mom, string memory _name, uint256 _birthYear) = IChildDeployer(msg.sender).parameters();

    mom = _mom;
    name = _name;
    birthYear = _birthYear;
  }
}
