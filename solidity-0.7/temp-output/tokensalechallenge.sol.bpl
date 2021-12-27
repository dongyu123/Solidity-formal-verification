// Global declarations and definitions
type address_t = int;
var __balance: [address_t]int;
var __block_number: int;
var __block_timestamp: int;
var __verifier_overflow: bool;
var __alloc_counter: int;
// 
// ------- Source: test/solc-verify/examples/tokensalechallenge.sol -------
// Pragma: solidity>=0.5.0
// 
// ------- Contract: TokenSaleChallenge -------
// 
// State variable: balanceOf: mapping(address => uint256)
var {:sourceloc "test/solc-verify/examples/tokensalechallenge.sol", 9, 5} {:message "balanceOf"} balanceOf#5: [address_t][address_t]int;
function {:builtin "((as const (Array Int Int)) 0)"} default_address_t_int() returns ([address_t]int);
// 
// Function: 
procedure {:sourceloc "test/solc-verify/examples/tokensalechallenge.sol", 12, 5} {:message "TokenSaleChallenge::[constructor]"} __constructor#90(__this: address_t, __msg_sender: address_t, __msg_value: int, _player#10: address_t)
	requires {:sourceloc "test/solc-verify/examples/tokensalechallenge.sol", 12, 5} {:message "An overflow can occur before calling function"} !(__verifier_overflow);

	ensures {:sourceloc "test/solc-verify/examples/tokensalechallenge.sol", 12, 5} {:message "Function can terminate with overflow"} !(__verifier_overflow);

