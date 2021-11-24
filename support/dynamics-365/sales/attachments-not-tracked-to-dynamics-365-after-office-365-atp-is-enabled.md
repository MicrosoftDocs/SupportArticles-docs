---
title: Attachments not tracked after Office 365 ATP is enabled
description: Attachments are not tracked to Dynamics 365 after Office 365 Advanced Thread Protection (ATP) is enabled. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Attachments are not tracked to Microsoft Dynamics 365 after Office 365 Advanced Thread Protection(ATP) is enabled

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4522769

## Symptoms

When you use Server-Side Synchronization with Microsoft Dynamics 365 and Office 365 Advanced Thread Protection (ATP) is enabled, attachments may be missing from the email created in Microsoft Dynamics 365. You may see an attachment included named **ATP Scan in Progress.eml**, but the original attachment is not added to Microsoft Dynamics 365.

## Cause

If ATP is configured with the safe attachment policy **Dynamic Delivery** and an email is received in the user's inbox with an attachment, two emails with the same email message ID will exist. The user will receive the first one without the original attachment while ATP is scanning the attachments. The second email will replace the first one after the scanning completes.

The Server-Side Synchronization feature will only track emails with the same message ID once to avoid duplication. If the second email doesn't get to Exchange before the sync cycle starts from Microsoft Dynamics 365, the original attachment may not be tracked to the system.

## Resolution

Use the **Replace** policy in ATP safe attachment configuration.

For more information about ATP Safe Attachments policy options, see [Set up Safe Attachments policies in Microsoft Defender for Office 365](/microsoft-365/security/office-365-security/set-up-atp-safe-attachments-policies?view=o365-worldwide#step-3-learn-about-atp-safe-attachments-policy-options&preserve-view=true).
