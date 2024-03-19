reportextension 50200 "BDL Create Recur. Sales Inv." extends "Create Recurring Sales Inv."
{
    dataset
    {
        modify("Standard Customer Sales Code")
        {
        RequestFilterFields = "Customer No.", Code, "BDL Next Inv. Date";
        }
    }
}
