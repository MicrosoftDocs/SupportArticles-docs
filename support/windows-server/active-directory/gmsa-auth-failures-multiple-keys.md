---
title: Troubleshoot authentication failures with Group Managed Service Accounts (gMSA)
description: Troubleshoot gMSA authentication failures caused by KDS root key sorting issues in Windows Server. Learn the workaround to prevent this problem.
ms.date: 06/22/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jories
ms.custom:
- sap:Active Directory\Managed Service Accounts (MSA, GMSA, DMSA)
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Troubleshoot authentication failures with Group Managed Service Accounts (gMSA)

This article explains how Group Managed Service Accounts (gMSA) can experience authentication failures when Active Directory domain controllers improperly sort multiple Key Distribution Service (KDS) root keys. It also provides guidance on how to prevent this problem.

## Prerequisites

*   Active Directory domain controllers running Windows Server 2019, Windows Server 2022, or later.
*   Knowledge of PowerShell and the `Add-KdsRootKey` cmdlet.
*   Access to create and manage KDS root keys in your environment.
*   Awareness of cumulative updates applied to domain controllers, specifically the April 2026 Cumulative Update for Windows Server 2022 and above.

## Description of the Problem

In an update to Windows Server 2022 and above in the April 2026 Cumulative Update, there was a change to the way Active Directory domain controllers sort KDS root keys internally. This change will go unnoticed and have no impact in most environments. But if you created multiple KDS root keys in your environment, with one of the keys having been created with the command:
 
`Add-KdsRootKey`
 
and then created another key shortly afterwards with a command such as: 
 
`Add-KdsRootKey -EffectiveTime ((Get-Date).AddHours(-10))`
 
or
 
`Add-KdsRootKey -EffectiveImmediately`
 
Then it is possible the domain controllers in your environment could sort these KDS root keys in the wrong order, causing the gMSA accounts using those KDS keys to stop working.
 
If there is a single KDS root key in your environment, you cannot experience this issue.

If all domain controllers are Windows Server 2022 or above, you cannot experience this issue.

This issue has only been observed in environments that contained either a mix of DCs that were Server 2022 and newer, and Server 2019 and older, or contained a mix of domain controllers that had been updated with the April 2026 CU and DCs that had not yet been updated.

## Workaround: Create a third KDS root key to ensure proper sorting

To proactively prevent authentication failures caused by incorrect sorting of multiple KDS root keys:

1.  Open PowerShell on a domain controller.
1.  Run the following command to create a new KDS root key with no arguments: Add-KdsRootKey
1.  Don't remove existing KDS root keys. The extra key helps ensure proper sorting across domain controllers, regardless of Windows version or update status.

## Troubleshooting checklist

*   Check if multiple KDS root keys exist in the environment.
*   Review the creation commands used for each KDS root key.
*   Determine the mix of domain controller versions and update levels in the environment.
*   Identify whether domain controllers are sorting KDS root keys incorrectly.

## Cause: Improper sorting of multiple KDS root keys

Starting with Windows Server 2022 and later versions, the April 2026 Cumulative Update changes how Active Directory domain controllers handle KDS root keys internally. If you create multiple keys by using different effective times, domain controllers in mixed-version environments (or with mixed update levels) might sort them incorrectly. This improper sorting can cause gMSA accounts that rely on those keys to fail authentication.

### Solution: Create an additional KDS root key

1.  Ensure that you have administrative privileges on a domain controller.
1.  Run the `Add-KdsRootKey` cmdlet with no arguments to generate a new KDS root key:  
    Add-KdsRootKey
1.  Keep all existing keys in place. The third key sorts correctly across all domain controllers, preventing authentication failures.

## Advanced troubleshooting and data collection

If authentication failures persist after applying the workaround:

*   Collect the list of all KDS root keys in the environment by running:  
    Get-KdsRootKey
*   Document the creation times and effective times for each key.
*   Identify the versions and update status of all domain controllers.
*   Capture any related event logs from affected domain controllers.
*   Submit this information when opening a support ticket with Microsoft to facilitate investigation.
