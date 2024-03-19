codeunit 50201 "BDL Sales Inv. Subscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post and Send", 'OnBeforePostAndSend', '', true, true)]
    local procedure "Sales-Post and Send_OnBeforePostAndSend"(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var TempDocumentSendingProfile: Record "Document Sending Profile")
    var
        BDLRentalSetup: Record "BDL Rental Setup";
    begin
        if not BDLRentalSetup.Get()then exit;
        if BDLRentalSetup.PostInvoices then if SalesHeader."No. Series" = BDLRentalSetup.PostNoSeries then If SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then begin
                    SalesHeader.Invoice:=true;
                    HideDialog:=true;
                    TempDocumentSendingProfile:=GetRentalDocumentSendingProfile();
                end;
    end;
    local procedure GetRentalDocumentSendingProfile(): Record "Document Sending Profile" var
        DocumentSendingProfile: Record "Document Sending Profile";
    begin
        if not DocumentSendingProfile.Get('Rentals')then begin
            DocumentSendingProfile.Init();
            DocumentSendingProfile.Code:='Rentals';
            DocumentSendingProfile.Description:='Rentals';
            DocumentSendingProfile."E-Mail":=DocumentSendingProfile."E-Mail"::"Yes (Use Default Settings)";
            DocumentSendingProfile.Insert();
        end;
        exit(DocumentSendingProfile);
    end;
}
