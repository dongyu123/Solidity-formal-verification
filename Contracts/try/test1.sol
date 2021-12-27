pragma solidity ^0.5.0;

/// @notice invariant _approve ==> transferFrom
contract ERC721 {
    mapping(uint256 => address) private _tokenApprovals;
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    mapping(address => uint256) private _balances;
    mapping(uint256 => address) private _owners;

    function _approve(address to, uint256 tokenId) internal virtual {
        _tokenApprovals[tokenId] = to;
    }
    // postcondition: _tokenApprovals[tokenId#26] = to#24 

    // precondition: _tokenApprovals[tokenId#47] = to#45
    /// @notice precondition _tokenApprovals[tokenId] == to
    function transferFrom(address from, address to, uint256 tokenId) public virtual {
        //solhint-disable-next-line max-line-length
        require(_tokenApprovals[tokenId] == to);

        _transfer(from, to, tokenId);
    }


    function _transfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {
        // Clear approvals from the previous owner
        _approve(address(0), tokenId);

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

    }
    function test(address from, address to, uint256 tokenId) public {
        _approve(to, tokenId);
        transferFrom(from, to, tokenId);

    }


}