// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTWithoutOpenZeppelin is ERC721 {
    uint256[] private _allTokens;
    mapping(address => uint256[]) private _ownedTokens;

    constructor() ERC721("NFTWithoutOpenZeppelin", "NFTWOZ") {}

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
        _allTokens.push(tokenId);
        _ownedTokens[to].push(tokenId);
    }

    // Example of a naive implementation of token enumeration
    function tokenOfOwnerByIndex(
        address owner,
        uint256 index
    ) public view returns (uint256) {
        require(index < balanceOf(owner), "Owner index out of bounds");
        return _ownedTokens[owner][index];
    }

    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }
}
