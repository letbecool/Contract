pragma solidity ^0.4.0;


contract AssetLedger {
    function AssetLedger(){}

    function(){}

    Asset[] public arr_of_asset;

    struct Asset {

    bytes32 assetTokenHash;
    uint purchaseprice;
    bytes32 payloadHash;
    uint timestamp;
    uint assetID;

    }

    function addAsset(bytes32 _assetTokenHash, uint _purchaseprice, bytes32 _payloadHash, uint _timestamp, uint _assetID)returns (bool){

        Asset memory newAsset;
        newAsset.assetTokenHash = _assetTokenHash;
        newAsset.purchaseprice = _purchaseprice;
        newAsset.payloadHash = _payloadHash;
        newAsset.timestamp = _timestamp;
        newAsset.assetID = _assetID;
        arr_of_asset.push(newAsset);
        return (true);

    }

    function getAllAssets() constant returns (bytes32[], uint[], uint[]){

        uint length = arr_of_asset.length;
        bytes32[] memory arr_assetTokenHash = new bytes32[](length);
        uint[] memory arr_timestamp = new uint[](length);
        uint[] memory arr_purchaseprice = new uint[](length);
        Asset memory currentAsset;
        for (uint i = 0; i < arr_of_asset.length; i++) {
            currentAsset = arr_of_asset[i];

            arr_assetTokenHash[i] = currentAsset.assetTokenHash;
            arr_timestamp[i] = currentAsset.timestamp;
            arr_purchaseprice[i] = currentAsset.purchaseprice;

        }
        return (arr_assetTokenHash, arr_timestamp, arr_purchaseprice);

    }


    function getAssetDetail(bytes32 _assetTokenHash) constant returns (uint, uint){


        Asset memory currentAsset;
        bytes32 temp_assetTokenHash;
        for (uint i = 0; i < arr_of_asset.length; i++) {
            currentAsset = arr_of_asset[i];
            temp_assetTokenHash = currentAsset.assetTokenHash;
            if (temp_assetTokenHash == _assetTokenHash) {
                return (currentAsset.timestamp, currentAsset.purchaseprice);
            }
        }

        return (0, 0);


    }

    function getAssetByTimeRange(uint _start, uint _end) constant returns (bytes32[], uint[], uint[]){


        /*
       start and end time must be sent from the Dapp interface.
        Only thing here doing is if timestamp of any transaction lies between  start and end
        would be displayed .
        */
        uint length = arr_of_asset.length;
        bytes32[] memory arr_assetTokenHash = new bytes32[](length);
        uint[] memory arr_timestamp = new uint[](length);
        uint[] memory arr_purchaseprice = new uint[](length);


        Asset memory currentAsset;
        uint temp_timestamp;
        for (uint i = 0; i < arr_of_asset.length; i++) {
            currentAsset = arr_of_asset[i];
            temp_timestamp = currentAsset.timestamp;
            if ((temp_timestamp >= _start) && (temp_timestamp <= _end)) {


                arr_assetTokenHash[i] = currentAsset.assetTokenHash;
                arr_timestamp[i] = currentAsset.timestamp;
                arr_purchaseprice[i] = currentAsset.purchaseprice;


            }
        }

        return (arr_assetTokenHash, arr_timestamp, arr_purchaseprice);


    }


    function verifyPayloadByToken(bytes32 _payloadHash, bytes32 _assetTokenHash) constant returns (bool){

        Asset memory currentAsset;
        bytes32 temp_assetTokenHash;
        bytes32 temp_payloadHash;

        for (uint i = 0; i < arr_of_asset.length; i++) {

            currentAsset = arr_of_asset[i];
            temp_assetTokenHash = currentAsset.assetTokenHash;
            temp_payloadHash = currentAsset.payloadHash;
            if ((temp_assetTokenHash == _assetTokenHash) && (temp_payloadHash == _payloadHash)) {

                return true;
            }

        }
        return false;
    }

    function verifyPayloadByID(bytes32 _payloadHash, uint _assetID) constant returns (bool){

        Asset memory currentAsset;
        uint temp_assetID;
        bytes32 temp_payloadHash;

        for (uint i = 0; i < arr_of_asset.length; i++) {

            currentAsset = arr_of_asset[i];
            temp_assetID = currentAsset.assetID;
            temp_payloadHash = currentAsset.payloadHash;
            if ((temp_assetID == _assetID) && (temp_payloadHash == _payloadHash)) {

                return true;
            }

        }
        return false;

    }

}