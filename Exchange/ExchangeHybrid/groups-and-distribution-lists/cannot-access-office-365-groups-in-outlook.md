---
title: Cannot access Office 365 groups in Outlook
description: Describes an issue that prevents users in an Exchange hybrid deployment from accessing Office 365 groups through Outlook 2016, Outlook 2019, and Outlook for Office 365. Provides a solution.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Hybrid
- CSSTroubleshoot
ms.reviewer: joelric
appliesto:
- Exchange Online
- Outlook 2019
- Outlook 2016
- Outlook for Office 365
search.appverid: MET150
---
# Users in an Exchange hybrid deployment can't access Office 365 groups in Outlook 2016, Outlook 2019, and Outlook for Office 365

_Original KB number:_ &nbsp; 3168347

## Symptoms

You have a hybrid deployment of Exchange Online in Office 365 and on-premises Exchange Server. In this situation, your Autodiscover record resolves to an on-premises Exchange server, and users' mailboxes are in Exchange Online. When you create an Office 365 group in this scenario, users can't access the group through Microsoft Outlook 2016, Outlook 2019, or Outlook for Office 365. However, users can access the group through Outlook on the web.

## Cause

This issue occurs if the primary SMTP address of the Office 365 Group uses an incorrect format. For example: \<Office365GroupName>@contoso.com.

Modern groups use an Autodiscover XML file that's located in the *%LocalAppData%\Microsoft\Outlook\16* folder. The primary SMTP address of the group should use the following format:

AutoD.<Office365*GroupName*>@contoso.mail.onmicrosoft.com

If the primary SMTP address of the group is <Office365*GroupName*>@contoso.com, the Autodiscover request fails because no object exists in the on-premises environment that represents the group.

## Resolution

Change the primary SMTP address of the Office 365 group. To do this, run the following Windows PowerShell command:

```powershell
Set-UnifiedGroup Alias -PrimarySmtpAddress <Office365GroupName>@contoso.mail.onmicrosoft.com
```

## More information

For more information, see [Manage Office 365 Groups with PowerShell](/microsoft-365/enterprise/manage-microsoft-365-groups-with-powershell?view=o365-worldwide&preserve-view=true).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
