
/*
          _____           _______                   _____                    _____                                                                                                            _____            _____                    _____                    _____          
         /\    \         /::\    \                 /\    \                  /\    \                                                 ______                                                   /\    \          /\    \                  /\    \                  /\    \         
        /::\____\       /::::\    \               /::\____\                /::\    \                                               |::|   |                                                 /::\____\        /::\    \                /::\    \                /::\    \        
       /:::/    /      /::::::\    \             /:::/    /               /::::\    \                                              |::|   |                                                /:::/    /        \:::\    \              /::::\    \              /::::\    \       
      /:::/    /      /::::::::\    \           /:::/    /               /::::::\    \                                             |::|   |                                               /:::/    /          \:::\    \            /::::::\    \            /::::::\    \      
     /:::/    /      /:::/~~\:::\    \         /:::/    /               /:::/\:::\    \                                            |::|   |                                              /:::/    /            \:::\    \          /:::/\:::\    \          /:::/\:::\    \     
    /:::/    /      /:::/    \:::\    \       /:::/____/               /:::/__\:::\    \                                           |::|   |                                             /:::/    /              \:::\    \        /:::/__\:::\    \        /:::/__\:::\    \    
   /:::/    /      /:::/    / \:::\    \      |::|    |               /::::\   \:::\    \                                          |::|   |                                            /:::/    /               /::::\    \      /::::\   \:::\    \      /::::\   \:::\    \   
  /:::/    /      /:::/____/   \:::\____\     |::|    |     _____    /::::::\   \:::\    \                                         |::|   |                                           /:::/    /       ____    /::::::\    \    /::::::\   \:::\    \    /::::::\   \:::\    \  
 /:::/    /      |:::|    |     |:::|    |    |::|    |    /\    \  /:::/\:::\   \:::\    \                                  ______|::|___|___ ____                                  /:::/    /       /\   \  /:::/\:::\    \  /:::/\:::\   \:::\    \  /:::/\:::\   \:::\    \ 
/:::/____/       |:::|____|     |:::|    |    |::|    |   /::\____\/:::/__\:::\   \:::\____\                                |:::::::::::::::::|    |                                /:::/____/       /::\   \/:::/  \:::\____\/:::/  \:::\   \:::\____\/:::/__\:::\   \:::\____\
\:::\    \        \:::\    \   /:::/    /     |::|    |  /:::/    /\:::\   \:::\   \::/    /                                |:::::::::::::::::|____|                                \:::\    \       \:::\  /:::/    \::/    /\::/    \:::\   \::/    /\:::\   \:::\   \::/    /
 \:::\    \        \:::\    \ /:::/    /      |::|    | /:::/    /  \:::\   \:::\   \/____/                                  ~~~~~~|::|~~~|~~~                                       \:::\    \       \:::\/:::/    / \/____/  \/____/ \:::\   \/____/  \:::\   \:::\   \/____/ 
  \:::\    \        \:::\    /:::/    /       |::|____|/:::/    /    \:::\   \:::\    \                                            |::|   |                                           \:::\    \       \::::::/    /                    \:::\    \       \:::\   \:::\    \     
   \:::\    \        \:::\__/:::/    /        |:::::::::::/    /      \:::\   \:::\____\                                           |::|   |                                            \:::\    \       \::::/____/                      \:::\____\       \:::\   \:::\____\    
    \:::\    \        \::::::::/    /         \::::::::::/____/        \:::\   \::/    /                                           |::|   |                                             \:::\    \       \:::\    \                       \::/    /        \:::\   \::/    /    
     \:::\    \        \::::::/    /           ~~~~~~~~~~               \:::\   \/____/                                            |::|   |                                              \:::\    \       \:::\    \                       \/____/          \:::\   \/____/     
      \:::\    \        \::::/    /                                      \:::\    \                                                |::|   |                                               \:::\    \       \:::\    \                                        \:::\    \         
       \:::\____\        \::/____/                                        \:::\____\                                               |::|   |                                                \:::\____\       \:::\____\                                        \:::\____\        
        \::/    /         ~~                                               \::/    /                                               |::|___|                                                 \::/    /        \::/    /                                         \::/    /        
         \/____/                                                            \/____/                                                 ~~                                                       \/____/          \/____/                                           \/____/         
                                                                                                                                                                                                                                                                                
*/
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./ERC721A.sol";

contract LxL is Ownable, ERC721A {
    using Strings for uint256;

    // attributes for different generations
    mapping (uint256 => string) private tokenURIOf;

    constructor() ERC721A("LxL", "LxL", 10000) {} 

    /*------------------------------- views -------------------------------*/

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721A)
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        return tokenURIOf[tokenId];
    }

    /*------------------------------- writes -------------------------------*/

    function mint(string memory tokenUri)
        public
        onlyOwner
    {
        tokenURIOf[totalSupply()] = tokenUri;
        _safeMint(msg.sender, 1);

        emit Mint();
    }

    /*------------------------------- events -------------------------------*/
    
    event Mint();
}
