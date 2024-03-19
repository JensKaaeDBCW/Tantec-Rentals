permissionset 50201 "BDL Rental User"
{
    Assignable = true;
    Permissions = tabledata "BDL Rental Setup"=R,
        codeunit "BDL Job Queue Mngmt"=X;
}
