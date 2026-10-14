---
title: Default address in “From” field displays secondary email address
description: Describes a scenario in which the default From address displayed in a new email form is a secondary email address, and provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Client\Outlook on the web (OWA)
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: subansal
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 08/24/2026
---
# Default address in “From” field displays secondary email address

## Summary

When you compose a new email by using Outlook on the Web or new Outlook, the **From** field might default to a secondary email address instead of the primary SMTP address. This article describes why this behavior might occur and how you can fix the issue.

## Symptoms

In Outlook on the web or new Outlook, when you select the **New Mail** option, the **From** field in the form displays a secondary email address for you such as `joe@joecontoso.onmicrosoft.com` by default.

:::image type="content" source="media/default-from-address-is-secondary-email/secondary-email-in-from-field.png" alt-text="Screenshot of a new email form with the secondary email address in the From field highlighted.":::

## Cause

This behavior occurs when the following conditions are true:

- The [SendFromAlias feature](https://techcommunity.microsoft.com/blog/exchange/sending-from-email-aliases-%E2%80%93-public-preview/3070501) (public preview) is enabled in your tenant.
- The value of the `SendAddressDefault` parameter for your mailbox is set to your secondary email address.

To verify the cause of the issue, use the following steps:

1. To check whether the SendFromAlias feature is enabled at the organization level, run the following cmdlet:

   ```powershell
   Get-OrganizationConfig \| fl \*sendfrom\*
   ```
   If the output of the cmdlet is `True` then the feature is enabled.

1. To check the mailbox message configuration, run the following cmdlet:

   ```powershell
   Get-MailboxMessageConfiguration \<MailboxIdentity\> \| fl SendAddressDefault
   ```
   If the output of the cmdlet is your secondary email address, then this setting is likely the cause of the issue.

Additionally in Outlook on the web and in new Outlook, even if the option for your secondary email address `joe@joecontoso.onmicrosoft.com` under **Mail** > **Layout** > **Compose and Reply** > **Addresses to send from** is not selected, it is still possible that this address displays as the default value in the **From** field.

:::image type="content" source="media/default-from-address-is-secondary-email/secondary-email-option-unchecked.png" alt-text="Screenshot of the unchecked option for the secondary email address highlighted.":::

## Resolution

To resolve the issue, update the mailbox message configuration to set the `SendAddressDefault` parameter either to null or to your primary email address. Run one of the following cmdlets depending on your choice:  
  
```powershell
Set-MailboxMessageConfiguration \<MailboxIdentity\> -SendAddressDefault \$null
```

Or

```powershell
Set-MailboxMessageConfiguration \<MailboxIdentity\> -SendAddressDefault primary@domain.com
```

When you set the `SendAddressDefault` parameter, you also ensure that users can still select other aliases manually if the SendFromAlias feature is enabled.
