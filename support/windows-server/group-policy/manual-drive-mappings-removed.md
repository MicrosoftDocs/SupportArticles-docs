---
title: Manual drive mappings are removed
description: Provides a solution to an issue where manual drive mappings are removed after drive maps are deployed through Group Policy Preferences.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:managing-drive-mappings-through-group-policy, csstroubleshoot
ms.subservice: group-policy
---
# Group Policy Preferences removes manual drive mappings if the use first available setting is enabled

This article provides a solution to an issue where manual drive mappings are removed after drive maps are deployed through Group Policy Preferences.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3091116

## Symptoms

After drive maps are deployed through Group Policy Preferences (GPP), users observe that previously mapped drives are no longer available after a new logon. Additionally, only a subset of mapped drives that are configured through GPP are present if more than one policy is configured through drive map items.

## Cause

Within a drive map item, there's a **Drive Letter** option to enable the **Use first available, starting at** setting. This setting (denoted as the `useLetter` element in the drive map XML) is defined as follows at [Element-Specific Attributes](/openspecs/windows_protocols/ms-gppref/b64d3e8c-d6e4-44b5-a02a-54f0fb0d5322):

useLetter - If 1, then letter refers to a single drive letter on which the action should operate. If 0, then letter is the alphabetic beginning of a range of drive letters to which the action may apply. When the preference item is configured with **Use first available, starting at:** (or `useLetter=0`in the XML), the Preference client-side extension will clear all mapped drives starting with that drive latter through the letter Z. If multiple GPP policies are being applied, the order of how the drive maps are processed may lead to seemingly random removal of GPP-mapped drives.

## Resolution

By design, drive maps are cleared when the **Use first available, starting at** setting is enabled.

If the **Use first available, starting at** setting is required, make sure that the following conditions are met:

- Manually mapped drives are configured to use drive letters from earlier in the alphabet than those that are configured by GPP drive maps.
- Only a single GPP drive map policy is applied to the user.

You can also assign specific drive letters to each drive map and not use the **Use first available, starting at** option on any drive map. Then, any number of GPP drive map policies may be applied to the user without the loss of manually mapped drives or of GPP drive maps that are configured in multiple policies that apply to the user.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
