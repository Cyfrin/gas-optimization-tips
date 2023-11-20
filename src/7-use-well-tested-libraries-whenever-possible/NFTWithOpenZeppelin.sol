// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract NFTWithOpenZeppelin is ERC721Enumerable {
    constructor() ERC721("NFTWithOpenZeppelin", "NFTOZ") {}

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }
}
