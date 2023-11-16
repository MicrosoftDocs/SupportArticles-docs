---
title: Web server returned SecureChannelFailure
description: Describes an error that occurs in Microsoft Dynamics 365 mailbox alert.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Web server returned SecureChannelFailure exception error appears in Microsoft Dynamics 365 mailbox alert

This article provides a solution to an error that occurs in Microsoft Dynamics 365 mailbox alert.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4533252

## Symptoms

An alert like the following example is logged in a Dynamics 365 mailbox record:

> "Email cannot be received for the mailbox [Mailbox Name] because an error occurred while establishing a secure connection to the email server. The mailbox didn't synchronize. A notification about this is posted on the alerts wall for the owner of the email server profile [Email Server Profile Name]"  
Email Server Error Code: Web server returned SecureChannelFailure exception."

If you select **Details**, you see the following additional information:

> ActivityId: [GUID]  
    \>Error : System.Net.WebException: **The request was aborted: Could not create SSL/TLS secure channel.**  
    at System.Web.Services.Protocols.WebClientAsyncResult.WaitForResponse()  
    at System.Web.Services.Protocols.WebClientProtocol.EndSend(IAsyncResult asyncResult, Object& internalAsyncState, Stream& responseStream)  
    at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)  
    at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeServiceBinding.EndFindFolder(IAsyncResult asyncResult)  
    at Microsoft.Crm.Asynchronous.EmailConnector.FindSearchFolderStep.EndCall()  
    at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeIncomingEmailProviderStep.EndOperation()

## Cause

It typically indicates an SSL or TLS configuration issue. One potential cause is a known issue that can occur when connecting Dynamics 365 Online to an Exchange on-premises environment that is located behind an F5 (BIG-IP) system.

## Resolution

If your configuration goes through an F5 (BIG-IP) system, see [K40424522: The BIG-IP system may fail to process the SSL/TLS handshake correctly if the client application uses Microsoft Schannel TLS library](https://support.f5.com/csp/article/K40424522).
