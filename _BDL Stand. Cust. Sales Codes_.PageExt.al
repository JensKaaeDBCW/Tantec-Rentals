pageextension 50200 "BDL Stand. Cust. Sales Codes" extends "Standard Customer Sales Codes"
{
    layout
    {
        addlast(Control1)
        {
            field("BDL Last Inv. Date"; Rec."BDL Last Inv. Date")
            {
                ApplicationArea = All;
                ToolTip = 'The Last invoice date';
            }
            field("BDL Invoice Interval"; Rec."BDL Invoice Interval")
            {
                ApplicationArea = All;
                ToolTip = 'The Time periode in which invoices should be issued.';
            }
            field("BDL Next Inv. Date"; Rec."BDL Next Inv. Date")
            {
                ApplicationArea = All;
                ToolTip = 'Then planned next invoice date';
            }
            field("BDL Quantity"; Rec."BDL Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'The total quantity of the sales code line including all lines inside. This field will scale the whole set of sales line up accorindgly.';
            }
        }
    }
}
