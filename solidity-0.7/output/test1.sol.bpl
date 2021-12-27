// Global declarations and definitions
type address_t = int;
var __balance: [address_t]int;
var __block_number: int;
var __block_timestamp: int;
var __alloc_counter: int;
// 
// ------- Source: /home/dy/formal-verify/Contracts/try/test1.sol -------
// Pragma: solidity^0.5.0
// 
// ------- Contract: ERC721 -------
// Contract invariant: _approve ==> transferFrom
// 
// State variable: _tokenApprovals: mapping(uint256 => address)
var {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 5, 5} {:message "_tokenApprovals"} _tokenApprovals#6: [address_t][int]address_t;
// 
// State variable: _operatorApprovals: mapping(address => mapping(address => bool))
var {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 6, 5} {:message "_operatorApprovals"} _operatorApprovals#12: [address_t][address_t][address_t]bool;
// 
// State variable: _balances: mapping(address => uint256)
var {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 7, 5} {:message "_balances"} _balances#16: [address_t][address_t]int;
// 
// State variable: _owners: mapping(uint256 => address)
var {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 8, 5} {:message "_owners"} _owners#20: [address_t][int]address_t;
var tokenId: int;
var to: address_t;
// 
// Function: _approve : function (address,uint256)
procedure {:inline 1} {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 10, 5} {:message "ERC721::_approve"} _approve#34(__this: address_t, __msg_sender: address_t, __msg_value: int, to#22: address_t, tokenId#24: int)
	ensures {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 10, 5} {:message "Postcondition '(_tokenApprovals#6[__this][tokenId] == to#22)' might not hold at end of function."} (_tokenApprovals#6[__this][tokenId] == to#22);

{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	_tokenApprovals#6 := _tokenApprovals#6[__this := _tokenApprovals#6[__this][tokenId#24 := to#22]];
	$return0:
	// Function body ends here
}

// 
// Function: transferFrom : function (address,address,uint256)
procedure {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 17, 5} {:message "ERC721::transferFrom"} transferFrom#59(__this: address_t, __msg_sender: address_t, __msg_value: int, from#37: address_t, to#39: address_t, tokenId#41: int)
	requires {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 17, 5} {:message "Precondition '_tokenApprovals[tokenId] == to' might not hold when entering function."} (_tokenApprovals#6[__this][tokenId#41] == to#39);

{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	assume (_tokenApprovals#6[__this][tokenId#41] == to#39);
	assume {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 21, 9} {:message ""} true;
	call _transfer#95(__this, __msg_sender, __msg_value, from#37, to#39, tokenId#41);
	$return1:
	// Function body ends here
}

// 
// Function: _transfer : function (address,address,uint256)
procedure {:inline 1} {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 25, 5} {:message "ERC721::_transfer"} _transfer#95(__this: address_t, __msg_sender: address_t, __msg_value: int, from#61: address_t, to#63: address_t, tokenId#65: int)
{
	var call_arg#0: address_t;
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	call_arg#0 := 0;
	assume {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 31, 9} {:message ""} true;
	call _approve#34(__this, __msg_sender, __msg_value, call_arg#0, tokenId#65);
	_balances#16 := _balances#16[__this := _balances#16[__this][from#61 := (_balances#16[__this][from#61] - 1)]];
	_balances#16 := _balances#16[__this := _balances#16[__this][to#63 := (_balances#16[__this][to#63] + 1)]];
	_owners#20 := _owners#20[__this := _owners#20[__this][tokenId#65 := to#63]];
	$return2:
	// Function body ends here
}

// 
// Function: test : function (address,address,uint256)
procedure {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 38, 5} {:message "ERC721::test"} test#116(__this: address_t, __msg_sender: address_t, __msg_value: int, from#97: address_t, to#99: address_t, tokenId#101: int)
{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	assume {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 39, 9} {:message ""} true;
	call _approve#34(__this, __msg_sender, __msg_value, to#99, tokenId#101);
	assume {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 40, 9} {:message ""} true;
	call transferFrom#59(__this, __msg_sender, __msg_value, from#97, to#99, tokenId#101);
	$return3:
	// Function body ends here
}

// 
// Default constructor
function {:builtin "((as const (Array Int Int)) 0)"} default_int_address_t() returns ([int]address_t);
function {:builtin "((as const (Array Int Bool)) false)"} default_address_t_bool() returns ([address_t]bool);
function {:builtin "((as const (Array Int (Array Int Bool))) ((as const (Array Int Bool)) false))"} default_address_t__k_address_t_v_bool() returns ([address_t][address_t]bool);
function {:builtin "((as const (Array Int Int)) 0)"} default_address_t_int() returns ([address_t]int);
procedure {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 4, 1} {:message "ERC721::[implicit_constructor]"} __constructor#117(__this: address_t, __msg_sender: address_t, __msg_value: int)
{
	assume (__balance[__this] >= 0);
	_tokenApprovals#6 := _tokenApprovals#6[__this := default_int_address_t()];
	_operatorApprovals#12 := _operatorApprovals#12[__this := default_address_t__k_address_t_v_bool()];
	_balances#16 := _balances#16[__this := default_address_t_int()];
	_owners#20 := _owners#20[__this := default_int_address_t()];
}

procedure {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 4, 1} {:message "ERC721::[receive_ether_selfdestruct]"} ERC721_eth_receive(__this: address_t, __msg_value: int)
{
	assume (__msg_value >= 0);
	__balance := __balance[__this := (__balance[__this] + __msg_value)];
}

// 
// Prefunction procedure
procedure {:sourceloc "/home/dy/formal-verify/Contracts/try/test1.sol", 4, 1} {:message "ERC721::[preFunction1]"} PreFunc1(__this: address_t, __msg_sender: address_t, __msg_value: int, to#1: address_t, tokenId#2: int, from#3: address_t, to#4: address_t, tokenId#5: int)
{
	call _approve#34(__this, __msg_sender, __msg_value, to#1, tokenId#2);
	call transferFrom#59(__this, __msg_sender, __msg_value, from#3, to#4, tokenId#5);
}

