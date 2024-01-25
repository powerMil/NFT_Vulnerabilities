// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTVictim is ERC721, Ownable {
    uint256 private _nextTokenId;
    uint8 public maxSupply = 50;

    mapping(address => bool) public claimed;

    constructor()
        ERC721("NFTToken", "NFT")
        Ownable(msg.sender)
    {}

    function safeMint(address to) public {
        // Checks
        require(_nextTokenId < maxSupply, "not enough funds!");
        require(!claimed[msg.sender], "token claimed!");

        uint256 tokenId = _nextTokenId;
        require(tokenId <= maxSupply, "Max supply reached!");
        _nextTokenId++;

        // Effect 
        claimed[msg.sender] = true;

        // Interaction
        _safeMint(to, tokenId);
        
    }
}