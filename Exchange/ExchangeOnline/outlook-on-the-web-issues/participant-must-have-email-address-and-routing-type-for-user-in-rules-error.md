---
title: Error occurs when creating rule in OWA
description: Describes an issue that triggers an error message when a user tries to create a new rule in Outlook Web App in Exchange Online. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Outlook on the web / OWA
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: sapadman, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Participant must have email address and routing type for use in rules error when creating a rule in OWA

_Original KB number:_ &nbsp; 2952821

## Symptoms

When a user tries to create a new rule in Outlook Web App for their Exchange Online mailbox, the user receives the following error message:

> "Participant must have email address and routing type for use in rules."  
Validation status: AddressAndRoutingTypeMismatch

This issue occurs only in Outlook Web App. The user can create new rules and change existing rules in Microsoft Outlook.

## Cause

This issue may occur if the user's mailbox contains one or more corrupted rules.

## Resolution

To resolve this issue, follow these steps:

1. Use Microsoft Exchange Server MAPI Editor (MFCMAPI) to open the user's mailbox profile. Locate the corrupted rules, and then delete them.
2. If the issue continues to occur, delete all the mailbox rules in Outlook Web App.

## More information

For information about how to use MFCMAPI to locate and delete corrupted rules in a mailbox, see [How to delete corrupted, hidden inbox rules from a mailbox using MFCMAPI](/archive/blogs/hkong/how-to-delete-corrupted-hidden-inbox-rules-from-a-mailbox-using-mfcmapi).

> [!NOTE]
> The steps in the article were originally written for Outlook 2003. However, they also work for Exchange Online mailboxes.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