{
	// TCC assumptions
	assume (__msg_sender != 0);
	assume (__balance[__this] >= 0);
	balanceOf#5 := balanceOf#5[__this := default_address_t_int()];
	// Update balance received by msg.value
	assume ((0 <= __balance[__this]) && (__balance[__this] <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	assume ((0 <= __msg_value) && (__msg_value <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	// Implicit assumption that balances cannot overflow
	assume ((__balance[__this] + __msg_value) == (if ((__balance[__this] + __msg_value) >= 115792089237316195423570985008687907853269984665640564039457584007913129639936) then ((__balance[__this] + __msg_value) - 115792089237316195423570985008687907853269984665640564039457584007913129639936) else (__balance[__this] + __msg_value)));
	__balance := __balance[__this := (if ((__balance[__this] + __msg_value) >= 115792089237316195423570985008687907853269984665640564039457584007913129639936) then ((__balance[__this] + __msg_value) - 115792089237316195423570985008687907853269984665640564039457584007913129639936) else (__balance[__this] + __msg_value))];
	// Function body starts here
	assume ((0 <= __msg_value) && (__msg_value <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	assume (__msg_value == 1000000000000000000);
	$return0:
	// Function body ends here
}

// 
// Function: isComplete : function () view returns (bool)
procedure {:sourceloc "test/solc-verify/examples/tokensalechallenge.sol", 16, 5} {:message "TokenSaleChallenge::isComplete"} isComplete#35(__this: address_t, __msg_sender: address_t, __msg_value: int)
	returns (#24: bool)
	requires {:sourceloc "test/solc-verify/examples/tokensalechallenge.sol", 16, 5} {:message "An overflow can occur before calling function"} !(__verifier_overflow);

	ensures {:sourceloc "test/solc-verify/examples/tokensalechallenge.sol", 16, 5} {:message "Function can terminate with overflow"} !(__verifier_overflow);

{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	assume ((0 <= __balance[__this]) && (__balance[__this] <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	#24 := (__balance[__this] < 1000000000000000000);
	goto $return1;
	$return1:
	// Function body ends here
}

// 
// Function: buy : function (uint256)
procedure {:sourceloc "test/solc-verify/examples/tokensalechallenge.sol", 20, 5} {:message "TokenSaleChallenge::buy"} buy#57(__this: address_t, __msg_sender: address_t, __msg_value: int, numTokens#37: int)
	requires {:sourceloc "test/solc-verify/examples/tokensalechallenge.sol", 20, 5} {:message "An overflow can occur before calling function"} !(__verifier_overflow);

	ensures {:sourceloc "test/solc-verify/examples/tokensalechallenge.sol", 20, 5} {:message "Function can terminate with overflow"} !(__verifier_overflow);

{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Update balance received by msg.value
	assume ((0 <= __balance[__this]) && (__balance[__this] <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	assume ((0 <= __msg_value) && (__msg_value <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	// Implicit assumption that balances cannot overflow
	assume ((__balance[__this] + __msg_value) == (if ((__balance[__this] + __msg_value) >= 115792089237316195423570985008687907853269984665640564039457584007913129639936) then ((__balance[__this] + __msg_value) - 115792089237316195423570985008687907853269984665640564039457584007913129639936) else (__balance[__this] + __msg_value)));
	__balance := __balance[__this := (if ((__balance[__this] + __msg_value) >= 115792089237316195423570985008687907853269984665640564039457584007913129639936) then ((__balance[__this] + __msg_value) - 115792089237316195423570985008687907853269984665640564039457584007913129639936) else (__balance[__this] + __msg_value))];
	// Function body starts here
	assume ((0 <= __msg_value) && (__msg_value <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	assume ((0 <= numTokens#37) && (numTokens#37 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	__verifier_overflow := (__verifier_overflow || !(((numTokens#37 * 1) == (if ((numTokens#37 * 1) >= 115792089237316195423570985008687907853269984665640564039457584007913129639936) then ((numTokens#37 * 1) mod 115792089237316195423570985008687907853269984665640564039457584007913129639936) else (numTokens#37 * 1)))));
	assume (__msg_value == (if ((numTokens#37 * 1) >= 115792089237316195423570985008687907853269984665640564039457584007913129639936) then ((numTokens#37 * 1) mod 115792089237316195423570985008687907853269984665640564039457584007913129639936) else (numTokens#37 * 1)));
	assume ((0 <= numTokens#37) && (numTokens#37 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	assume ((0 <= balanceOf#5[__this][__msg_sender]) && (balanceOf#5[__this][__msg_sender] <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	__verifier_overflow := (__verifier_overflow || !(((balanceOf#5[__this][__msg_sender] + numTokens#37) == (if ((balanceOf#5[__this][__msg_sender] + numTokens#37) >= 115792089237316195423570985008687907853269984665640564039457584007913129639936) then ((balanceOf#5[__this][__msg_sender] + numTokens#37) - 115792089237316195423570985008687907853269984665640564039457584007913129639936) else (balanceOf#5[__this][__msg_sender] + numTokens#37)))));
	balanceOf#5 := balanceOf#5[__this := balanceOf#5[__this][__msg_sender := (if ((balanceOf#5[__this][__msg_sender] + numTokens#37) >= 115792089237316195423570985008687907853269984665640564039457584007913129639936) then ((balanceOf#5[__this][__msg_sender] + numTokens#37) - 115792089237316195423570985008687907853269984665640564039457584007913129639936) else (balanceOf#5[__this][__msg_sender] + numTokens#37))]];
	$return2:
	// Function body ends here
}

procedure {:inline 1} {:message "transfer"} __transfer(__this: address_t, __msg_sender: address_t, __msg_value: int, amount: int)
{
	assume (__balance[__msg_sender] >= amount);
	assume ((0 <= __balance[__this]) && (__balance[__this] <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	assume ((0 <= amount) && (amount <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	// Implicit assumption that balances cannot overflow
	assume ((__balance[__this] + amount) == (if ((__balance[__this] + amount) >= 115792089237316195423570985008687907853269984665640564039457584007913129639936) then ((__balance[__this] + amount) - 115792089237316195423570985008687907853269984665640564039457584007913129639936) else (__balance[__this] + amount)));
	__balance := __balance[__this := (if ((__balance[__this] + amount) >= 115792089237316195423570985008687907853269984665640564039457584007913129639936) then ((__balance[__this] + amount) - 115792089237316195423570985008687907853269984665640564039457584007913129639936) else (__balance[__this] + amount))];
	assume ((0 <= __balance[__msg_sender]) && (__balance[__msg_sender] <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	assume ((0 <= amount) && (amount <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	// Implicit assumption that balances cannot overflow
	assume ((__balance[__msg_sender] - amount) == (if (__balance[__msg_sender] >= amount) then (__balance[__msg_sender] - amount) else ((__balance[__msg_sender] - amount) + 115792089237316195423570985008687907853269984665640564039457584007913129639936)));
	__balance := __balance[__msg_sender := (if (__balance[__msg_sender] >= amount) then (__balance[__msg_sender] - amount) else ((__balance[__msg_sender] - amount) + 115792089237316195423570985008687907853269984665640564039457584007913129639936))];
	// TODO: call fallback, exception handling
}

// 
// Function: sell : function (uint256)
procedure {:sourceloc "test/solc-verify/examples/tokensalechallenge.sol", 26, 5} {:message "TokenSaleChallenge::sell"} sell#89(__this: address_t, __msg_sender: address_t, __msg_value: int, numTokens#59: int)
	requires {:sourceloc "test/solc-verify/examples/tokensalechallenge.sol", 26, 5} {:message "An overflow can occur before calling function"} !(__verifier_overflow);

	ensures {:sourceloc "test/solc-verify/examples/tokensalechallenge.sol", 26, 5} {:message "Function can terminate with overflow"} !(__verifier_overflow);

{
	// TCC assumptions
	assume (__msg_sender != 0);
	// Function body starts here
	assume ((0 <= numTokens#59) && (numTokens#59 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	assume ((0 <= balanceOf#5[__this][__msg_sender]) && (balanceOf#5[__this][__msg_sender] <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	assume (balanceOf#5[__this][__msg_sender] >= numTokens#59);
	assume ((0 <= numTokens#59) && (numTokens#59 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	assume ((0 <= balanceOf#5[__this][__msg_sender]) && (balanceOf#5[__this][__msg_sender] <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	__verifier_overflow := (__verifier_overflow || !(((balanceOf#5[__this][__msg_sender] - numTokens#59) == (if (balanceOf#5[__this][__msg_sender] >= numTokens#59) then (balanceOf#5[__this][__msg_sender] - numTokens#59) else ((balanceOf#5[__this][__msg_sender] - numTokens#59) + 115792089237316195423570985008687907853269984665640564039457584007913129639936)))));
	balanceOf#5 := balanceOf#5[__this := balanceOf#5[__this][__msg_sender := (if (balanceOf#5[__this][__msg_sender] >= numTokens#59) then (balanceOf#5[__this][__msg_sender] - numTokens#59) else ((balanceOf#5[__this][__msg_sender] - numTokens#59) + 115792089237316195423570985008687907853269984665640564039457584007913129639936))]];
	assume ((0 <= numTokens#59) && (numTokens#59 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935));
	__verifier_overflow := (__verifier_overflow || !(((numTokens#59 * 1) == (if ((numTokens#59 * 1) >= 115792089237316195423570985008687907853269984665640564039457584007913129639936) then ((numTokens#59 * 1) mod 115792089237316195423570985008687907853269984665640564039457584007913129639936) else (numTokens#59 * 1)))));
	assume {:sourceloc "test/solc-verify/examples/tokensalechallenge.sol", 30, 9} {:message ""} true;
	call __transfer(__msg_sender, __this, 0, (if ((numTokens#59 * 1) >= 115792089237316195423570985008687907853269984665640564039457584007913129639936) then ((numTokens#59 * 1) mod 115792089237316195423570985008687907853269984665640564039457584007913129639936) else (numTokens#59 * 1)));
	$return3:
	// Function body ends here
}

