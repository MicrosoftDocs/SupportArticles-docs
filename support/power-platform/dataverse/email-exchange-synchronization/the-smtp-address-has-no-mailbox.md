---
title: SMTP address has no mailbox associated with it error
description: Solves an SMTP address error that occurs when you select Test Connection on an email server profile record in Dynamics 365.
ms.reviewer: 
ms.date: 12/11/2024
ms.custom: sap:Email and Exchange Synchronization
---
# "The SMTP address has no mailbox associated with it" error when selecting Test Connection

This article provides a solution to an error that occurs when you select **Test Connection** on an email server profile record in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 3214326

## Symptoms

When you [test connection on an email server profile record](/power-platform/admin/connect-exchange-server-on-premises#create-an-email-server-profile) in Dynamics 365, a "Test Failed" error occurs. The **Failure Details** section shows the following message:

> The SMTP address has no mailbox associated with it.

## Cause

This error can occur if the **User Name** field in the email server profile record is populated using the `domain\username` format instead of the UPN format (for example, `contoso\user`).

## Resolution

Use the UPN format (for example, `user@contoso.com`) for the **User Name** field instead of the `domain\username` format in the **Credentials** section of the email server profile record.

If the user name is in the UPN format and you still receive this error, verify that the user has a mailbox and that the UPN value in the **User Name** field matches the email address for the user's mailbox in Exchange.

## More information

The following is an example of the error message and additional information about the failure shown in the **Failure Details** section:

```xml
Request to Exchange::  
\<Trace Tag="EwsRequestHttpHeaders" Tid="534" Time="\<Date>">  
POST /EWS/Exchange.asmx HTTP/1.1  
Content-Type: text/xml; charset=utf-8  
Accept: text/xml  
User-Agent: ExchangeServicesClient/15.00.1076.004  
Accept-Encoding: gzip,deflate  

</Trace>
<Trace Tag="EwsRequest" Tid="534" Time="\<Date>" Version="15.00.1076.004">
  <?xml version="1.0" encoding="utf-8"?>
  <soap:Envelope xmlns:xsi="https://www.w3.org/2001/XMLSchema-instance" xmlns:m="https://schemas.microsoft.com/exchange/services/2006/messages" xmlns:t="https://schemas.microsoft.com/exchange/services/2006/types" xmlns:soap="https://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
      <t:RequestServerVersion Version="Exchange2010" />
      <t:ExchangeImpersonation>
        <t:ConnectingSID>
          <t:SmtpAddress>domain\username</t:SmtpAddress>
        </t:ConnectingSID>
      </t:ExchangeImpersonation>
    </soap:Header>
    <soap:Body>
      <m:FindFolder Traversal="Shallow">
        <m:FolderShape>
          <t:BaseShape>AllProperties</t:BaseShape>
        </m:FolderShape>
        <m:IndexedPageFolderView MaxEntriesReturned="1" Offset="0" BasePoint="Beginning" />
        <m:ParentFolderIds>
          <t:DistinguishedFolderId Id="inbox" />
        </m:ParentFolderIds>
      </m:FindFolder>
    </soap:Body>
  </soap:Envelope>
</Trace>

Response from Exchange:  
\<Trace Tag="EwsResponseHttpHeaders" Tid="534" Time="2016-12-19 19:00:22Z">
HTTP/1.1 500 Internal Server Error  
...

</Trace>
<Trace Tag="EwsResponse" Tid="534" Time="2016-12-19 19:00:22Z" Version="15.00.1076.004">
  <?xml version="1.0" encoding="utf-8"?>
  <s:Envelope xmlns:s="https://schemas.xmlsoap.org/soap/envelope/">
    <s:Body>
      <s:Fault>
        <faultcode xmlns:a="https://schemas.microsoft.com/exchange/services/2006/types">a:ErrorNonExistentMailbox>
        <faultstring xml:lang="en-US">The SMTP address has no mailbox associated with it.</faultstring>
        <detail>
          <e:ResponseCode xmlns:e="https://schemas.microsoft.com/exchange/services/2006/errors">ErrorNonExistentMailbox>
          <e:Message xmlns:e="https://schemas.microsoft.com/exchange/services/2006/errors">The SMTP address has no mailbox associated with it.</e:Message>
          <t:MessageXml xmlns:t="https://schemas.microsoft.com/exchange/services/2006/types">
            <t:Value Name="SmtpAddress">domain\username</t:Value>
          </t:MessageXml>
        </detail>
      </s:Fault>
    </s:Body>
  </s:Envelope>
</Trace>
```
