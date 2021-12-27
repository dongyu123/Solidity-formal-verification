// Global declarations and definitions
type address_t = int;
var __balance: [address_t]int;
var __block_number: int;
var __block_timestamp: int;
var __alloc_counter: int;
// 
// ------- Source: test/solc-verify/examples/functions.sol -------
// 
// ------- Contract: C1 -------
// 
// Function: f1 : function ()
procedure {:sourceloc "test/solc-verify/examples/functions.sol", 2, 2} {:message "C1::f1"} f1#4(__this: address_t, __msg_sender: address_t, __msg_value: int)
{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	$return0:
	// Function body ends here
}

// 
// Default constructor
procedure {:sourceloc "test/solc-verify/examples/functions.sol", 1, 1} {:message "C1::[implicit_constructor]"} __constructor#5(__this: address_t, __msg_sender: address_t, __msg_value: int)
{
	assume (__balance[__this] >= 0);
}

// 
// ------- Contract: C2 -------
// 
// State variable: c1_addr: contract C1
var {:sourceloc "test/solc-verify/examples/functions.sol", 7, 2} {:message "c1_addr"} c1_addr#7: [address_t]address_t;
// 
// Function: f2 : function ()
procedure {:sourceloc "test/solc-verify/examples/functions.sol", 8, 2} {:message "C2::f2"} f2#16(__this: address_t, __msg_sender: address_t, __msg_value: int)
{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	assume {:sourceloc "test/solc-verify/examples/functions.sol", 9, 3} {:message ""} true;
	call f1#4(c1_addr#7[__this], __this, 0);
	$return1:
	// Function body ends here
}

// 
// Default constructor
procedure {:sourceloc "test/solc-verify/examples/functions.sol", 6, 1} {:message "C2::[implicit_constructor]"} __constructor#17(__this: address_t, __msg_sender: address_t, __msg_value: int)
{
	assume (__balance[__this] >= 0);
	c1_addr#7 := c1_addr#7[__this := 0];
}

