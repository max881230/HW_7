// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NoUseful is ERC721 {
    uint private counter = 0;

    constructor() ERC721("NoUseful NFT", "NOUSE") {}

    // EOA should call mint and safeTransferFrom first.
    function mint(address to) external {
        _safeMint(to, counter);
        counter += 1;
    }
}

contract HW_Token is ERC721 {
    uint private counter = 0;

    //1. create a ERC721 token with name = "" symbol = ""
    constructor() ERC721("Don't send NFT to me", "NONFT") {}

    //2. Have the mint function to mint a new token
    function mint(address to) external {
        // string memory uri = "https://ipfs.io/ipfs/QmQERDsJo7NGF6Et8QY6xZpDWpdTShxpHru642AczaVAGq";
        _safeMint(to, counter);
        counter += 1;
    }

    //3. The NFT image is always the same, please check the homework description.
    function tokenURI(
        uint tokenId
    ) public view virtual override returns (string memory) {
        return
            "https://ipfs.io/ipfs/QmQERDsJo7NGF6Et8QY6xZpDWpdTShxpHru642AczaVAGq";
    }
}

contract NFTReceiver is IERC721Receiver {
    HW_Token public _HW_Token;

    // constructor() {
    //     _HW_Token = new HW_Token();
    // }

    function onERC721Received(
        address,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) public virtual override returns (bytes4) {
        //1. check the msg.sender(NoUseful contract) is the same as your HW_Token contract.
        //2. if not, please transfer this token (NoUseful) back to the original owner.
        //3. and also mint your HW1 token to the original owner.
        if (msg.sender != address(_HW_Token)) {
            IERC721(msg.sender).safeTransferFrom(
                address(this),
                from,
                tokenId,
                data
            );
            _HW_Token.mint(from);
        }

        return this.onERC721Received.selector;
    }
}
