permissionset 50200 "BDL Rental Admin"
{
    Assignable = true;
    Caption = 'Rental Admin';
    Permissions = tabledata "BDL Rental Setup"=RMID,
        codeunit "BDL Recurring Sales Inv. Mgt."=X;
}
