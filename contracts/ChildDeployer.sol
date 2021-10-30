//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./SonContract.sol";
import "../interfaces/IChildDeployer.sol";

contract ChildDeployer is IChildDeployer {
  struct Parameters {
    address mom;
    string name;
    uint256 birthYear;
  }

  Parameters public override parameters;

  function deploy(address mom, string memory name, uint256 birthYear) internal returns (address house) {
    parameters = Parameters({ mom: mom, name: name, birthYear: birthYear });
    house = address(new SonContract{salt: keccak256(abi.encode(mom, name, birthYear))}());
    delete parameters;
  }
}
