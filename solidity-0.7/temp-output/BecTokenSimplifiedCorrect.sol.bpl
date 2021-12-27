// Global declarations and definitions
type address_t = int;
var __balance: [address_t]int;
var __block_number: int;
var __block_timestamp: int;
var __alloc_counter: int;
// 
// ------- Source: test/solc-verify/examples/BecTokenSimplifiedCorrect.sol -------
// Pragma: solidity>=0.7.0
// 
// ------- Contract: SafeMath -------
// 
// Function: mul : function (uint256,uint256) pure returns (uint256)
procedure {:inline 1} {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 9, 5} {:message "SafeMath::mul"} mul#32(__this: address_t, __msg_sender: address_t, __msg_value: int, a#4: int, b#6: int)
	returns (#9: int)
{
	var {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 10, 9} {:message "c"} c#12: int;
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	c#12 := (a#4 * b#6);
	assume ((a#4 == 0) || ((c#12 div a#4) == b#6));
	#9 := c#12;
	goto $return0;
	$return0:
	// Function body ends here
}

// 
// Function: div : function (uint256,uint256) pure returns (uint256)
procedure {:inline 1} {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 15, 5} {:message "SafeMath::div"} div#50(__this: address_t, __msg_sender: address_t, __msg_value: int, a#34: int, b#36: int)
	returns (#39: int)
{
	var {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 17, 9} {:message "c"} c#42: int;
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	c#42 := (a#34 div b#36);
	#39 := c#42;
	goto $return1;
	$return1:
	// Function body ends here
}

// 
// Function: sub : function (uint256,uint256) pure returns (uint256)
procedure {:inline 1} {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 22, 5} {:message "SafeMath::sub"} sub#70(__this: address_t, __msg_sender: address_t, __msg_value: int, a#52: int, b#54: int)
	returns (#57: int)
{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	assume (b#54 <= a#52);
	#57 := (a#52 - b#54);
	goto $return2;
	$return2:
	// Function body ends here
}

// 
// Function: add : function (uint256,uint256) pure returns (uint256)
procedure {:inline 1} {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 27, 5} {:message "SafeMath::add"} add#94(__this: address_t, __msg_sender: address_t, __msg_value: int, a#72: int, b#74: int)
	returns (#77: int)
{
	var {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 28, 9} {:message "c"} c#80: int;
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	c#80 := (a#72 + b#74);
	assume (c#80 >= a#72);
	#77 := c#80;
	goto $return3;
	$return3:
	// Function body ends here
}

// 
// Default constructor
procedure {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 8, 1} {:message "SafeMath::[implicit_constructor]"} {:inline 1} __constructor#95(__this: address_t, __msg_sender: address_t, __msg_value: int)
{
	assume (__balance[__this] >= 0);
}

// 
// ------- Contract: BecTokenSimplified -------
var balances#105#SUM: [address_t]int;
// Contract invariant: totalSupply == __verifier_sum_uint(balances)
// Using library SafeMath for uint256
// 
// State variable: totalSupply: uint256
var {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 40, 5} {:message "totalSupply"} totalSupply#101: [address_t]int;
// 
// State variable: balances: mapping(address => uint256)
var {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 41, 5} {:message "balances"} balances#105: [address_t][address_t]int;
function {:builtin "((as const (Array Int Int)) 0)"} default_address_t_int() returns ([address_t]int);
// 
// Function: 
procedure {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 43, 5} {:message "BecTokenSimplified::[constructor]"} __constructor#279(__this: address_t, __msg_sender: address_t, __msg_value: int)
	ensures {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 43, 5} {:message "Invariant 'totalSupply == __verifier_sum_uint(balances)' might not hold at end of function."} (totalSupply#101[__this] == balances#105#SUM[__this]);

{
	// TCC assumptions
	assume (__msg_sender != 0);
	assume (__balance[__this] >= 0);
	totalSupply#101 := totalSupply#101[__this := 0];
	balances#105 := balances#105[__this := default_address_t_int()];
	balances#105#SUM := balances#105#SUM[__this := 0];
	// Function body starts here
	totalSupply#101 := totalSupply#101[__this := 7000000000000000000000000000];
	balances#105#SUM := balances#105#SUM[__this := ((balances#105#SUM[__this] - balances#105[__this][__msg_sender]) + totalSupply#101[__this])];
	balances#105 := balances#105[__this := balances#105[__this][__msg_sender := totalSupply#101[__this]]];
	$return4:
	// Function body ends here
}

// 
// Function: balanceOf : function (address) view returns (uint256)
procedure {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 48, 5} {:message "BecTokenSimplified::balanceOf"} balanceOf#137(__this: address_t, __msg_sender: address_t, __msg_value: int, _owner#127: address_t)
	returns (balance#130: int)
	requires {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 48, 5} {:message "Invariant 'totalSupply == __verifier_sum_uint(balances)' might not hold when entering function."} (totalSupply#101[__this] == balances#105#SUM[__this]);

	ensures {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 48, 5} {:message "Invariant 'totalSupply == __verifier_sum_uint(balances)' might not hold at end of function."} (totalSupply#101[__this] == balances#105#SUM[__this]);

{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	balance#130 := balances#105[__this][_owner#127];
	goto $return5;
	$return5:
	// Function body ends here
}

// 
// Function: transfer : function (address,uint256) returns (bool)
procedure {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 52, 5} {:message "BecTokenSimplified::transfer"} transfer#186(__this: address_t, __msg_sender: address_t, __msg_value: int, _receiver#139: address_t, _value#141: int)
	returns (#144: bool)
	requires {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 52, 5} {:message "Invariant 'totalSupply == __verifier_sum_uint(balances)' might not hold when entering function."} (totalSupply#101[__this] == balances#105#SUM[__this]);

	ensures {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 52, 5} {:message "Invariant 'totalSupply == __verifier_sum_uint(balances)' might not hold at end of function."} (totalSupply#101[__this] == balances#105#SUM[__this]);

{
	var sub#70_ret#0: int;
	var add#94_ret#1: int;
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	assume ((_value#141 > 0) && (balances#105[__this][__msg_sender] >= _value#141));
	assume {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 55, 32} {:message ""} true;
	call sub#70_ret#0 := sub#70(__this, __msg_sender, __msg_value, balances#105[__this][__msg_sender], _value#141);
	balances#105#SUM := balances#105#SUM[__this := ((balances#105#SUM[__this] - balances#105[__this][__msg_sender]) + sub#70_ret#0)];
	balances#105 := balances#105[__this := balances#105[__this][__msg_sender := sub#70_ret#0]];
	assume {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 56, 31} {:message ""} true;
	call add#94_ret#1 := add#94(__this, __msg_sender, __msg_value, balances#105[__this][_receiver#139], _value#141);
	balances#105#SUM := balances#105#SUM[__this := ((balances#105#SUM[__this] - balances#105[__this][_receiver#139]) + add#94_ret#1)];
	balances#105 := balances#105[__this := balances#105[__this][_receiver#139 := add#94_ret#1]];
	#144 := true;
	goto $return6;
	$return6:
	// Function body ends here
}

type address_t_arr_ptr = int;
type {:datatype} address_t_arr_type;
function {:constructor} address_t_arr#constr(arr: [int]address_t, length: int) returns (address_t_arr_type);
var mem_arr_address_t: [address_t_arr_ptr]address_t_arr_type;
// 
// Function: batchTransfer : function (address[] memory,uint256) returns (bool)
procedure {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 60, 5} {:message "BecTokenSimplified::batchTransfer"} batchTransfer#278(__this: address_t, __msg_sender: address_t, __msg_value: int, _receivers#189: address_t_arr_ptr, _value#191: int)
	returns (#194: bool)
	requires {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 60, 5} {:message "Invariant 'totalSupply == __verifier_sum_uint(balances)' might not hold when entering function."} (totalSupply#101[__this] == balances#105#SUM[__this]);

	ensures {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 60, 5} {:message "Invariant 'totalSupply == __verifier_sum_uint(balances)' might not hold at end of function."} (totalSupply#101[__this] == balances#105#SUM[__this]);

{
	var {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 61, 9} {:message "cnt"} cnt#197: int;
	var {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 62, 9} {:message "amount"} amount#202: int;
	var mul#32_ret#2: int;
	var sub#70_ret#3: int;
	var {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 71, 14} {:message "i"} i#249: int;
	var add#94_ret#6: int;
	var tmp#7: int;
	// TCC assumptions
	assume (_receivers#189 < __alloc_counter);
	assume (__msg_sender != 0);
	// Function body starts here
	assume ((0 <= length#address_t_arr#constr(mem_arr_address_t[_receivers#189])) && (length#address_t_arr#constr(mem_arr_address_t[_receivers#189]) <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	cnt#197 := length#address_t_arr#constr(mem_arr_address_t[_receivers#189]);
	assume {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 62, 26} {:message ""} true;
	call mul#32_ret#2 := mul#32(__this, __msg_sender, __msg_value, cnt#197, _value#191);
	amount#202 := mul#32_ret#2;
	assume ((cnt#197 > 0) && (cnt#197 <= 20));
	assume ((_value#191 > 0) && (balances#105[__this][__msg_sender] >= amount#202));
	assume {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 66, 32} {:message ""} true;
	call sub#70_ret#3 := sub#70(__this, __msg_sender, __msg_value, balances#105[__this][__msg_sender], amount#202);
	balances#105#SUM := balances#105#SUM[__this := ((balances#105#SUM[__this] - balances#105[__this][__msg_sender]) + sub#70_ret#3)];
	balances#105 := balances#105[__this := balances#105[__this][__msg_sender := sub#70_ret#3]];
	// The following while loop was mapped from a for loop
	// Initialization
	i#249 := 0;
	while ((i#249 < cnt#197))
	invariant {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 71, 9} {:message "totalSupply == __verifier_sum_uint(balances) + (cnt - i) * _value"} (totalSupply#101[__this] == (balances#105#SUM[__this] + ((cnt#197 - i#249) * _value#191)));

	invariant {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 71, 9} {:message "i <= cnt"} (i#249 <= cnt#197);


	{
	// Body
	assume {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 72, 39} {:message ""} true;
	call add#94_ret#6 := add#94(__this, __msg_sender, __msg_value, balances#105[__this][arr#address_t_arr#constr(mem_arr_address_t[_receivers#189])[i#249]], _value#191);
	balances#105#SUM := balances#105#SUM[__this := ((balances#105#SUM[__this] - balances#105[__this][arr#address_t_arr#constr(mem_arr_address_t[_receivers#189])[i#249]]) + add#94_ret#6)];
	balances#105 := balances#105[__this := balances#105[__this][arr#address_t_arr#constr(mem_arr_address_t[_receivers#189])[i#249] := add#94_ret#6]];
	$continue4:
	// Loop expression
	tmp#7 := i#249;
	i#249 := (i#249 + 1);
	}

	break5:
	#194 := true;
	goto $return7;
	$return7:
	// Function body ends here
}

procedure {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 37, 1} {:message "BecTokenSimplified::[receive_ether_selfdestruct]"} BecTokenSimplified_eth_receive(__this: address_t, __msg_value: int)
	requires {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 37, 1} {:message "Invariant 'totalSupply == __verifier_sum_uint(balances)' might not hold when entering function."} (totalSupply#101[__this] == balances#105#SUM[__this]);

	ensures {:sourceloc "test/solc-verify/examples/BecTokenSimplifiedCorrect.sol", 37, 1} {:message "Invariant 'totalSupply == __verifier_sum_uint(balances)' might not hold at end of function."} (totalSupply#101[__this] == balances#105#SUM[__this]);

{
	assume (__msg_value >= 0);
	__balance := __balance[__this := (__balance[__this] + __msg_value)];
}

