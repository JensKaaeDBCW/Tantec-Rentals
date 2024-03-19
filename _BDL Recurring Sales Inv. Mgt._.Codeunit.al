codeunit 50200 "BDL Recurring Sales Inv. Mgt."
{
    trigger OnRun()
    var
        BDLRentalSetup: Record "BDL Rental Setup";
    begin
        if not BDLRentalSetup.Get()then exit;
        If BDLRentalSetup.CreateInvoices then RunRecurringSalesInvoices();
        if BDLRentalSetup.PostInvoices then PostRecurringInvoices();
    end;
    local procedure RunRecurringSalesInvoices()
    var
        CreateRecurringSalesInv: Report "Create Recurring Sales Inv.";
        XMLParmTextLbl: Label '<?xml version="1.0" standalone="yes"?><ReportParameters name="Create Recurring Sales Inv." id="172"><Options><Field name="OrderDate">%1</Field><Field name="PostingDate">%1</Field></Options><DataItems><DataItem name="Standard Customer Sales Code">VERSION(1) SORTING(Field1, Field2) WHERE(Field50201 = 1(..%1))</DataItem></DataItems></ReportParameters>', Comment = '%1 = today', Locked = true;
    begin
        Clear(CreateRecurringSalesInv);
        CreateRecurringSalesInv.UseRequestPage(false);
        CreateRecurringSalesInv.Execute(StrSubstNo(XMLParmTextLbl, Format(Today, 0, 9)));
    end;
    local procedure PostRecurringInvoices()
    var
        SalesHeader: Record "Sales Header";
        BDLRentalSetup: Record "BDL Rental Setup";
    begin
        BDLRentalSetup.Get();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange("No. Series", BDLRentalSetup.PostNoSeries);
        If SalesHeader.FindSet()then repeat SalesHeader.SendToPosting(79);
            until SalesHeader.Next() = 0;
    end;
    procedure InitJobQueue()
    var
        BDLJobQueueMngmt: Codeunit "BDL Job Queue Mngmt";
        Recurrence: enum "BDL Job Q. Next Run Date Form.";
    begin
        BDLJobQueueMngmt.CreateModifyJobQueue(true, 50200, '', Recurrence::Daily);
    end;
    procedure StopJobQueue()
    var
        BDLJobQueueMngmt: Codeunit "BDL Job Queue Mngmt";
        Recurrence: enum "BDL Job Q. Next Run Date Form.";
    begin
        BDLJobQueueMngmt.CreateModifyJobQueue(false, 50200, '', Recurrence::Daily);
    end;
    [EventSubscriber(ObjectType::Table, Database::"Standard Customer Sales Code", 'OnBeforeApplyStdCodesToSalesLines', '', true, true)]
    local procedure "Standard Customer Sales Code_OnBeforeApplyStdCodesToSalesLines"(var SalesLine: Record "Sales Line"; StdSalesLine: Record "Standard Sales Line")
    var
        StandardCustomerSalesCode: Record "Standard Customer Sales Code";
    begin
        If SalesLine."Document Type" <> SalesLine."Document Type"::Invoice then exit;
        If StandardCustomerSalesCode.Get(SalesLine."Sell-to Customer No.", StdSalesLine."Standard Sales Code")then If StandardCustomerSalesCode."BDL Quantity" <> 0 then SalesLine.Quantity*=StandardCustomerSalesCode."BDL Quantity";
    end;
    //Change event to onafter postsalesdoc and identify by Numberseries or similar
    [EventSubscriber(ObjectType::Table, Database::"Standard Customer Sales Code", 'OnAfterApplyStdCodesToSalesLinesLoop', '', true, true)]
    local procedure "Standard Customer Sales Code_OnAfterApplyStdCodesToSalesLinesLoop"(var StdSalesLine: Record "Standard Sales Line"; var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; StdSalesCode: Record "Standard Sales Code")
    var
        StandardCustomerSalesCode: Record "Standard Customer Sales Code";
    begin
        If SalesHeader."Document Type" <> SalesHeader."Document Type"::Invoice then exit;
        If StandardCustomerSalesCode.Get(SalesHeader."Sell-to Customer No.", StdSalesCode.Code)then begin
            StandardCustomerSalesCode.Validate("BDL Last Inv. Date", SalesHeader."Posting Date");
            StandardCustomerSalesCode.Modify(true);
        end;
    end;
}
