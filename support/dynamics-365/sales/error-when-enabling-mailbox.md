---
title: Error when enabling a mailbox
description: Provides a solution to an error that occurs when you try to connect Microsoft Dynamics CRM Online to Exchange on-premises.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Credentials specified in the associated email server profile are incorrect or have insufficient permissions error when connecting Microsoft Dynamics CRM Online to Exchange on-premises

This article provides a solution to an error that occurs when you try to connect Microsoft Dynamics CRM Online to Exchange on-premises.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 3189622

## Symptoms

When Server-Side Synchronization is configured between Microsoft Dynamics CRM Online and Exchange Server (on-premises), you receive one of the following errors after attempting to enable a mailbox:

> - The email message "Test Message" cannot be sent because the credentials specified in the associated email server profile are incorrect or have insufficient permissions for sending email. The owner of the email server profile \<Email Server Profile name> has been notified.
> - Email cannot be received because the credentials specified in the associated email server profile are incorrect or have insufficient permissions for receiving email. Mailbox \<Mailbox name> didn't synchronize. A notification about this is posted on the alerts wall for the owner of the email server profile \<Email Server Profile name>.

## Cause

This error can occur if Exchange Web Services (EWS) isn't enabled for Basic Authentication.

## Resolution

Enable Basic Authentication on your EWS (Exchange Web Services) directory. Basic authentication isn't the default for EWS, so you need to make sure this authentication is enabled.

For more information about Basic authentication, see:

- Exchange Server 2010: [Configure Basic Authentication](/previous-versions/office/exchange-server-2010/aa996407(v=exchg.141))
- Exchange Server 2010: [Default Authentication Settings for Exchange-related Virtual Directories](/previous-versions/office/exchange-server-2010/gg247612(v=exchg.141))
- Exchange Server 2013: [Authentication and EWS in Exchange](/exchange/client-developer/exchange-web-services/authentication-and-ews-in-exchange)
- Exchange Server 2013: [Default settings for Exchange virtual directories](/exchange/default-settings-for-exchange-virtual-directories-exchange-2013-help)

## More information

When you select **Details** for one of the errors mentioned above, you may see details such as the following example:

- > ActivityId: \<GUID>  
    \>Error : System.Net.WebException: The request failed with HTTP status 401: Anonymous Request Disallowed.  
    at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)  
    at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)  
    at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeServiceBinding.EndFindItem(IAsyncResult asyncResult)  
    at Microsoft.Crm.Asynchronous.EmailConnector.FindItemsStep.EndCall()  
    at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeIncomingEmailProviderStep.EndOperation()
- > ActivityId: \<GUID>
    \>Error : System.Net.WebException: The request failed with HTTP status 401: Anonymous Request Disallowed.  
    at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)  
    at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)  
    at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeServiceBinding.EndCreateItem(IAsyncResult asyncResult)  
    at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeOutgoingEmailProvider.EndCreateItem()
