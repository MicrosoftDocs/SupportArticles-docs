---
title: Prevent mailbox delegates from reading protected messages
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
ms.reviewer: thomno, gbratton, meerak, v-trisshores
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook on the web
  - Outlook for Android
  - Outlook for iOS
  - Microsoft Purview
search.appverid: MET150
ms.date: 03/28/2025
---

# Prevent mailbox delegates from reading protected messages

By default, for a user mailbox, Information Rights Management (IRM)-protected email messages can be read by any delegate who has Full Access permission on the mailbox.

By default, for a shared mailbox, IRM-protected email messages can be read by any delegate who has Full Access permission on the mailbox, if either of the following conditions are true:

- The delegate opens the message in the new Outlook, Outlook on the web, Outlook for Android, or Outlook for iOS.
- The delegate opens the message in the classic Outlook, and [automapping](/powershell/module/exchange/add-mailboxpermission#-automapping) is enabled on the shared mailbox.

## Block delegate access to protected messages

In some scenarios, delegates who have Full Access permission on a mailbox can be prevented from reading IRM-protected email messages that are _received_ in the mailbox. Use the following table to determine the appropriate prevention method for each scenario. For more information, see the method descriptions that follow the table.

||Delegate uses the classic Outlook|Delegate uses the new Outlook|Delegate uses Outlook on the web, Outlook for Android, or Outlook for iOS|
|---|---|---|---|
|**User mailbox in Exchange Online**|Methods A or B|Method C|Method C|
|**Shared mailbox in Exchange Online**|No prevention possible|Method C|Method C|
|**User mailbox in Exchange Server**|Methods A or B|Invalid scenario|No prevention possible|
|**Shared mailbox in Exchange Server**|No prevention possible|Invalid scenario|No prevention possible|

### Method A

To restrict delegate access in the applicable scenarios, senders can apply either the [Encrypt-Only](/azure/information-protection/configure-usage-rights#encrypt-only-option-for-emails) or [Do Not Forward](/azure/information-protection/configure-usage-rights#do-not-forward-option-for-emails) built-in protection option to new messages. This approach restricts the delegates who can read a protected message to those who are specified in the **To**, **Cc**, or **Bcc** fields of the message.

### Method B

To restrict delegate access in the applicable scenarios, senders can [apply a sensitivity label](/purview/encryption-sensitivity-labels#how-to-configure-a-label-for-encryption) that assigns either the **Encrypt-Only** or **Do Not Forward** protection option to new messages. This approach restricts the delegates who can read a protected message to those who are specified in the **To**, **Cc**, or **Bcc** fields of the message. For information about how an admin can create this type of sensitivity label, see [Configure encryption](/purview/encryption-sensitivity-labels#configure-encryption-settings).

> [!NOTE]
> If senders instead apply a sensitivity label that [assigns access rights to predetermined users or groups](/purview/encryption-sensitivity-labels#assign-permissions-now), any of those users or group members can read the protected message, even if they aren't specified in the **To**, **Cc**, or **Bcc** fields of the message.

### Method C

To restrict delegate access in the applicable scenarios, run the [Set-MailboxIRMAccess](/powershell/module/exchange/set-mailboxirmaccess) cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell). For more information, see [Block delegates or shared mailbox members from accessing protected messages](https://techcommunity.microsoft.com/t5/exchange-team-blog/consistently-block-delegates-or-shared-mailbox-members-from/ba-p/3473764).
