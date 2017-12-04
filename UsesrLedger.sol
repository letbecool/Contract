contract UserLedger {
    struct Employee {
        bytes32 firstname;
        bytes32 lastname;
        bytes32 role;
        bytes32 title;
        bytes32 biometricHash;
    }
    mapping(uint => Employee) listEmp;
    address superAdmin;
    mapping(address => bool) isAdmin;
    uint employeeCounter;
    
    function UserLedger(){
        isAdmin[msg.sender] = true;
        superAdmin = msg.sender;
    }

    function() {
        revert();
    }
    event NewEmployee(uint indexed empID, bytes32 indexed firstname, bytes32 indexed lastname, bytes32 role, bytes32 title);
    
    function addAdmin(address _newAdmin){
        assert(msg.sender == superAdmin);
        isAdmin[_newAdmin] = true;
    }
    
    function removeAdmin(address _newAdmin){
        assert(msg.sender == superAdmin);
        isAdmin[_newAdmin] = false;
    }
    
    function addEmployee(bytes32 _firstname, bytes32 _lastname, bytes32 _role, bytes32 _title, bytes32 _biometrichash) returns (bool success){
        assert(isAdmin[msg.sender]);
        uint empID = employeeCounter++;
        listEmp[empID].firstname = _firstname;
        listEmp[empID].lastname = _lastname;
        listEmp[empID].role = _role;
        listEmp[empID].title = _title;
        listEmp[empID].biometricHash = _biometrichash;
        NewEmployee(employeeCounter, _firstname, _lastname, _role, _title);
        return true;
    }
 function getEmployees(uint _from, uint _to) constant returns (uint[], bytes32[], bytes32[], bytes32[], bytes32[]){
        assert((_to > _from) && (_to <= employeeCounter));
        uint length = _to - _from;
        uint[] memory arr_empid = new uint[](length);
        bytes32[] memory arr_firstname = new bytes32[](length);
        bytes32[] memory arr_lastname = new bytes32[](length);
        bytes32[] memory arr_role = new bytes32[](length);
        bytes32[] memory arr_title = new bytes32[](length);
        Employee memory currentEmployee;
        for (uint i = _from; i <= _to; i++) {
            currentEmployee = listEmp[i];
            arr_empid[i] = i;
            arr_firstname[i] = currentEmployee.firstname;
            arr_lastname[i] = currentEmployee.lastname;
            arr_role[i] = currentEmployee.role;
            arr_title[i] = currentEmployee.title;
        }
        return (arr_empid, arr_firstname, arr_lastname, arr_role, arr_title);
    }

    function getEmployeeByID(uint _empid) constant returns (uint empid, bytes32 firstname, bytes32 lastname, bytes32 role, bytes32 title, bytes32 biometricHash){
        Employee memory currentEmployee;
        currentEmployee = listEmp[_empid];
        return (_empid, currentEmployee.firstname, currentEmployee.lastname, currentEmployee.role, currentEmployee.title, currentEmployee.biometricHash);
    }

    function getBiometricHash(uint _empid) constant returns (bytes32){
        return listEmp[_empid].biometricHash;
    }

}




/*     
this might save some gas

uint[length] memory arr_empid;
        bytes32[length] memory arr_firstname;
        bytes32[length] memory arr_lastname;
        bytes32[length] memory arr_role;;
        bytes32[length] memory arr_title;

*/