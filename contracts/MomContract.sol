//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./ChildDeployer.sol";
import "./DaughterContract.sol";
import "../interfaces/IDaughterContract.sol";

contract MomContract is ChildDeployer {
  event NewChildBorn(address house, string name, uint256 year);

  enum SEX {
    BOY,
    GIRL
  }

  address[] public children;

  function getChildrenCount() public view returns (uint256) {
    return children.length;
  }

  function bornDaughter(string memory name, uint256 year) private returns (address child) {
    bytes memory bytecode = type(DaughterContract).creationCode;
    bytes32 salt = keccak256(abi.encodePacked(name, year));

    assembly {
      child := create2(0, add(bytecode, 32), mload(bytecode), salt)
    }

    IDaughterContract(child).initialize(name, year);
  }

  function bornSon(string memory name, uint256 year) private returns (address child) {
    child = deploy(msg.sender, name, year);
  }

  function born(string memory name, uint256 year, SEX sex) external returns (address child, uint256 childId) {
    require(year > 2000, "Invalid year");

    if (sex == SEX.GIRL) {
      child = bornDaughter(name, year);
    } else {
      child = bornSon(name, year);
    }

    childId = children.length;
    children.push(child);

    emit NewChildBorn(child, name, year);
  }
}
