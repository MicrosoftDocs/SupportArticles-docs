---
title: GeneralIncomingEmailServerError when installing Dynamics 365 App for Outlook
description: GeneralIncomingEmailServerError when you try to install Microsoft Dynamics 365 App for Outlook with Exchange Server on-premises.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# GeneralIncomingEmailServerError when trying to install Microsoft Dynamics 365 App for Outlook

This article provides a resolution for the issue that you may receive the GeneralIncomingEmailServerError error when trying to install Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4019040

## Symptoms

When you attempt to install Microsoft Dynamics 365 App for Outlook, you encounter the following error:

> There was an issue when attempting to add the app to Outlook.
>
> SoapException : GeneralIncomingEmailServerError

If you select the **Details** link, the following additional details appear:

> Error : System.Web.Services.Protocols.SoapException: The specified server version is invalid. at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall) at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult) at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeServiceBinding.EndInstallApp(IAsyncResult asyncResult) at Microsoft.Crm.Asynchronous.EmailConnector.OfficeAppsDeploymentStep.EndCall() at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeIncomingEmailProviderStep.EndOperation()

## Cause

This error can occur if you are using Exchange on-premises and the version does not meet the requirements.

## Resolution

Verify the version of Exchange on-premises you are using meets the requirements documented in [Supported configurations with Microsoft Exchange](/dynamics365/outlook-app/v8/deploy-dynamics-365-app-for-outlook#supported-configurations-with-microsoft-exchange).

> [!NOTE]
> If the user's mailbox is on a supported version of Microsoft Exchange but your organization has migrated from an earlier version of Exchange such as Exchange Server 2010, this error may occur if you have not migrated your system mailboxes. For more information on moving system mailboxes, see [Move the Exchange 2010 system mailbox to Exchange 2013](/exchange/move-the-exchange-2010-system-mailbox-to-exchange-2013-exchange-2013-help).
