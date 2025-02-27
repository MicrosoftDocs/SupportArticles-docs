---
title: Attachments not tracked after Defender for Office 365 is enabled
description: This article resolves an issue where attachments aren't tracked to Microsoft Dynamics 365 after Microsoft Defender for Office 365 is enabled.
ms.reviewer: dmartens, Chris.Davis
ms.date: 03/06/2023
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# Attachments aren't tracked to Microsoft Dynamics 365 after Microsoft Defender for Office 365 is enabled

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 4522769

## Symptoms

When you use server-side synchronization with Microsoft Dynamics 365 and Microsoft Defender for Office 365 is enabled, attachments may be missing from the email created in Microsoft Dynamics 365. You may see an attachment included named **ATP Scan in Progress.eml**, but the original attachment isn't added to Microsoft Dynamics 365.

## Cause

If a Safe Attachments policy in Microsoft Defender for Office 365 is configured with the **Dynamic Delivery** action, and an email is received in the user's inbox with an attachment, two emails with the same email message ID will exist. The user will receive the first one without the original attachment while Safe Attachments is scanning the attachments. The second email will replace the first one after the scanning completes.

The server-side synchronization feature will only track emails with the same message ID once to avoid duplication. If the second email doesn't get to Exchange before the sync cycle starts from Microsoft Dynamics 365, the original attachment may not be tracked to the system.

## Resolution

To solve the issue, use a different action (for example, the **Block** action) in the Safe Attachments policy.

For more information, see [Safe Attachments policy settings in Microsoft Defender for Office 365](/microsoft-365/security/office-365-security/safe-attachments-about#safe-attachments-policy-settings).
