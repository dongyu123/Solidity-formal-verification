# solc-verify

This is an extended version of the compiler that is able to perform **automated formal verification** on Solidity smart contracts using **specification annotations** and **modular program verification**.
More information can be found in this readme and in our [publications](https://github.com/SRI-CSL/solidity/wiki/Publications).
This branch is based on **Solidity v0.7.6**, see other branches for different versions.

First, we present how to [build, install](#build-and-install) and [run](#running-solc-verify) solc-verify including its options.
Then we illustrate the features of solc-verify through some [examples](#examples).
We discuss available [specification annotations](#specification-annotations) and interpreting
[verification results](#verification-and-results) in more detail.

## Build and Install

The easiest way to quickly try solc-verify is to use our [docker image](docker/README.md).

Solc-verify is mainly developed and tested on Linux and OS X.
It requires [Boogie](https://github.com/boogie-org/boogie) as a verification backend with SMT solvers [CVC4](http://cvc4.cs.stanford.edu) and [Z3](https://github.com/Z3Prover/z3).
By default, solc-verify requires both solvers, as it runs both of them to get a result even if one of them is inconclusive or exceeds the time limit.
This can be disabled (see later), in which case it is enough to install only one solver.

On a standard Ubuntu system (18/20), solc-verify can be built and installed as follows.

**[CVC4](http://cvc4.cs.stanford.edu)** (>=1.6 required)
```
curl --silent "https://api.github.com/repos/CVC4/CVC4/releases/latest" | grep browser_download_url | grep -E 'linux' | cut -d '"' -f 4 | sudo wget -qi - -O /usr/local/bin/cvc4
sudo chmod a+x /usr/local/bin/cvc4
```

**[Z3](https://github.com/Z3Prover/z3)**
```
curl --silent "https://api.github.com/repos/Z3Prover/z3/releases/latest" | grep browser_download_url | grep -E 'ubuntu' | cut -d '"' -f 4 | wget -qi - -O z3.zip
sudo sh -c ' unzip -p z3.zip "*bin/z3" > /usr/local/bin/z3'
sudo chmod a+x /usr/local/bin/z3
```

CVC4 and Z3 should be on the `PATH` (the previous instructions ensure this). You can verify this with `cvc4 --version` and `z3 --version`.

**[.NET Core runtime 3.1](https://docs.microsoft.com/dotnet/core/install/linux-package-managers)** (required for Boogie)
```
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install dotnet-sdk-3.1
```

**[Boogie](https://github.com/boogie-org/boogie)**
```
dotnet tool install --global boogie
```

The directory `$HOME/.dotnet/tools` has to be on `PATH`, you can do this by the following commands.
```
echo 'export PATH="$PATH:$HOME/.dotnet/tools"' >> ~/.bashrc
source ~/.bashrc
```

Use `boogie -version` to verify that Boogie works.

**solc-verify**

_Remark: See instructions on getting the latest [cmake](https://graspingtech.com/upgrade-cmake/) and [g++](https://linuxize.com/post/how-to-install-gcc-compiler-on-ubuntu-18-04/) if you are on Ubuntu 18, as the default version installed by the package manager might be outdated._

```
sudo apt install python3-pip -y
pip3 install psutil
git clone https://github.com/SRI-CSL/solidity.git
cd solidity
./scripts/install_deps.sh
mkdir build
cd build
cmake -DUSE_Z3=Off -DUSE_CVC4=Off ..
make
sudo make install
cd ../..
```

_Remark:_ The `USE_Z3` and `USE_CVC4` flags only disable the experimental SMT checker feature of the compiler (avoiding compilation errors in certain cases), and do not affect the solver selection for solc-verify.

## Running solc-verify

After successful installation, solc-verify can be run by `solc-verify.py <solidity-file>`. You can type `solc-verify.py -h` to print the optional arguments, but we also list them below.

- `-h`, `--help`: Show help message and exit.
- `--timeout <TIMEOUT>`: Timeout for running the Boogie verifier in seconds (default is 10). Solc-verify verifies each function separately (also allowing parallel execution). The time limit is _per function_, not the total limit.
- `--arithmetic {int,bv,mod,mod-overflow}`: Encoding of the arithmetic operations (see [paper](https://arxiv.org/abs/1907.04262) for more details):
  - `int` is SMT (unbounded, mathematical) integer mode, which is scalable and well supported by solvers, but do not capture exact semantics (e.g., overflows, unsigned numbers)
  - `bv` is SMT bitvector mode, which is precise but might not scale for large bit-widths
  - `mod` is modular arithmetic mode, encoding arithmetic operations using mathematical integers with range assertions and precise wraparound semantics
  - `mod-overflow` is modular arithmetic with overflow checking enabled
- `--modifies-analysis`: State variables and balances are checked for modifications if there are modification annotations or if this flag is explicitly given.
- `--event-analysis`: Checking emitting events and tracking data changes related to events is only performed if there are event annotations or if this flag is explicitly given.
- `--parallel <CORES>`: How many cores to use (solc-verify can check each function separately, allowing parallel execution).
- `--output <DIRECTORY>`: Output directory where the intermediate (e.g., Boogie) files are created (tmp directory by default).
- `--verbose`: Print all output of the compiler and the verifier.
- `--smt-log <FILE>`: Log the inputs given by Boogie to the SMT solver into a file (not given by default).
- `--errors-only`: Only display error messages and omit displaying names of correct functions (not given by default).
- `--show-warnings`: Display warning messages (not given by default).
- `--solc <FILE>`: Path to the Solidity compiler to use (which must include our Boogie translator extension) (by default it is the one that includes the Python script).
- `--boogie <FILE>`: Path to the Boogie verifier binary to use (by default it is the one given during building the tool).
- `--solver {all,z3,cvc4}`: SMT solver used by the verifier, if `all` is selected solc-verify runs both solvers and gets the first conclusive result. For example, if one solver crashes or exceeds the time limit, but the other answers, the result of the other is taken. Use this option when only one solver is available. (Default is `all`.)
- `--solver-bin <FILE>`: Path to the solver to be used, if not given, the solver is searched on the system path (not given by default).

## Examples

Some examples are located under the `test/solc-verify/examples` directory and are described in the following.

### Specifictaion Annotations

This example ([`Annotations.sol`](test/solc-verify/examples/Annotations.sol)) presents some of the available specification annotations. A _contract-level invariant_ (line 3) ensures that `x` and `y` are always equal. Contract-level annotations are added as both _pre-_ and _postconditions_ to public functions. Non-public functions (such as `add_to_x`) are not checked against contract-level invariants, but can be annotated with pre- and post-conditions explicitly. By default, non-public functions are _inlined_ to a depth of 1. Loops can be annotated with _loop invariants_. Furthermore, functions can be annotated with the state variables that they can _modify_ (including conditions). This contract is correct and can be verified by the following command:
```
solc-verify.py test/solc-verify/examples/Annotations.sol
```
Note that it is also free of _overflows_, since the programmer included an explicit check in line 13. Solc-verify can detect this and avoid a false alarm:
```
solc-verify.py test/solc-verify/examples/Annotations.sol --arithmetic mod-overflow
```
However, removing that check and running solc-verify with overflow checks will report the potential overflow.

### SimpleBank

This is the simplified version of the [infamous DAO hack](https://link.springer.com/chapter/10.1007/978-1-4842-3081-7_6), illustrating the reentrancy issue. There are two versions of the `withdraw` function (line 13). In the incorrect version ([`SimpleBankReentrancy.sol`](test/solc-verify/examples/SimpleBankReentrancy.sol)) we first transfer the money and then reduce the balance of the sender, allowing a reentrancy attack. The operations in the correct version ([`SimpleBankCorrect.sol`](test/solc-verify/examples/SimpleBankCorrect.sol)) are the other way around, preventing the reentrancy attack. The contract is annotated with a contract level invariant (line 4) ensuring that the balance of the contract is at least the sum of individual balances. Using this invariant we can detect the error in the incorrect version (invariant does not hold when the reentrant call is made) and avoid a false alarm in the correct version (invariant holds when the reentrant call is made).
```
solc-verify.py test/solc-verify/examples/SimpleBankReentrancy.sol
solc-verify.py test/solc-verify/examples/SimpleBankCorrect.sol
```

[`SumOverStructMember.sol`](test/solc-verify/examples/SumOverStructMember.sol) presents a modified version of the simple bank, where the accounts are complex structures and the sum is expressed over a member of this structure.
```
solc-verify.py test/solc-verify/examples/SumOverStructMember.sol
```

### BecToken

This example ([`BecTokenSimplifiedOverflow.sol`](test/solc-verify/examples/BecTokenSimplifiedOverflow.sol)) presents a part of the BecToken, which had an [overflow issue](https://nvd.nist.gov/vuln/detail/CVE-2018-10299). It uses the `SafeMath` library (from [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts/)) for most operations to prevent overflows, except for a multiplication in `batchTransfer` (line 61). The function transfers a given `_value` to a given number of `_receivers`. It first reduces the balance of the sender with the product of the value and the number of receivers and then transfers the value to each receiver in a loop. If the product overflows, a small product will be deducted from the sender, but large values will be transferred to the receivers. Solc-verify can detect this issue by the following command (using CVC4):
```
solc-verify.py test/solc-verify/examples/BecTokenSimplifiedOverflow.sol --arithmetic mod-overflow --solver cvc4
```
In the correct version ([`BecTokenSimplifiedCorrect.sol`](test/solc-verify/examples/BecTokenSimplifiedCorrect.sol)), the multiplication in line 61 is replaced by the `mul` operation from `SafeMath`, making the contract safe. Solc-verify can not only prove the absence of overflows, but also the contract invariant (sum of balances equals to total supply, line 34) and the loop invariant (line 67) including nonlinear arithmetic over 256-bit integers:
```
solc-verify.py test/solc-verify/examples/BecTokenSimplifiedCorrect.sol --arithmetic mod-overflow --solver cvc4
```

### Storage

This example ([`Storage.sol`](test/solc-verify/examples/Storage.sol)) presents a simple storage example, where each user can set, update or clear their data (represented as an integer) in the storage. The owner can clear any data. This example demonstrates annotation possibilities (such as fine grained modifications) over complex datatypes (such as structs and mappings).
```
solc-verify.py test/solc-verify/examples/Storage.sol
```

### Events

This example ([`Events.sol`](test/solc-verify/examples/Events.sol)) presents a simple registry, where users can register an integer data and can later update it with a greater integer. The contract also defines events to keep track of these changes. This example illustrates annotation possibilities for events: Events can declare variables where they keep track of the changes. If the data changes, one of the events must be emitted. Furthermore, events can also define conditions on the state of the data before and after updating (e.g., the number was smaller before update).
```
solc-verify.py test/solc-verify/examples/Events.sol
```

## Specification Annotations

Specification annotations must be included in special documentation comments (`///` or `/** */`) and must start with the special doctag `@notice`.
They must be side-effect free Solidity expressions (with some verifier specific extensions) and can refer to variables within the scope of the annotated element.
Functions cannot be called in the annotations, except for getters
The currently available annotations are listed below.
We try to keep the language simple to enable automation, but it is evolving based on user input.

See the contracts under `test/solc-verify/examples` for examples.

- **Function pre/postconditions** (`precondition <EXPRESSION>` / `postcondition <EXPRESSION>`) can be attached to functions. Preconditions are assumed before executing the function and postconditions are checked (asserted) in the end. The expression can refer to variables in the scope of the function. The postcondition can also refer to the return value if it is named.
- **Contract level invariants**  (`invariant <EXPRESSION>`) can be attached to contracts. They are included as both a pre- and a postcondition for each _public_ function. The expression can refer to state variables in the contract (and its balance).
- **Loop invariants**  (`invariant <EXPRESSION>`) can be attached to _for_ and _while_ loops. The expression can refer to variables in scope of the loop, including the loop counter.
- **Modification specifiers** (`modifies <TARGET> [if <CONDITION>]`) can be attached to functions. The target can be a (1) state variable, including index and member accesses or (2) a balance of an address in scope. Note however, that balance changes due to gas cost or miner rewards are currently not modeled. Optionally, a condition can also be given. Variables in the condition refer to the old values (i.e., before executing the function). Modification specifications will be checked at the end of the function (whether only the specified variables were modified). See [`Storage.sol`](test/solc-verify/examples/Storage.sol) for examples.
- Contract and loop invariants can refer to a special **sum function over collections** (`__verifier_sum_int(...)` or `__verifier_sum_uint(...)`). The argument must be an array/mapping state variable with integer values, or must point to an integer member if the array/mapping contains structures (see [`SumOverStructMember.sol`](test/solc-verify/examples/SumOverStructMember.sol)).
- Postconditions can refer to the **old value** of a variable (before the transaction) using `__verifier_old_<TYPE>` (e.g., `__verifier_old_uint(...)`).
- Specifications can refer to a special **equality predicate** `__verifier_eq(..., ...)` for reference types such as structures, arrays and mappings (not comparable with the standard Solidity operator `==`). It takes two arguments with the same type. For storage data location it performs a deep equality check, for other data locations it performs a reference equality check.
- Specification expressions can use **quantifiers** with `forall (<VARS>) <QUANTEXPR>` or `exists (<VARS>) <QUANTEXPR>`. The quantified expression can refer to variables in scope and the quantified variables. For example, given an array state variable `int[] a`, the expression `forall (uint i) !(0 <= i && i < a.length) || (a[i] >= 0)` states that all of its elements are non-negative. See [`QuantifiersSimple.sol`](test/solc-verify/examples/QuantifiersSimple.sol) for examples. Note that quantifiers are hard to handle in general so it is recommended to use all SMT solvers (see arguments).
- **Emits specifiers** (`emits <EVENTNAME>`) can be attached to functions. A function can only emit events that are declared with such specifiers. If an event is specified, but never emitted, a warning is generated. If a function calls other functions, base constructors or modifiers, their events should also be specified, except for external calls (that can emit any event). Note that events are specified only by their name, meaning that any overload can be emitted. For more details see our [paper](https://arxiv.org/abs/2005.10382).
- **Event data specification** can be attached to events that should be emitted when certain data changes. Events can declare the state variable(s) they _track_ for changes, or in other words, the variables for which the event should be emitted on a change (`tracks-changes-in <VARIABLE>`). Furthermore, pre- and postconditions can also be attached to events to specify the expected state of the data _before_ the change (`precondition <EXPRESSION>`) and _currently_ (`postcondition <EXPRESSION>`). These expressions can refer to state variables and parameters of the event. For state variables, the _current_ state (`postcondition`) means the state at the point of the emit statement, and the state _before_ (`precondition`) refers to the state at the previous _checkpoint_. In the postcondition it is also possible to refer to the previous state using `__verifier_before_<TYPE>(...)` (e.g., `__verifier_before_uint(...)`). Currently, there are checkpoints at the beginning of a function, at function calls, at emit statements and at loop iterations. Note that state variables appearing in the pre- and postconditions of an event are automatically tracked (without explicitly declaring with `tracks-changes-in`).  For more details see our [paper](https://arxiv.org/abs/2005.10382).

## Verification and Results
Solc-verify targets _functional correctness_ of contracts with respect to _completed transactions_ and different types of _failures_.
An _expected failure_ is a failure due to an exception deliberately thrown by the developer (e.g., `require`, `revert`). An _unexpected failure_ is any other failure (e.g., `assert`, overflow).
Solc-verify performs modular verification by checking for each public function whether it can fail due to an unexpected failure or violate its _specification_ in any completed transaction.

Solc-verify checks each function independently (allowing parallel execution).
Furthermore, if multiple solvers are available, all of them are executed for each function and the results are merged.
This way, if a solver is inconclusive, we still have the chance to get a conclusive answer for a function via an other solver.
The output for each function is `OK`, `ERROR` or `SKIPPED`.
If a function contains any errors, solc-verify lists them below.
If a function contains any unsupported features it is skipped and treated as if it could modify any state variable arbitrarily (safe over-approximation).
However, skipped functions can be specified with annotations, which will be assumed to hold during verification.
Finally, solc-verify lists warnings if some abstraction was applied that might introduce false alarms.

For example, running solc-verify on [VerifResults.sol](test/solc-verify/examples/VerifResults.sol)
```
solc-verify.py test/solc-verify/examples/VerifResults.sol
```
results in
```
VerifResults::[constructor]: OK
VerifResults::set_correct: OK
VerifResults::set_incorrect: ERROR
 - test/solc-verify/examples/VerifResults.sol:22:5: Postcondition 'x == x1' might not hold at end of function.
VerifResults::use_unsupported: OK
VerifResults::unsupported: SKIPPED
Use --show-warnings to see 3 warnings.
Some functions were skipped. Use --verbose to see details.
Errors were found by the verifier.
```

The `constructor` and `set_correct` are correct.
However, `set_incorrect` has a postcondition that can fail.
Furthermore, `unsupported` contains some unsupported features and is skipped.
Nevertheless, it is annotated so the function `use_unsupported` that calls it can still be proved correct.

## Publications

See a list of publications related to solc-verify at the [wiki](https://github.com/SRI-CSL/solidity/wiki/Publications).
