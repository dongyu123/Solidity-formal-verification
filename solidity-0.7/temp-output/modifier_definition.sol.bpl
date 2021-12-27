// Global declarations and definitions
type address_t = int;
var __balance: [address_t]int;
var __block_number: int;
var __block_timestamp: int;
var __alloc_counter: int;
// 
// ------- Source: test/libsolidity/ASTJSON/modifier_definition.sol -------
// 
// ------- Contract: C -------
// 
// Function: F : function ()
procedure {:sourceloc "test/libsolidity/ASTJSON/modifier_definition.sol", 1, 40} {:message "C::F"} F#13(__this: address_t, __msg_sender: address_t, __msg_value: int)
{
	var i#2#00: int;
	// TCC assumptions
	assume (__msg_sender != 0);
	// Inlined modifier M starts here
	i#2#00 := 1;
	// Function body starts here
	$return1:
	// Function body ends here
	$return0:
	// Inlined modifier M ends here
}

// 
// Default constructor
procedure {:sourceloc "test/libsolidity/ASTJSON/modifier_definition.sol", 1, 1} {:message "C::[implicit_constructor]"} __constructor#14(__this: address_t, __msg_sender: address_t, __msg_value: int)
{
	assume (__balance[__this] >= 0);
}

