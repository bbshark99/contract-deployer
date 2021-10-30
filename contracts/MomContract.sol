//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./DaughterContract.sol";
import "../interfaces/IDaughterContract.sol";

contract MomContract {
  event NewChildBorn(address house, string name, uint256 year);

  address[] public children;

  constructor() {}

  function getChildrenCount() public view returns (uint256) {
    return children.length;
  }

  function born(string memory name, uint256 year) external returns (address child, uint256 childId) {
    require(year > 2000, "Invalid year");

    bytes memory bytecode = type(DaughterContract).creationCode;
    bytes32 salt = keccak256(abi.encodePacked(name, year));

    assembly {
      child := create2(0, add(bytecode, 32), mload(bytecode), salt)
    }

    IDaughterContract(child).initialize(name, year);

    childId = children.length;
    children.push(child);

    emit NewChildBorn(child, name, year);
  }
}
