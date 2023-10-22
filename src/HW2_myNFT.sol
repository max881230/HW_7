// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract myNFT is ERC721 {
    mapping(uint => bool) tokenActivated;

    uint256 public total_supply = 500;
    uint256 private counter = 0;
    uint256 private activationTime;

    constructor() ERC721("myNFT", "MNFT") {
        activationTime = block.number + 30;
    }

    function mint(address to) external {
        tokenActivated[counter] = false;
        require(counter < 500, "number of NFTs has reached the total supply");
        _safeMint(to, counter);
        counter += 1;
    }

    function activateNFT(uint tokenId) external {
        require(
            block.number > activationTime,
            "you can't activate the NFT before activation time"
        );
        tokenActivated[tokenId] = true;
    }

    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        if (tokenActivated[tokenId] == false) {
            // mystery.json
            return
                "https://ipfs.io/ipfs/QmdeubcosWCsUkDSWSPohdKyDRTZZYxZBX61k6597qJRgv";
        } else {
            // halloween.json
            return
                "https://ipfs.io/ipfs/QmRQ6Cc9dv6Nk3efw17PtM3z3uu6fjv8z6EguBw2naXWzg";
        }
    }
}
