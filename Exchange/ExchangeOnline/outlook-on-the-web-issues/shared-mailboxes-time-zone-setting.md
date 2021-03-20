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

When you [create a shared mailbox](/microsoft-365/admin/email/create-a-shared-mailbox), a license won't be assigned before users sign in to the shared mailbox. This behavior is by design. Therefore, a time zone isn't set automatically after a shared mailbox is created. See [About shared mailboxes](/microsoft-365/admin/email/about-shared-mailboxes) about when a license will be assigned to a shared mailbox.

To check and set the time zone for a new shared mailbox, sign in to the Microsoft 365 account as a tenant administrator and run the [Get-MailboxRegionalConfiguration](/powershell/module/exchange/get-mailboxregionalconfiguration) cmdlet as follows:

**To check the time zone setting:**

`Get-MailboxRegionalConfiguration -Identity "<Shared_mailbox_name>"`

In the output from the cmdlet, some fields such as **TimeZone** will display the value **\<null>** or **no value set**.

**To set the time zone setting:**

`Set-MailboxRegionalConfiguration -Identity "<Shared_mailbox_name>" -TimeZone "<Supported_time_zone_key_name>"`

For example, to set the time zone for a shared mailbox named **Shared Mailbox A** to **Central Standard Time**, the cmdlet will look as follows:

`Set-MailboxRegionalConfiguration -Identity "Shared Mailbox A" -TimeZone "Central Standard Time"`

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
