---
title: DisablePST and PSTDisableGrow are ignored
description: Describes a setting issue that DisablePST and PSTDisableGrow policies ignored when the DisableCrossAccountCopy policy is also used in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 10/30/2023
---
# DisablePST and PSTDisableGrow policies ignored when the DisableCrossAccountCopy policy is also used

_Original KB number:_ &nbsp; 2822194

## Symptoms

When you deploy either of the following policy settings for Outlook, they appear to be ignored by Outlook.

- Prevent users from adding PSTs to Outlook profiles and/or prevent using Sharing-Exclusive PSTs (registry value: `DisablePST`)
- Prevent users from adding new content to existing PST files (registry value: `PSTDisableGrow`)

## Cause

This behavior occurs if you also have the following policy setting enabled in Outlook.

- Prevent copying or moving items between accounts (registry value: `DisableCrossAccountCopy`)

When you use the `DisableCrossAccountCopy` policy in Outlook, the `DisablePST` and `PSTDisableGrow` policies are ignored by Outlook. This is intentional because the `DisableCrossAccountCopy` policy, if enabled, prevents users from adding data to pst files from either an Exchange mailbox or another .pst file.

## More information

For more information on the policy, see [Plan for compliance and archiving in Outlook 2010](/previous-versions/office/office-2010/ff800883(v=office.14)).

> [!IMPORTANT]
> There is current a known issue with the Outlook 2010 Administrative Template (ADML/ADMX) setting this value to `REG_EXPAND_SZ` instead of `REG_MULTI_SZ`. For more information about this issue, see [Outlook policy template deploys DisableCrossAccountCopy as REG_EXPAND_SZ instead of REG_MULTI_SZ](https://support.microsoft.com/help/2479719).
