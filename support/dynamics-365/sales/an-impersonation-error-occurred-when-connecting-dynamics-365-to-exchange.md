---
title: An impersonation error occurred when connecting Dynamics 365 to Exchange
description: You may receive an error that states an impersonation error occurred in accessing the mailbox while sending or receiving the email when connecting Microsoft Dynamics 365 to Exchange Server on-premises. Provides a resolution.
ms.reviewer:  
ms.topic: troubleshooting
ms.date: 
---
# An impersonation error occurred when connecting Microsoft Dynamics 365 to Exchange Server on-premises

This article provides a resolution for the issue that you may receive an error that states **An impersonation error occurred in accessing the mailbox while sending the email message "Test Message"** when trying to enable a mailbox.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 3189639

## Symptoms

When Server-Side Synchronization is configured between Microsoft Dynamics 365 (online) and Microsoft Exchange Server (on-premises), you receive one of the following errors after attempting to enable a mailbox:

> An impersonation error occurred in accessing the mailbox while sending the email message "Test Message". Mailbox \<Mailbox name> didn't synchronize. The owner of the associated email server profile \<Email Server Profile name> has been notified.

> An impersonation error occurred in accessing the mailbox while receiving email. \<Mailbox name> didn't synchronize. The owner of the associated email server profile \<Email Server Profile name> has been notified.

When you select **Details** for one of the errors mentioned above, you may see details such as the following:

> ActivityId: \<GUID>  
\>Error : System.Web.Services.Protocols.SoapException: The account does not have permission to impersonate the requested user.  
at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)  
at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)  
at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeServiceBinding.EndFindItem(IAsyncResult asyncResult)  
at Microsoft.Crm.Asynchronous.EmailConnector.FindItemsStep.EndCall()  
at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeIncomingEmailProviderStep.EndOperation()ActivityId: \<GUID>  
\>Error : System.Web.Services.Protocols.SoapException: The account does not have permission to impersonate the requested user.  
at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)  
at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)  
at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeServiceBinding.EndCreateItem(IAsyncResult asyncResult)  
at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeOutgoingEmailProvider.EndCreateItem()

## Cause

This error can appear if the user account specified to access the mailbox does not have impersonation permissions for the mailbox. The account used to access the mailbox is provided within the Email Server Profile record associated with the Mailbox record in Microsoft Dynamics 365.

## Resolution

Make sure the user account provided in the Email Server Profile record has impersonation permissions to each associated mailbox. Within a mailbox record in Microsoft Dynamics 365, you can select the Server Profile value and review which account is provided within the Credentials section of the Email Server Profile record.

For more information on configuring Exchange impersonation, see:

- [Configure impersonation](/exchange/client-developer/exchange-web-services/how-to-configure-impersonation)
- [Configuring Exchange Impersonation in Exchange 2010](/previous-versions/office/developer/exchange-server-2010/bb204095(v=exchg.140))
- [Impersonation and EWS in Exchange](/exchange/client-developer/exchange-web-services/impersonation-and-ews-in-exchange)
