// Global declarations and definitions
type address_t = int;
var __balance: [address_t]int;
var __block_number: int;
var __block_timestamp: int;
var __alloc_counter: int;
// 
// ------- Source: test/solc-verify/examples/SimpleBankCorrect.sol -------
// Pragma: solidity>=0.7.0
// 
// ------- Contract: SimpleBank -------
var balances#6#SUM: [address_t]int;
// Contract invariant: __verifier_sum_uint(balances) <= address(this).balance
// 
// State variable: balances: mapping(address => uint256)
var {:sourceloc "test/solc-verify/examples/SimpleBankCorrect.sol", 8, 5} {:message "balances"} balances#6: [address_t][address_t]int;
// 
// Function: deposit : function ()
procedure {:sourceloc "test/solc-verify/examples/SimpleBankCorrect.sol", 10, 5} {:message "SimpleBank::deposit"} deposit#18(__this: address_t, __msg_sender: address_t, __msg_value: int)
	requires {:sourceloc "test/solc-verify/examples/SimpleBankCorrect.sol", 10, 5} {:message "Invariant '__verifier_sum_uint(balances) <= address(this).balance' might not hold when entering function."} (balances#6#SUM[__this] <= __balance[__this]);

	ensures {:sourceloc "test/solc-verify/examples/SimpleBankCorrect.sol", 10, 5} {:message "Invariant '__verifier_sum_uint(balances) <= address(this).balance' might not hold at end of function."} (balances#6#SUM[__this] <= __balance[__this]);

{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Update balance received by msg.value
	__balance := __balance[__this := (__balance[__this] + __msg_value)];
	// Function body starts here
	balances#6#SUM := balances#6#SUM[__this := ((balances#6#SUM[__this] - balances#6[__this][__msg_sender]) + (balances#6[__this][__msg_sender] + __msg_value))];
	balances#6 := balances#6[__this := balances#6[__this][__msg_sender := (balances#6[__this][__msg_sender] + __msg_value)]];
	$return0:
	// Function body ends here
}

type int_arr_ptr = int;
type {:datatype} int_arr_type;
function {:constructor} int_arr#constr(arr: [int]int, length: int) returns (int_arr_type);
var mem_arr_int: [int_arr_ptr]int_arr_type;
procedure {:inline 1} {:message "call"} __call(__this: address_t, __msg_sender: address_t, __msg_value: int)
	returns (__result: bool, __calldata: int_arr_ptr)
{
	// TODO: call fallback
	if (*) {
	__balance := __balance[__this := (__balance[__this] + __msg_value)];
	__result := true;
	}
	else {
	__result := false;
	}

}

function {:builtin "((as const (Array Int Int)) 0)"} default_int_int() returns ([int]int);
// 
// Function: withdraw : function (uint256)
procedure {:sourceloc "test/solc-verify/examples/SimpleBankCorrect.sol", 14, 5} {:message "SimpleBank::withdraw"} withdraw#60(__this: address_t, __msg_sender: address_t, __msg_value: int, amount#20: int)
	requires {:sourceloc "test/solc-verify/examples/SimpleBankCorrect.sol", 14, 5} {:message "Invariant '__verifier_sum_uint(balances) <= address(this).balance' might not hold when entering function."} (balances#6#SUM[__this] <= __balance[__this]);

	ensures {:sourceloc "test/solc-verify/examples/SimpleBankCorrect.sol", 14, 5} {:message "Invariant '__verifier_sum_uint(balances) <= address(this).balance' might not hold at end of function."} (balances#6#SUM[__this] <= __balance[__this]);

{
	var {:sourceloc "test/solc-verify/examples/SimpleBankCorrect.sol", 17, 9} {:message "ok"} ok#40: bool;
	var __call_ret#0: bool;
	var __call_ret#1: int_arr_ptr;
	var tmp#2: bool;
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	assume (balances#6[__this][__msg_sender] > amount#20);
	balances#6#SUM := balances#6#SUM[__this := ((balances#6#SUM[__this] - balances#6[__this][__msg_sender]) + (balances#6[__this][__msg_sender] - amount#20))];
	balances#6 := balances#6[__this := balances#6[__this][__msg_sender := (balances#6[__this][__msg_sender] - amount#20)]];
	ok#40 := false;
	// Implicit assumption that we have enough ether
	assume (__balance[__this] >= amount#20);
	__balance := __balance[__this := (__balance[__this] - amount#20)];
	assert {:sourceloc "test/solc-verify/examples/SimpleBankCorrect.sol", 18, 18} {:message "Invariant '__verifier_sum_uint(balances) <= address(this).balance' might not hold before external call."} (balances#6#SUM[__this] <= __balance[__this]);
	assume {:sourceloc "test/solc-verify/examples/SimpleBankCorrect.sol", 18, 18} {:message ""} true;
	call __call_ret#0, __call_ret#1 := __call(__msg_sender, __this, amount#20);
	if (__call_ret#0) {
	havoc balances#6;
	havoc __balance;
	havoc balances#6#SUM;
	}

	assume (balances#6#SUM[__this] <= __balance[__this]);
	if (!(__call_ret#0)) {
	__balance := __balance[__this := (__balance[__this] + amount#20)];
	}

	tmp#2 := __call_ret#0;
	ok#40 := tmp#2;
	if (!(ok#40)) {
	assume false;
	}

	$return1:
	// Function body ends here
}

// 
// Default constructor
function {:builtin "((as const (Array Int Int)) 0)"} default_address_t_int() returns ([address_t]int);
procedure {:sourceloc "test/solc-verify/examples/SimpleBankCorrect.sol", 7, 1} {:message "SimpleBank::[implicit_constructor]"} __constructor#61(__this: address_t, __msg_sender: address_t, __msg_value: int)
	ensures {:sourceloc "test/solc-verify/examples/SimpleBankCorrect.sol", 7, 1} {:message "State variable initializers might violate invariant '__verifier_sum_uint(balances) <= address(this).balance'."} (balances#6#SUM[__this] <= __balance[__this]);

{
	assume (__balance[__this] >= 0);
	balances#6 := balances#6[__this := default_address_t_int()];
	balances#6#SUM := balances#6#SUM[__this := 0];
}

procedure {:sourceloc "test/solc-verify/examples/SimpleBankCorrect.sol", 7, 1} {:message "SimpleBank::[receive_ether_selfdestruct]"} SimpleBank_eth_receive(__this: address_t, __msg_value: int)
	requires {:sourceloc "test/solc-verify/examples/SimpleBankCorrect.sol", 7, 1} {:message "Invariant '__verifier_sum_uint(balances) <= address(this).balance' might not hold when entering function."} (balances#6#SUM[__this] <= __balance[__this]);

	ensures {:sourceloc "test/solc-verify/examples/SimpleBankCorrect.sol", 7, 1} {:message "Invariant '__verifier_sum_uint(balances) <= address(this).balance' might not hold at end of function."} (balances#6#SUM[__this] <= __balance[__this]);

{
	assume (__msg_value >= 0);
	__balance := __balance[__this := (__balance[__this] + __msg_value)];
}

