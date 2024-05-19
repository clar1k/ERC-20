// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ShavarmaCoin {
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) _allowances;
    uint256 totalSupply;

    constructor(uint256 initialSupply) {
        totalSupply = initialSupply;
        balances[msg.sender] += initialSupply;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public returns (bool success) {
        require(amount <= balances[sender], "Insufficient balance");
        require(
            amount <= allowance(sender, msg.sender),
            "Insufficient balance for allowance"
        );

        balances[sender] -= amount;
        balances[recipient] += amount;
        _allowances[sender][msg.sender] -= amount;

        return true;
    }

    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(balances[msg.sender] >= _value, "Insufficient balance");

        balances[msg.sender] -= _value;
        balances[_to] += _value;

        return true;
    }

    function balanceOf() public view returns (uint256) {
        return balances[msg.sender];
    }

    function name() public pure returns (string memory) {
        return "ShavarmaCoin";
    }

    function symbol() public pure returns (string memory) {
        return "SHAVA";
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function approve(
        address _spender,
        uint256 _value
    ) public returns (bool success) {
        require(balances[msg.sender] >= _value, "Insufficient balance");

        _allowances[msg.sender][_spender] += _value;
        return true;
    }

    function allowance(
        address _owner,
        address _spender
    ) public view returns (uint256 remaining) {
        return _allowances[_owner][_spender];
    }

    function mint(uint256 _amount) public {
        balances[msg.sender] += _amount;
    }
}
