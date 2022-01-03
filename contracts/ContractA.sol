pragma solidity ^0.4.0;

contract ContractA {
    function details() pure public returns (string, string) {
        return('FIDO', 'Web multisig Fidosafe.com');
    }
}
