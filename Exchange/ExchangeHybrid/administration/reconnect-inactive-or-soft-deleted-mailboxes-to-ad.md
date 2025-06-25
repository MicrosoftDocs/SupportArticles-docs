---
title: Original Mailbox isn't Reconnected After Microsoft Entra Connect Resumes Syncing
description: Discusses how to recover a user's mailbox data if their original mailbox isn't reconnected after Microsoft Entra Connect resumes syncing the user account.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
  - CI 3946
  - no-azure-ad-ps-ref
ms.reviewer: ninob, apascual, meerak, v-shorestris
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 03/17/2025
---

# Original mailbox isn't reconnected after Microsoft Entra Connect resumes syncing

_Original KB number:_ &nbsp;4337973

## Symptoms

Consider the following scenario in a hybrid Microsoft Exchange environment:

- You [exclude](/entra/identity/hybrid/connect/how-to-connect-sync-configure-filtering) an on-premises user account to prevent Microsoft Entra Connect from syncing the account to Microsoft Entra ID.

- Later, you remove the exclusion to let syncing resume.

As expected, the user lost access to their cloud mailbox when syncing stopped. However, when syncing resumed, the user was assigned a new empty cloud mailbox instead of their original cloud mailbox.

## Cause

When Microsoft Entra Connect _stops_ syncing an on-premises user account to Microsoft Entra ID, the following actions occur:

- **User account in Microsoft Entra ID**: Microsoft Entra ID immediately soft deletes the user account and moves it to the deleted users list in the Microsoft 365 admin center and the Microsoft Entra admin center. If Microsoft Entra Connect doesn't resume syncing within 30 days, the user account is permanently deleted.

- **Cloud mailbox**: Exchange Online immediately soft deletes the cloud mailbox that's associated with the soft deleted user account. Consequently, the mailbox is inaccessible to both the user and delegates. If Microsoft Entra Connect doesn't resume syncing within 30 days, one of the following actions occur:

   - If the associated cloud mailbox has a hold applied, the mailbox changes to an [inactive mailbox](/purview/inactive-mailboxes-in-office-365). To check for an inactive mailbox, run the following cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

      ```PS
      Get-Mailbox -IncludeInactiveMailbox -Identity <cloud mailbox identity> | FL IsInactiveMailbox
      ```

   - If the associated cloud mailbox has no hold applied, it's permanently deleted and its contents are unrecoverable.

When Microsoft Entra Connect _resumes_ syncing an on-premises user account whose associated user account in Microsoft Entra ID is permanently deleted, the following actions occur:

- Microsoft Entra ID creates a new user account in Microsoft Entra ID.

- Exchange Online provisions a new cloud mailbox for the new user account.

This behavior is by design.

> [!NOTE]
> If syncing of the on-premises user account resumes before permanent deletion of the user account in Microsoft Entra ID, the system restores both the original cloud mailbox and the original user account in Microsoft Entra ID.

## Workaround

To work around the issue, if the user's original cloud mailbox is an [inactive mailbox](/purview/inactive-mailboxes-in-office-365), retrieve the user's data by [restoring the contents of the inactive mailbox to the user's new cloud mailbox](/purview/restore-an-inactive-mailbox).

> [!TIP]
> Alternatively, you can [recover an inactive mailbox](/purview/recover-an-inactive-mailbox) if both the following conditions are met:
> - The original user account in Microsoft Entra ID is permanently deleted.
> - Syncing of the on-premises user account hasn't resumed. Consequently, Microsoft Entra ID hasn't created a new user account, and Exchange Online hasn't provisioned a new cloud mailbox.

If the user's original cloud mailbox had no hold applied and is permanently deleted, the mailbox content is unrecoverable. To prevent accidental or unintentional deletion of mailbox data, we strongly recommend that you apply a [retention policy](/microsoft-365/compliance/retention) or [place a hold](/purview/inactive-mailboxes-in-office-365#confirming-a-hold-is-applied-to-a-mailbox) on a cloud mailbox before its associated user account in Microsoft Entra ID is permanently deleted.
