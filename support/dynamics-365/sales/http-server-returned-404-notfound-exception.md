---
title: Http server returned 404 NotFound exception
description: When you try to test and enable a mailbox in Microsoft Dynamics 365, you receive an Http server returned 404 NotFound exception. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Http server returned 404 NotFound exception when using server-side synchronization in Microsoft Dynamics 365

This article provides a resolution for you to solve the error messages that may occur when you try to test and enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics C5 2016  
_Original KB number:_ &nbsp; 3214661

## Symptoms

When you test and enable a mailbox in Microsoft Dynamics 365 (formerly known as Microsoft Dynamics CRM Online), you encounter one of the following errors in the Alerts area:

- Mailbox \<Mailbox Name> didn't synchronize because an error occurred while connecting to the email server. The owner of the associated email server profile \<Email Server Profile Name> has been notified.
- Mailbox \<Mailbox Name> didn't synchronize appointments, contacts, and tasks because an error occurred while connecting to the Microsoft Exchange server. The owner of the associated email server profile \<Email Server Profile Name> has been notified.
- The email message **Test Message** cannot be sent because an error occurred while connecting to the email server. Mailbox \<Mailbox Name> didn't synchronize. The owner of the associated email server profile \<Email Server Profile Name> has been notified.

Each of the errors above, also include the following error code:

> Email Server Error Code: Http server returned 404 NotFound exception.

## Cause

This error can occur for one of the following reasons:

1. The mailbox for the user could not be found because the email address is not correct or the mailbox is not currently available.
2. The configuration of the associated Email Server Profile is not correctly configured to be able to locate the mailbox.

## Resolution

To fix this issue, use the following steps:

1. Verify the e-mail address of the mailbox record in Microsoft Dynamics 365 matches the e-mail address in Exchange. The error includes a link to the mailbox record in Microsoft Dynamics 365. You can use this link to quickly verify the **Email Address** field. If the email address is correct, verify the mailbox is available by opening it with your email application such as Microsoft Outlook or Outlook Web Access.
2. Verify the configuration of the associated Email Server Profile. If you are using Microsoft Dynamics 365 (online) with Exchange on-premises, make sure you are using an Exchange Server (Hybrid) email server profile. Only use an Exchange Online profile for users that have mailboxes in Exchange Online.

## More information

When you select **View Details**, you see error details like the following:

> ActivityId: \<GUID>  
> Error : System.Net.WebException: The request failed with HTTP status 404: Not Found.  
 at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)  
 at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)  
 at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeServiceBinding.EndFindItem(IAsyncResult asyncResult)  
 at Microsoft.Crm.Asynchronous.EmailConnector.FindItemsStep.EndCall()  
 at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeIncomingEmailProviderStep.EndOperation()

> ActivityId: \<GUID>  
> Error : System.Net.WebException: The request failed with HTTP status 404: Not Found.  
 at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)  
 at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)  
 at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeServiceBinding.EndCreateItem(IAsyncResult asyncResult)  
 at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeOutgoingEmailProvider.EndCreateItem()

> T:593  
> ActivityId: \<GUID>  
> Exception : Unhandled Exception: Microsoft.Exchange.WebServices.Data.ServiceRequestException: The request failed. The remote server returned an error: (404) Not Found.  
at Microsoft.Exchange.WebServices.Data.ServiceRequestBase.EndGetEwsHttpWebResponse(IEwsHttpWebRequest request, IAsyncResult asyncResult)  
at Microsoft.Exchange.WebServices.Data.SimpleServiceRequestBase.EndInternalExecute(IAsyncResult asyncResult)  
at Microsoft.Exchange.WebServices.Data.MultiResponseServiceRequest\`1.EndExecute(IAsyncResult asyncResult)  
at Microsoft.Exchange.WebServices.Data.ExchangeService.EndSyncFolderHierarchy(IAsyncResult asyncResult)  
at Microsoft.Crm.Asynchronous.EmailConnector.MonitoredExchangeService.EndSyncFolderHierarchy(IAsyncResult asyncResult)  
at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeSyncSteps.ExchangeSyncAsyncRemoteStep\`2.AfterCall()  
at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeSyncSteps.ExchangeSyncAsyncRemoteStep\`2.E...
