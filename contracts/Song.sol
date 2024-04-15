// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Song is ERC1155, Ownable, ERC1155Supply {
    event SongMinted(uint256 tokenId);

    using Counters for Counters.Counter;
    Counters.Counter tokenId;

    constructor(address initialOwner) ERC1155("") Ownable(initialOwner) {}

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(address account, uint256 amount, bytes memory data)
        public
        onlyOwner
    {
        uint256 id = tokenId.current();
        tokenId.increment();
        _mint(account, id, amount, data);
        _setApprovalForAll(account, address(this), true);
        emit SongMinted(id);
    }

    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }

    function transfer(
        address from,
        address to,
        uint256 id,
        uint256 value,
        bytes memory data
    ) public onlyOwner {
        _safeTransferFrom(from, to, id, value, data);
    }
    

    // The following functions are overrides required by Solidity.

    function _update(address from, address to, uint256[] memory ids, uint256[] memory values)
        internal
        override(ERC1155, ERC1155Supply)
    {
        super._update(from, to, ids, values);
    }
}
