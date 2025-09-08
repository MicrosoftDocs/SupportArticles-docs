---
title: Users in a hybrid deployment can't access a shared mailbox in Exchange Online
description: Describes an issue in which users in an Exchange hybrid deployment are unable to access, view free/busy information, or send mail to a shared mailbox that was created in Exchange Online.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
manager: dcscontentpm
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Users in a hybrid deployment can't access a shared mailbox that was created in Exchange Online

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard. For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://blogs.technet.com/b/exchange/archive/2016/02/17/office-365-hybrid-configuration-wizard-for-exchange-2010.aspx).

## Problem

Consider the following scenario:

- You have a hybrid deployment of on-premises Microsoft Exchange Server and Microsoft Exchange Online in Microsoft 365.
- You create a shared mailbox directly in Exchange Online.
- You assign Full Access permissions to one or more users.

In this scenario, you experience one or more of the following issues:

- Users can't open the shared mailbox in Outlook.
- Users can't view free/busy information for the shared mailbox.
- Users can't send mail to the shared mailbox.
  
## Cause

These issues can occur if the shared mailbox is created by using the Exchange Online management tools. In this situation, the on-premises Exchange environment has no object to reference for the shared mailbox. Therefore, all queries for that SMTP address fail.

## Solution

> [!NOTE]
> Hybrid deployments are supported only for the current (N) and previous (N-1) Cumulative Updates (CUs).
> If you're running Exchange Server 2013 (CU20 or earlier versions) or Exchange Server 2016 (CU9 or earlier versions), it is important that you upgrade to the latest version to protect your server's integrity.

For on-premises environments that use Exchange Server 2013 (CU21 or later versions) or Exchange Server 2016 (CU10 or later versions), do the following:

Create an on-premises object for the cloud mailbox by using the `New-RemoteMailbox` cmdlet with the `-Shared` switch in  Exchange Management Shell.

This object must have the same name, alias, and user principal name (UPN) as the cloud mailbox. For more information, see [New-RemoteMailbox](/powershell/module/exchange/new-remotemailbox).

For example, run the following command:  

```powershell
New-Remotemailbox -Name "<Shared mailbox>" -Alias <sharedmailbox> -UserPrincipalName <sharedmailbox@contoso.com> -Remoteroutingaddress <sharedmailbox@contoso.mail.onmicrosoft.com> -Shared
```

## More information

For more information about remote shared mailboxes, see [Shared mailboxes are unexpectedly converted to user mailboxes after directory synchronization runs in an Exchange hybrid deployment](shared-mailboxes-unexpectedly-converted-to-user-mailboxes.md) and [Cmdlets to create or modify a remote shared mailbox in an on-premises Exchange environment](https://support.microsoft.com/help/4133605/).  

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
