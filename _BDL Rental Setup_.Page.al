page 50200 "BDL Rental Setup"
{
    Caption = 'Rental Setup';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BDL Rental Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(CreateInvoices; Rec.CreateInvoices)
                {
                    ApplicationArea = All;
                    ToolTip = 'Automatically create recurring invoices daily';
                }
                field(PostNoSeries; Rec.PostNoSeries)
                {
                    ApplicationArea = All;
                    ToolTip = 'For an alternative posting No. Series';
                }
                field(PostInvoices; Rec.PostInvoices)
                {
                    ApplicationArea = All;
                    ToolTip = 'Automatic posting of recurring invoices. Requires as alternative posting no. series.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(StartJobQueue)
            {
                ApplicationArea = All;
                Caption = 'Initiate Job Queue';
                ToolTip = 'Initiates the Job Queue Entry for Rental Invoicing';
                Image = Start;

                trigger OnAction()
                begin
                    BDLRecurringSalesInvMgt.InitJobQueue();
                end;
            }
            action(StopJobQueue)
            {
                ApplicationArea = All;
                Caption = 'Stop Job Queue';
                ToolTip = 'Stops the job queue for Rental invoicing';
                Image = Stop;

                trigger OnAction()
                begin
                    BDLRecurringSalesInvMgt.StopJobQueue();
                end;
            }
        }
    }
    var BDLRecurringSalesInvMgt: Codeunit "BDL Recurring Sales Inv. Mgt.";
    trigger OnOpenPage()
    begin
        If not Rec.Get()then Rec.Insert();
    end;
}
