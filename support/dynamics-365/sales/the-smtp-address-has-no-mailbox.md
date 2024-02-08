---
title: The SMTP address has no mailbox
description: Provides a solution to an error that occurs when you select Test Connection on an Email Server Profile record in Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# The SMTP address has no mailbox associated with it error occurs in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you select **Test Connection** on an Email Server Profile record in Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 3214326

## Symptoms

When you select **Test Connection** on an Email Server Profile record in Dynamics 365, you meet a Test Failed error. The Failure Details section contains the following message:

> "The SMTP address has no mailbox associated with it."

## Cause

This error can occur if you use the format `domain\username` for the User Name (Example: `contoso\user`).

## Resolution

Within the Credentials section of the Email Server Profile record, use the UPN format (Example: `user@contoso.com`) for the User Name instead of `domain\username` format.

If the User Name is in the UPN format and you still meet this error, verify a mailbox exists for the user and the UPN value in the User Name field matches the email address for the user's mailbox in Exchange.

## More information

The following example is the Failure Details that will appear:

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
