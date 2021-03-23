---
title: Time zone settings for shared mailboxes in Outlook on the web
description: Provides the information about time zone setting for shared mailboxes in OWA and describes how to set and check the time zone setting.
author: simonxjx
ms.reviewer: ldusoli, mhaque
audience: ITPro
ms.service: exchange-online
ms.topic: article
ms.author: v-six
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Exchange Online
---
# Time zone setting for shared mailboxes in OWA

When you [create a shared mailbox](/microsoft-365/admin/email/create-a-shared-mailbox), it is not assigned a license right away because users don't sign into a shared mailbox directly. This behavior is by design. As a result, a time zone is not set automatically after a shared mailbox is created. For information about when licenses are assigned to shared mailboxes, see [About shared mailboxes](/microsoft-365/admin/email/about-shared-mailboxes).

## Check the time zone

To check the time zone setting on a new shared mailbox, sign into your Microsoft 365 account as a tenant administrator and run the [Get-MailboxRegionalConfiguration](/powershell/module/exchange/get-mailboxregionalconfiguration) cmdlet as follows:

`Get-MailboxRegionalConfiguration -Identity "<Shared_mailbox_name>"`

> [!NOTE]
> In the output from the cmdlet, fields such as "TimeZone" will display the value **\<null>** or **no value set**.

## Set the time zone

To set the time zone for a shared mailbox, run the [Set-MailboxRegionalConfiguration](/powershell/module/exchange/set-mailboxregionalconfiguration) cmdlet as follows:

`Set-MailboxRegionalConfiguration -Identity "<Shared_mailbox_name>" -TimeZone "<Supported_time_zone_key_name>"`

For example, to set the time zone for a shared mailbox named **Shared mailbox B** to **Central Standard Time**, the cmdlet will look as follows:

`Set-MailboxRegionalConfiguration -Identity "Shared mailbox B" -TimeZone "Central Standard Time"`

## Need help? Contact support

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
