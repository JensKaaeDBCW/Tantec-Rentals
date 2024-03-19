tableextension 50200 "BDL Standard Cust. Sales Code" extends "Standard Customer Sales Code"
{
    fields
    {
        field(50200; "BDL Last Inv. Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Invoice Date';

            trigger OnValidate()
            begin
                Validate("BDL Next Inv. Date", CalcDate("BDL Invoice Interval", "BDL Last Inv. Date"));
            end;
        }
        field(50201; "BDL Next Inv. Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Next Invoice Date';
        }
        field(50202; "BDL Invoice Interval"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Interval';

            trigger OnValidate()
            begin
                if "BDL Last Inv. Date" <> 0D then Validate("BDL Next Inv. Date", CalcDate("BDL Invoice Interval", "BDL Last Inv. Date"));
            end;
        }
        field(50203; "BDL Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
            MinValue = 1;
        }
    }
}
