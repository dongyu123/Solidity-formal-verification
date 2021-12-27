// Global declarations and definitions
type address_t = int;
var __balance: [address_t]int;
var __block_number: int;
var __block_timestamp: int;
var __alloc_counter: int;
// 
// ------- Source: test/solc-verify/examples/Annotations.sol -------
// Pragma: solidity>=0.7.0
// 
// ------- Contract: C -------
// Contract invariant: x == y
// 
// State variable: x: int256
var {:sourceloc "test/solc-verify/examples/Annotations.sol", 6, 5} {:message "x"} x#4: [address_t]int;
// 
// State variable: y: int256
var {:sourceloc "test/solc-verify/examples/Annotations.sol", 7, 5} {:message "y"} y#6: [address_t]int;
// 
// Function: add_to_x : function (int256)
procedure {:inline 1} {:sourceloc "test/solc-verify/examples/Annotations.sol", 12, 5} {:message "C::add_to_x"} add_to_x#25(__this: address_t, __msg_sender: address_t, __msg_value: int, n#9: int)
	requires {:sourceloc "test/solc-verify/examples/Annotations.sol", 12, 5} {:message "Precondition 'x == y' might not hold when entering function."} (x#4[__this] == y#6[__this]);

	ensures {:sourceloc "test/solc-verify/examples/Annotations.sol", 12, 5} {:message "Postcondition 'x == (y + n)' might not hold at end of function."} (x#4[__this] == (y#6[__this] + n#9));
	ensures {:sourceloc "test/solc-verify/examples/Annotations.sol", 12, 5} {:message "Function might modify balances illegally"} (__balance == old(__balance));
	ensures {:sourceloc "test/solc-verify/examples/Annotations.sol", 12, 5} {:message "Function might modify 'x' illegally"} (x#4[__this] == (if true then x#4[__this] else old(x#4[__this])));
	ensures {:sourceloc "test/solc-verify/examples/Annotations.sol", 12, 5} {:message "Function might modify 'y' illegally"} (y#6[__this] == old(y#6[__this]));

{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	x#4 := x#4[__this := (x#4[__this] + n#9)];
	assume (x#4[__this] >= y#6[__this]);
	$return0:
	// Function body ends here
}

// 
// Function: add : function (int256)
procedure {:sourceloc "test/solc-verify/examples/Annotations.sol", 19, 5} {:message "C::add"} add#54(__this: address_t, __msg_sender: address_t, __msg_value: int, n#28: int)
	requires {:sourceloc "test/solc-verify/examples/Annotations.sol", 19, 5} {:message "Invariant 'x == y' might not hold when entering function."} (x#4[__this] == y#6[__this]);

	ensures {:sourceloc "test/solc-verify/examples/Annotations.sol", 19, 5} {:message "Invariant 'x == y' might not hold at end of function."} (x#4[__this] == y#6[__this]);
	ensures {:sourceloc "test/solc-verify/examples/Annotations.sol", 19, 5} {:message "Function might modify balances illegally"} (__balance == old(__balance));
	ensures {:sourceloc "test/solc-verify/examples/Annotations.sol", 19, 5} {:message "Function might modify 'x' illegally"} (x#4[__this] == (if old((n#28 > 0)) then x#4[__this] else old(x#4[__this])));
	ensures {:sourceloc "test/solc-verify/examples/Annotations.sol", 19, 5} {:message "Function might modify 'y' illegally"} (y#6[__this] == (if old((n#28 > 0)) then y#6[__this] else old(y#6[__this])));

{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	assume (n#28 >= 0);
	assume {:sourceloc "test/solc-verify/examples/Annotations.sol", 21, 9} {:message ""} true;
	call add_to_x#25(__this, __msg_sender, __msg_value, n#28);
	while ((y#6[__this] < x#4[__this]))
	invariant {:sourceloc "test/solc-verify/examples/Annotations.sol", 23, 9} {:message "y <= x"} (y#6[__this] <= x#4[__this]);


	{
	y#6 := y#6[__this := (y#6[__this] + 1)];
	$continue0:
	}

	break1:
	$return1:
	// Function body ends here
}

// 
// Default constructor
procedure {:sourceloc "test/solc-verify/examples/Annotations.sol", 5, 1} {:message "C::[implicit_constructor]"} __constructor#55(__this: address_t, __msg_sender: address_t, __msg_value: int)
	ensures {:sourceloc "test/solc-verify/examples/Annotations.sol", 5, 1} {:message "State variable initializers might violate invariant 'x == y'."} (x#4[__this] == y#6[__this]);

{
	assume (__balance[__this] >= 0);
	x#4 := x#4[__this := 0];
	y#6 := y#6[__this := 0];
}

procedure {:sourceloc "test/solc-verify/examples/Annotations.sol", 5, 1} {:message "C::[receive_ether_selfdestruct]"} C_eth_receive(__this: address_t, __msg_value: int)
	requires {:sourceloc "test/solc-verify/examples/Annotations.sol", 5, 1} {:message "Invariant 'x == y' might not hold when entering function."} (x#4[__this] == y#6[__this]);

	ensures {:sourceloc "test/solc-verify/examples/Annotations.sol", 5, 1} {:message "Invariant 'x == y' might not hold at end of function."} (x#4[__this] == y#6[__this]);

{
	assume (__msg_value >= 0);
	__balance := __balance[__this := (__balance[__this] + __msg_value)];
}

