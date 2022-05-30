---
title: Retention label doesn't auto-apply to messages
description: Auto-apply retention label that you have configured doesn't apply to messages in a mailbox because a retention tag from messaging records management has been applied to the whole mailbox.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 163457
  - CSSTroubleshoot
ms.reviewer: cabailey, vipg, roygles, lindabr
appliesto: 
  - Exchange Online via Office 365 E Plans 
search.appverid: MET150
ms.date: 5/30/2022
---
# Auto-apply retention label doesn't apply to messages in a mailbox

## Symptoms

You have configured an [auto-apply retention label](/microsoft-365/compliance/apply-retention-labels-automatically) by using a query that contains specific words, phrases, or values of searchable properties. However, the label doesn't automatically apply to the messages in a mailbox.

## Cause

This issue occurs because a retention tag from a [messaging records management (MRM) retention policy](/microsoft-365/compliance/set-up-an-archive-and-deletion-policy-for-mailboxes) has been applied to the whole mailbox.

## Resolution

To resolve this issue, use either of the following methods:

- **Method 1**: Replace the retention tag at the mailbox level with either a [Microsoft 365 retention policy](/microsoft-365/compliance/create-retention-policies) (preferred) or an MRM retention policy. You might use any of the following options to replace the retention tag:  

  - Remove the retention tag from the MRM policy. Then, apply a Microsoft 365 retention policy that has the same settings as the retention tag.

  - Remove the retention tag from the MRM policy. Then, reconfigure the existing MRM retention policy to have the same settings as the retention tag.

  - Create a new MRM retention policy that has the same settings as the retention tag (without any retention tag at the mailbox level). Then, apply the new MRM retention policy to the mailbox instead.

- **Method 2**: Apply the retention tag to folders in the mailbox.
