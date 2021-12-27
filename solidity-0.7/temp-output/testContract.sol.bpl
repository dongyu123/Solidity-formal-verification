// Global declarations and definitions
type address_t = int;
var __balance: [address_t]int;
var __block_number: int;
var __block_timestamp: int;
var __alloc_counter: int;
// 
// ------- Source: test/solc-verify/examples/testContract.sol -------
// 
// ------- Contract: C1 -------
// 
<<<<<<< HEAD
// State variable: balances: mapping(address => int256)
var {:sourceloc "test/solc-verify/examples/testContract.sol", 3, 5} {:message "balances"} balances#4: [address_t][address_t]int;
// 
// State variable: totalSupply: int256
var {:sourceloc "test/solc-verify/examples/testContract.sol", 4, 5} {:message "totalSupply"} totalSupply#6: [address_t]int;
// 
// Function: funcA : function (address,int256)
procedure {:sourceloc "test/solc-verify/examples/testContract.sol", 9, 5} {:message "C1::funcA"} funcA#28(__this: address_t, __msg_sender: address_t, __msg_value: int, receiver#9: address_t, amount#11: int)
	ensures {:sourceloc "test/solc-verify/examples/testContract.sol", 9, 5} {:message "Postcondition 'balances[msg.sender] == __verifier_old_int(balances[msg.sender]) - amount' might not hold at end of function."} (balances#4[__this][__msg_sender] == (old(balances#4[__this][__msg_sender]) - amount#11));
	ensures {:sourceloc "test/solc-verify/examples/testContract.sol", 9, 5} {:message "Function might modify balances illegally"} (__balance == old(__balance));
	ensures {:sourceloc "test/solc-verify/examples/testContract.sol", 9, 5} {:message "Function might modify 'balances' illegally"} (balances#4[__this] == (if true then (if true then old(balances#4[__this])[__msg_sender := balances#4[__this][__msg_sender]] else old(balances#4[__this]))[receiver#9 := balances#4[__this][receiver#9]] else (if true then old(balances#4[__this])[__msg_sender := balances#4[__this][__msg_sender]] else old(balances#4[__this]))));
	ensures {:sourceloc "test/solc-verify/examples/testContract.sol", 9, 5} {:message "Function might modify 'totalSupply' illegally"} (totalSupply#6[__this] == old(totalSupply#6[__this]));
=======
// State variable: x: int256
var {:sourceloc "test/solc-verify/examples/testContract.sol", 2, 5} {:message "x"} x#2: [address_t]int;
// 
// Function: funcA : function (int256)
procedure {:sourceloc "test/solc-verify/examples/testContract.sol", 4, 5} {:message "C1::funcA"} funcA#12(__this: address_t, __msg_sender: address_t, __msg_value: int, amount#4: int)
	ensures {:sourceloc "test/solc-verify/examples/testContract.sol", 14, 9} {:message "Postcondition 'C1.x == amount' might not hold at end of function."} (x#2[__this] == amount#18);
>>>>>>> origin/0.7

{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
<<<<<<< HEAD
	balances#4 := balances#4[__this := balances#4[__this][__msg_sender := (balances#4[__this][__msg_sender] - amount#11)]];
	balances#4 := balances#4[__this := balances#4[__this][receiver#9 := (balances#4[__this][receiver#9] + amount#11)]];
=======
	x#2 := x#2[__this := 1];
>>>>>>> origin/0.7
	$return0:
	// Function body ends here
}

<<<<<<< HEAD
function {:builtin "((as const (Array Int Int)) 0)"} default_address_t_int() returns ([address_t]int);
// 
// Function: 
procedure {:sourceloc "test/solc-verify/examples/testContract.sol", 14, 5} {:message "C1::[constructor]"} __constructor#49(__this: address_t, __msg_sender: address_t, __msg_value: int)
	ensures {:sourceloc "test/solc-verify/examples/testContract.sol", 14, 5} {:message "Function might modify balances illegally"} (__balance == old(__balance));

{
	// TCC assumptions
	assume (__msg_sender != 0);
	assume (__balance[__this] >= 0);
	balances#4 := balances#4[__this := default_address_t_int()];
	totalSupply#6 := totalSupply#6[__this := 0];
	// Function body starts here
	totalSupply#6 := totalSupply#6[__this := 7000000000000000000000000000];
	balances#4 := balances#4[__this := balances#4[__this][__msg_sender := totalSupply#6[__this]]];
	$return1:
	// Function body ends here
=======
// 
// Default constructor
procedure {:sourceloc "test/solc-verify/examples/testContract.sol", 1, 1} {:message "C1::[implicit_constructor]"} __constructor#13(__this: address_t, __msg_sender: address_t, __msg_value: int)
{
	assume (__balance[__this] >= 0);
	x#2 := x#2[__this := 0];
>>>>>>> origin/0.7
}

// 
// ------- Contract: C2 -------
// 
<<<<<<< HEAD
// Function: funcB : function (address,address,int256)
procedure {:sourceloc "test/solc-verify/examples/testContract.sol", 22, 5} {:message "C2::funcB"} funcB#72(__this: address_t, __msg_sender: address_t, __msg_value: int, a#51: address_t, receiver#53: address_t, amount#55: int)
	ensures {:sourceloc "test/solc-verify/examples/testContract.sol", 22, 5} {:message "Function might modify balances illegally"} (__balance == old(__balance));

{
	var {:sourceloc "test/solc-verify/examples/testContract.sol", 23, 9} {:message "c"} c#59: address_t;
	var new#0: address_t;
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	assume {:sourceloc "test/solc-verify/examples/testContract.sol", 23, 16} {:message ""} true;
	call __constructor#49(new#0, __this, 0);
	c#59 := new#0;
	assume {:sourceloc "test/solc-verify/examples/testContract.sol", 24, 9} {:message ""} true;
	call funcA#28(c#59, __this, 0, receiver#53, amount#55);
	$return2:
=======
// Function: funcB : function (address,int256)
procedure {:sourceloc "test/solc-verify/examples/testContract.sol", 12, 5} {:message "C2::funcB"} funcB#34(__this: address_t, __msg_sender: address_t, __msg_value: int, a#16: address_t, amount#18: int)
{
	var {:sourceloc "test/solc-verify/examples/testContract.sol", 13, 9} {:message "c"} c#22: address_t;
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	c#22 := a#16;
	assume {:sourceloc "test/solc-verify/examples/testContract.sol", 14, 9} {:message ""} true;
	call funcA#12(c#22, __this, 0, amount#18);
	$return1:
>>>>>>> origin/0.7
	// Function body ends here
}

// 
// Default constructor
<<<<<<< HEAD
procedure {:sourceloc "test/solc-verify/examples/testContract.sol", 21, 1} {:message "C2::[implicit_constructor]"} __constructor#73(__this: address_t, __msg_sender: address_t, __msg_value: int)
=======
procedure {:sourceloc "test/solc-verify/examples/testContract.sol", 9, 1} {:message "C2::[implicit_constructor]"} __constructor#35(__this: address_t, __msg_sender: address_t, __msg_value: int)
>>>>>>> origin/0.7
{
	assume (__balance[__this] >= 0);
}

