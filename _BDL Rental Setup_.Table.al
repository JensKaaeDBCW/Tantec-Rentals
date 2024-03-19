table 50200 "BDL Rental Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Rental Setup';

    fields
    {
        field(1; PK; Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(10; PostNoSeries; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting No. Series';
            TableRelation = "No. Series".Code;
        }
        field(20; CreateInvoices; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Auto Create Invoices';
        }
        field(21; PostInvoices; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Auto Post Invoices';

            trigger OnValidate()
            begin
                if PostInvoices then TestField(PostNoSeries);
            end;
        }
    }
    keys
    {
        key(PK; PK)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
}
