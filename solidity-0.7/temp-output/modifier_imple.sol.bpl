// Global declarations and definitions
type address_t = int;
var __balance: [address_t]int;
var __block_number: int;
var __block_timestamp: int;
var __alloc_counter: int;
// 
// ------- Source: test/solc-verify/examples/modifier_imple.sol -------
// 
// ------- Contract: C1 -------
// 
// Default constructor
procedure {:sourceloc "test/solc-verify/examples/modifier_imple.sol", 1, 1} {:message "C1::[implicit_constructor]"} __constructor#7(__this: address_t, __msg_sender: address_t, __msg_value: int)
{
	assume (__balance[__this] >= 0);
}

// 
// ------- Contract: C2 -------
// Inherits from: C1
// 
// Function: F : function ()
procedure {:sourceloc "test/solc-verify/examples/modifier_imple.sol", 10, 2} {:message "C2::F"} F#22(__this: address_t, __msg_sender: address_t, __msg_value: int)
{
	var i#2#00: int;
	// TCC assumptions
	assume (__msg_sender != 0);
	// Inlined modifier M starts here
	i#2#00 := 1;
	// Inlined modifier M2 starts here
	// Function body starts here
	$return2:
	// Function body ends here
	$return1:
	// Inlined modifier M2 ends here
	$return0:
	// Inlined modifier M ends here
}

// 
// Default constructor
procedure {:sourceloc "test/solc-verify/examples/modifier_imple.sol", 6, 1} {:message "C2::[implicit_constructor]"} __constructor#23(__this: address_t, __msg_sender: address_t, __msg_value: int)
{
	assume (__balance[__this] >= 0);
}

