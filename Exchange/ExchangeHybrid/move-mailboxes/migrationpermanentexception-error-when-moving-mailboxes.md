---
title: MigrationPermanentException error when moving mailboxes
description: Describes a problem that triggers a MigrationPermanentException error when you try to move a mailbox from Exchange Online to an on-premises Exchange 2010 server in an Exchange hybrid deployment. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: jeffrem, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# MigrationPermanentException error when moving mailboxes from Exchange Online to Exchange Server 2010

_Original KB number:_ &nbsp; 2932443

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

Assume that you have an Exchange hybrid deployment that includes on-premises Exchange 2010 servers. When you try to offboard or move a mailbox from Exchange Online to an Exchange 2010 server in your on-premises environment, you receive the following error message:

> Error: MigrationPermanentException:
>
> You shouldn't migrate mailbox '\<username>' to Exchange 2010 or an earlier version while the user's Instant Messaging contact list is stored in Exchange. If you do, the user could permanently lose access to their Instant Messaging contact list, which will cause serious data loss. The Exchange copy might be the only copy of this user's contact list. To continue, please contact your Instant Messaging administrator and make sure that the user's contact list is moved back to the Instant Messaging server. After this has been done, you should be able to complete this migration. If you must migrate the mailbox despite the potential data loss, you can do so by running 'Set-UMMailbox mailboxID -ImListMigrationCompleted $false'.

However, when you run the `Set-UMMailbox mailboxID -ImListMigrationCompleted $false` cmdlet as stated in the error message, you receive the following error message:

> The Mailbox \<username>@contoso.com isn't enabled for unified messaging.

## Cause

This occurs if the Lync 2013 contacts of the user who is associated with the mailbox are stored in the unified contact store in Exchange. By default, if the user signed in to Lync 2013, the unified contact store is enabled for that user. Additionally, the user's Lync contacts are migrated from the Lync server to Exchange.

## Resolution

> [!IMPORTANT]
> Currently, the `ImListMigrationCompleted` parameter is available only in Exchange Server (on-premises). For more information about how to import PST files to Exchange Online mailboxes, see [overview of importing your organization's PST files](/microsoft-365/compliance/importing-pst-files-to-office-365).

Use the [Set-Mailbox](/powershell/module/exchange/set-mailbox) cmdlet together with the `ImListMigrationCompleted` parameter instead of the `Set-UMMailbox` cmdlet. For example, run the following cmdlet:

```powershell
Set-Mailbox John@contoso.com -ImListMigrationCompleted $false
```

After you run the cmdlet, perform the mailbox move request.

> [!NOTE]
> The `$false` setting in the `ImListMigrationCompleted` parameter indicates that the user's contacts haven't been migrated to Lync to preserve the contact list. Be aware that the solution in this section may result in data loss. Exchange Server 2010 doesn't support the unified contact store feature in Lync 2013. Therefore, if you move a mailbox back to Exchange Server 2010 while the user's Lync contacts are stored in the unified contact store, the user could lose access to Lync contacts. You should first make sure that the user's Lync contacts are moved back to Lync server before you move the mailbox to Exchange Server 2010.

## More information

If you experience issues when you move mailboxes to Exchange Online in Microsoft 365, you can run the Troubleshoot Microsoft 365 Mailbox Migration tool. This diagnostic is an automated troubleshooting tool. If you're experiencing a known issue, you receive a message that states what went wrong. The message includes a link to an article that contains the solution. Currently, the tool is supported only in Internet Explorer.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
