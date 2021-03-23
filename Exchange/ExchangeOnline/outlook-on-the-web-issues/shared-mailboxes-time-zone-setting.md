---
title: Setting the time zone for a shared mailbox in Outlook on the web
description: Discusses  how to set and check the time zone setting for shared mailboxes in OWA.
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
# Setting the time zone for a shared mailbox in Outlook on the web

When you [create a shared mailbox](/microsoft-365/admin/email/create-a-shared-mailbox), the mailbox isn't immediately assigned a license. This is because users don't sign in to a shared mailbox directly. This behavior is by design. Therefore, a time zone isn't automatically set after a shared mailbox is created. For information about when licenses are assigned to shared mailboxes, see [About shared mailboxes](/microsoft-365/admin/email/about-shared-mailboxes).

To check the time zone setting on a new shared mailbox, sign in to your Microsoft 365 account as a tenant administrator, and run the [Get-MailboxRegionalConfiguration](/powershell/module/exchange/get-mailboxregionalconfiguration) cmdlet:

`Get-MailboxRegionalConfiguration -Identity "<*Shared_mailbox_name*>"`

**Note:** In the cmdlet output, fields such as "TimeZone" will have a value of **\<null>** or **no value set**.

To set the time zone for a new shared mailbox, run the [Set-MailboxRegionalConfiguration](/powershell/module/exchange/set-mailboxregionalconfiguration) cmdlet:

`Set-MailboxRegionalConfiguration -Identity "<*Shared_mailbox_name*>" -TimeZone "<*Supported_time_zone_key_name*>"`

For example, to set the time zone to **Central Standard Time** for a shared mailbox that's named **Shared mailbox B**, run the following cmdlet:

`Set-MailboxRegionalConfiguration -Identity "Shared mailbox B" -TimeZone "Central Standard Time"`

</br>

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
