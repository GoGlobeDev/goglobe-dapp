## GOG Token 合约详细文档 ##

### 公开成员变量 ###

````solidity
string public name
string public symbol
uint8 public decimals
uint256 public totalSupply
````

This creates an array with all balances
````solidity
mapping (address => uint256) public balances;
````

This creates an 2 x 2 array with allowances
````solidity
mapping (address => mapping (address => uint256)) public allowance;
````

This creates an array with all frozenFunds
````solidity
mapping (address => uint256) public frozenFunds;
````

### Functions ###
  1. 执行方法
    ````solidity
    function freezeAccount
    ````
    ````solidity
    function unFreezeAccount
    ````
    ````solidity
    function approve
    ````
    ````solidity
    function transfer
    ````
    ````solidity
    function transferFrom
    ````
    ````solidity
    function burn
    ````
    ````solidity
    function burnFrom
    ````
  2. 读取方法
    ````solidity
    function balanceOf
    ````
    ````solidity
    function allowance
    ````
    ````solidity
    function frozenFundsOf
    ````

### Events ###
  ````solidity
  event FrozenFunds
  ````
  ````solidity
  event UnFrozenFunds
  ````
  ````solidity
  event Transfer
  ````
  ````solidity
  event Burn
  ````
  ````solidity
  event Approval
  ````
