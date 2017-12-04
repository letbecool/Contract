pragma solidity ^0.4.0;


contract TransactionLedger {

    function TransactionLedger(){}

    function(){}

    /*
    setting counter transaction Id initially 0 . and  increment  each time by one when function  registerTransaction() is called.
    Increment is done inside the function registerTransaction()
    */
    uint public  counterTransctionID = 0;

    Transaction[] public arr_of_transaction;

    struct Transaction {
    uint transactionID;
    bytes32 assetTokenHash;
    uint empid;
    bytes32 payloadHash;
    bytes32 transactionCode;
    uint timestamp;

    }
    /*

    To register in transaction , we have to verify that
    employeeID(from UserLedger),assetTokenHash and payloadHash(from AssetLedger)
     have to be registered already in blockchain .

    */
    function registerTransaction(bytes32 _assetTokenHash, uint _empid, bytes32 _payloadHash, bytes32 _transactionCode, uint _timestamp) returns (uint){

        Transaction  memory newTransaction;
        newTransaction.assetTokenHash = _assetTokenHash;
        newTransaction.empid = _empid;
        newTransaction.payloadHash = _payloadHash;
        newTransaction.transactionCode = _transactionCode;
        newTransaction.timestamp = _timestamp;
        newTransaction.transactionID = counterTransctionID;

        // checkValidationForTransaction(_assetTokenHash, _empid, _payloadHash);
        /*

    To register in transaction , we have to verify that
    employeeID(from UserLedger),assetTokenHash and payloadHash(from AssetLedger)
     have to be registered already in blockchain .

    */

        counterTransctionID++;
        arr_of_transaction.push(newTransaction);


        return (counterTransctionID--);
    }

    function getAllTransactions() constant returns (uint[], bytes32[], uint[], bytes32[], bytes32[], uint[]){

        uint length = arr_of_transaction.length;
        uint[] memory arr_transactionID = new uint[](length);
        bytes32[] memory arr_assetTokenHash = new bytes32[](length);
        uint[] memory arr_empid = new uint[](length);
        uint[] memory arr_timestamp = new uint[](length);
        bytes32[] memory arr_payloadHash = new bytes32[](length);
        bytes32[] memory arr_transactionCode = new bytes32[](length);
        Transaction memory currentTransaction;
        for (uint i = 0; i < arr_of_transaction.length; i++) {
            currentTransaction = arr_of_transaction[i];
            arr_assetTokenHash[i] = currentTransaction.assetTokenHash;
            arr_empid[i] = currentTransaction.empid;
            arr_payloadHash[i] = currentTransaction.payloadHash;
            arr_timestamp[i] = currentTransaction.timestamp;
            arr_transactionCode[i] = currentTransaction.transactionCode;
            arr_transactionID[i] = currentTransaction.transactionID;
        }
        return (arr_transactionID, arr_assetTokenHash, arr_empid, arr_payloadHash, arr_transactionCode, arr_timestamp);
    }

    function verifyTransactionByTxCode(bytes32 _assetTokenHash, bytes32 _payloadHash) constant returns (uint[], uint[]){

        uint length = arr_of_transaction.length;

        uint[] memory arr_empid = new uint[](length);
        uint[] memory arr_timestamp = new uint[](length);
        Transaction memory currentTransaction;
        bytes32 temp_assetTokenHash;
        bytes32 temp_payloadHash;

        for (uint i = 0; i < arr_of_transaction.length; i++) {
            currentTransaction = arr_of_transaction[i];
            temp_assetTokenHash = currentTransaction.assetTokenHash;
            temp_payloadHash = currentTransaction.payloadHash;
            if ((_assetTokenHash == temp_assetTokenHash) && (_payloadHash == temp_payloadHash)) {
                arr_empid[i] = currentTransaction.empid;
                arr_timestamp[i] = currentTransaction.timestamp;

            }

        }
        return (arr_timestamp, arr_empid);

    }

    function getTransactionByEmpID(uint _empid, uint _start, uint _end) constant returns (bytes32[], bytes32[], bytes32[], uint[]) {

        uint length = arr_of_transaction.length;
        bytes32[] memory arr_assetTokenHash = new bytes32[](length);
        uint[] memory arr_timestamp = new uint[](length);
        bytes32[] memory arr_payloadHash = new bytes32[](length);
        bytes32[] memory arr_transactionCode = new bytes32[](length);

        Transaction  memory currentTransaction;
        //uint temp_empid;
        uint temp_timestamp;

        for (uint i = 0; i < arr_of_transaction.length; i++) {
            currentTransaction = arr_of_transaction[i];
            temp_timestamp = currentTransaction.timestamp;
            if (_empid == currentTransaction.empid) {
                if ((temp_timestamp >= _start) && (temp_timestamp <= _end)) {


                    arr_assetTokenHash[i] = currentTransaction.assetTokenHash;
                    arr_timestamp[i] = currentTransaction.timestamp;
                    arr_payloadHash[i] = currentTransaction.payloadHash;
                    arr_transactionCode[i] = currentTransaction.transactionCode;


                }
            }
        }


        return (arr_assetTokenHash, arr_payloadHash, arr_transactionCode, arr_timestamp);


    }


    function verifyPayloadByID(bytes32 _payloadHash, uint _assetID) constant returns (bool){

        checkValidationForAssetID(_assetID);


return true;

}


function checkValidationForTransaction(bytes32 _assetTokenHash, uint _empid, bytes32 _payloadHash){


}
function checkValidationForAssetID(uint _assetID){


}
}
