// Global declarations and definitions
type address_t = int;
var __balance: [address_t]int;
var __block_number: int;
var __block_timestamp: int;
var __alloc_counter: int;
// 
// ------- Source: test/solc-verify/examples/test.sol -------
// Pragma: solidity>=0.7.0
// 
// ------- Contract: C -------
// Contract invariant: funcA ==> funcB
// 
// State variable: x: int256
var {:sourceloc "test/solc-verify/examples/test.sol", 6, 5} {:message "x"} x#4: [address_t]int;
// 
// State variable: y: int256
var {:sourceloc "test/solc-verify/examples/test.sol", 7, 5} {:message "y"} y#6: [address_t]int;
// 
// Function: funcA : function ()
procedure {:sourceloc "test/solc-verify/examples/test.sol", 10, 5} {:message "C::funcA"} funcA#15(__this: address_t, __msg_sender: address_t, __msg_value: int)
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 10, 5} {:message "Postcondition '(x#4[__this] == 1)' might not hold at end of function."} (x#4[__this] == 1);
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 10, 5} {:message "Function might modify balances illegally"} (__balance == old(__balance));
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 10, 5} {:message "Function might modify 'x' illegally"} (x#4[__this] == (if true then x#4[__this] else old(x#4[__this])));
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 10, 5} {:message "Function might modify 'y' illegally"} (y#6[__this] == old(y#6[__this]));

{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	x#4 := x#4[__this := 1];
	$return0:
	// Function body ends here
}

// 
// Function: funcB : function ()
procedure {:sourceloc "test/solc-verify/examples/test.sol", 15, 5} {:message "C::funcB"} funcB#20(__this: address_t, __msg_sender: address_t, __msg_value: int)
	requires {:sourceloc "test/solc-verify/examples/test.sol", 15, 5} {:message "Precondition 'x != 0' might not hold when entering function."} (x#4[__this] != 0);

<<<<<<< HEAD
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 15, 5} {:message "Postcondition '(x#4[__this] == 1)' might not hold at end of function."} (x#4[__this] == 1);
=======
>>>>>>> origin/0.7
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 15, 5} {:message "Function might modify balances illegally"} (__balance == old(__balance));
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 15, 5} {:message "Function might modify 'x' illegally"} (x#4[__this] == old(x#4[__this]));
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 15, 5} {:message "Function might modify 'y' illegally"} (y#6[__this] == old(y#6[__this]));

{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	$return1:
	// Function body ends here
}

// 
// Function: funcC : function ()
procedure {:sourceloc "test/solc-verify/examples/test.sol", 20, 5} {:message "C::funcC"} funcC#31(__this: address_t, __msg_sender: address_t, __msg_value: int)
<<<<<<< HEAD
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 20, 5} {:message "Postcondition '(x#4[__this] == 1)' might not hold at end of function."} (x#4[__this] == 1);
=======
>>>>>>> origin/0.7
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 20, 5} {:message "Function might modify balances illegally"} (__balance == old(__balance));
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 20, 5} {:message "Function might modify 'x' illegally"} (x#4[__this] == (if true then x#4[__this] else old(x#4[__this])));
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 20, 5} {:message "Function might modify 'y' illegally"} (y#6[__this] == old(y#6[__this]));

{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	assume {:sourceloc "test/solc-verify/examples/test.sol", 21, 9} {:message ""} true;
	call funcA#15(__this, __msg_sender, __msg_value);
	assume {:sourceloc "test/solc-verify/examples/test.sol", 22, 9} {:message ""} true;
	call funcB#20(__this, __msg_sender, __msg_value);
	$return2:
	// Function body ends here
}

// 
// Function: funcD : function ()
procedure {:sourceloc "test/solc-verify/examples/test.sol", 26, 5} {:message "C::funcD"} funcD#43(__this: address_t, __msg_sender: address_t, __msg_value: int)
<<<<<<< HEAD
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 26, 5} {:message "Postcondition '(x#4[__this] == 1)' might not hold at end of function."} (x#4[__this] == 1);
=======
>>>>>>> origin/0.7
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 26, 5} {:message "Function might modify balances illegally"} (__balance == old(__balance));
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 26, 5} {:message "Function might modify 'x' illegally"} (x#4[__this] == (if true then x#4[__this] else old(x#4[__this])));
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 26, 5} {:message "Function might modify 'y' illegally"} (y#6[__this] == old(y#6[__this]));

{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	x#4 := x#4[__this := 1];
	assume {:sourceloc "test/solc-verify/examples/test.sol", 28, 9} {:message ""} true;
	call funcB#20(__this, __msg_sender, __msg_value);
	$return3:
	// Function body ends here
}

// 
// Function: funcE : function ()
procedure {:sourceloc "test/solc-verify/examples/test.sol", 32, 5} {:message "C::funcE"} funcE#58(__this: address_t, __msg_sender: address_t, __msg_value: int)
<<<<<<< HEAD
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 32, 5} {:message "Postcondition '(x#4[__this] == 1)' might not hold at end of function."} (x#4[__this] == 1);
=======
>>>>>>> origin/0.7
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 32, 5} {:message "Function might modify balances illegally"} (__balance == old(__balance));
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 32, 5} {:message "Function might modify 'x' illegally"} (x#4[__this] == (if true then x#4[__this] else old(x#4[__this])));
	ensures {:sourceloc "test/solc-verify/examples/test.sol", 32, 5} {:message "Function might modify 'y' illegally"} (y#6[__this] == old(y#6[__this]));

{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	x#4 := x#4[__this := 1];
	assume {:sourceloc "test/solc-verify/examples/test.sol", 34, 9} {:message ""} true;
	call funcA#15(__this, __msg_sender, __msg_value);
	assume {:sourceloc "test/solc-verify/examples/test.sol", 35, 9} {:message ""} true;
	call funcB#20(__this, __msg_sender, __msg_value);
	$return4:
	// Function body ends here
}

// 
// Default constructor
procedure {:sourceloc "test/solc-verify/examples/test.sol", 5, 1} {:message "C::[implicit_constructor]"} __constructor#59(__this: address_t, __msg_sender: address_t, __msg_value: int)
{
	assume (__balance[__this] >= 0);
	x#4 := x#4[__this := 0];
	y#6 := y#6[__this := 0];
}

procedure {:sourceloc "test/solc-verify/examples/test.sol", 5, 1} {:message "C::[receive_ether_selfdestruct]"} C_eth_receive(__this: address_t, __msg_value: int)
{
	assume (__msg_value >= 0);
	__balance := __balance[__this := (__balance[__this] + __msg_value)];
}

// 
// Prefunction procedure
procedure {:sourceloc "test/solc-verify/examples/test.sol", 5, 1} {:message "C::[preFunction1]"} PreFunc1(__this: address_t, __msg_sender: address_t, __msg_value: int)
{
	call funcA#15(__this, __msg_sender, __msg_value);
	call funcB#20(__this, __msg_sender, __msg_value);
}

