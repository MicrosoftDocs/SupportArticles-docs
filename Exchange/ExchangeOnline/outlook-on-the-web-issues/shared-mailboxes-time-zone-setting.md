---
title: Time zone settings for shared mailboxes in Outlook on the web
description: Discusses how to check and set the time zone for shared mailboxes in Outlook on the web.
author: cloud-writer
ms.author: meerak
ms.reviewer: ldusoli, mhaque, v-six
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - sap:Outlook on the web / OWA
  - Exchange Online
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
---
# Time zone settings for shared mailboxes in Outlook on the web

When you [create a shared mailbox](/microsoft-365/admin/email/create-a-shared-mailbox), the mailbox isn't immediately assigned a license. This behavior is by design. A time zone isn't automatically set after a shared mailbox is created because users don't sign in to shared mailboxes directly. For information about when licenses are assigned to shared mailboxes, see [About shared mailboxes](/microsoft-365/admin/email/about-shared-mailboxes).

To check the time zone setting on a new shared mailbox, sign in to your Microsoft 365 account as a tenant administrator, and run the [Get-MailboxRegionalConfiguration](/powershell/module/exchange/get-mailboxregionalconfiguration) cmdlet:

`Get-MailboxRegionalConfiguration -Identity "<Shared_mailbox_name>"`

**Note:** In the cmdlet output, fields such as "TimeZone" will have a value of **\<null>** or **no value set**.

To set the time zone for a new shared mailbox, run the [Set-MailboxRegionalConfiguration](/powershell/module/exchange/set-mailboxregionalconfiguration) cmdlet:

`Set-MailboxRegionalConfiguration -Identity "<Shared_mailbox_name>" -TimeZone "<Supported_time_zone_key_name>"`

For example, to set the time zone to **Central Standard Time** for a shared mailbox that's named **Shared mailbox B**, run the following cmdlet:

`Set-MailboxRegionalConfiguration -Identity "Shared mailbox B" -TimeZone "Central Standard Time"`

</br>

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
