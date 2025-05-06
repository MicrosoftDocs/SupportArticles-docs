---
title: Prevent Mailbox Delegates from Reading Protected Messages
description: Discusses how to prevent delegates from reading IRM-protected email messages in a user or shared mailbox.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Data Protection and Security\Sensitivity Labels
  - Outlook for Windows
  - Outlook for iOS and Android
  - Exchange Online
  - CSSTroubleshoot
  - CI 91080
  - CI 4496
ms.reviewer: thomno, jinhan, pawankap, gbratton, meerak, v-shorestris
appliesto: 
  - Outlook for Microsoft 365
  - Outlook for Windows
  - Outlook on the web
  - Outlook for Android
  - Outlook for iOS
  - Outlook for Mac
  - Outlook for Mac for Microsoft 365
  - Legacy Outlook for Mac
  - Microsoft Purview
search.appverid: MET150
ms.date: 04/10/2025
---

# Prevent mailbox delegates from reading protected messages

By default, for a _user_ mailbox, Information Rights Management (IRM)-protected email messages can be read by any delegate who has **Full Access** permission on the mailbox.

By default, for a _shared_ mailbox, IRM-protected email messages can be read by any delegate who has **Full Access** permission on the mailbox, if either of the following conditions are true:

- The delegate opens the message in new Outlook for Windows, Outlook on the web, Outlook for Android, Outlook for iOS, Outlook for Mac, or legacy Outlook for Mac.
- The delegate opens the message in classic Outlook for Windows, and [automapping](/powershell/module/exchange/add-mailboxpermission#-automapping) is enabled on the shared mailbox.

## Block delegate access to protected messages that are received in the mailbox

In some scenarios, delegates who have **Full Access** permission on a mailbox can be prevented from reading IRM-protected email messages that are received in the mailbox. Use the following table to determine the appropriate prevention method for each scenario. Prevention method descriptions follow the table.

| | **Delegate uses classic Outlook for Windows** | **Delegate uses new Outlook for Windows** | **Delegate uses Outlook on the web, Outlook for Android, Outlook for iOS, or Outlook for Mac** | **Delegate uses legacy Outlook for Mac** |
|-|-|-|-|-|
| **User mailbox in Exchange Online**  | Method A or B | Method C | Method C | No prevention possible |
| **Shared mailbox in Exchange Online** | No prevention possible | Method C | Method C | No prevention possible |
| **User mailbox in Exchange Server** | Method A or B | Invalid scenario | No prevention possible | No prevention possible |
| **Shared mailbox in Exchange Server** | No prevention possible | Invalid scenario | No prevention possible | No prevention possible |

### Method A

To restrict delegate access in the applicable scenarios, senders can apply either the [Encrypt-Only](/azure/information-protection/configure-usage-rights#encrypt-only-option-for-emails) or [Do Not Forward](/azure/information-protection/configure-usage-rights#do-not-forward-option-for-emails) built-in protection option to new messages. This approach restricts the delegates who can read a protected message to those who are specified in the **To**, **Cc**, or **Bcc** fields of the message.

### Method B

To restrict delegate access in the applicable scenarios, senders can [apply a sensitivity label](/purview/encryption-sensitivity-labels#how-to-configure-a-label-for-encryption) that assigns either the **Encrypt-Only** or **Do Not Forward** protection option to new messages. This approach restricts the delegates who can read a protected message to those who are specified in the **To**, **Cc**, or **Bcc** fields of the message. For information about how an admin can create this type of sensitivity label, see [Configure encryption](/purview/encryption-sensitivity-labels#configure-encryption-settings).

> [!NOTE]
> If senders instead apply a sensitivity label that [assigns access rights to predetermined users or groups](/purview/encryption-sensitivity-labels#assign-permissions-now), any of those users or group members can read the protected message, even if they aren't specified in the **To**, **Cc**, or **Bcc** fields of the message.

### Method C

To restrict delegate access in the applicable scenarios, run the [Set-MailboxIRMAccess](/powershell/module/exchange/set-mailboxirmaccess) cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell). For more information, see [Block delegates or shared mailbox members from accessing protected messages](https://techcommunity.microsoft.com/t5/exchange-team-blog/consistently-block-delegates-or-shared-mailbox-members-from/ba-p/3473764).
