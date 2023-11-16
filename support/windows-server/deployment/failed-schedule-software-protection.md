---
title: Failed to schedule Software Protection
description: Describes an issue that triggers event 16385 in a Windows Server 2012 environment. Occurs when the Network Service account doesn't have permissions to the SoftwareProtectionPlatform folder.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:servicing, csstroubleshoot
ms.technology: windows-server-deployment
---
# Failed to schedule Software Protection service for restart error in Windows Server 2012

This article provides a solution to an error that occurs when the Network Service account doesn't have permissions to the `SoftwareProtectionPlatform` folder.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3033200

## Symptoms

You may frequently receive the following event in the Application log for the Software Protection service:

## Cause

The issue may occur if one or more of the following conditions are true:

- The Task Scheduler service is disabled.
- The Software Protection Platform service isn't running under the NETWORK SERVICE account.
- Read permissions for the NETWORK SERVICE account are missing on the following folder:
    `C:\Windows\System32\Tasks\Microsoft\Windows\SoftwareProtectionPlatform`

## Resolution

To resolve this issue, follow these steps:

1. Verify that the Task Scheduler service is running.
2. Open the Computer Management tool, and then navigate to **Configuration** -> **Task Scheduler** -> **Task Scheduler Library** -> **Microsoft** -> **Windows** -> **SoftwareProtectionPlatform**.
3. On the **General** tab of **SoftwareProtectionPlatform**, select the security options, and then verify that the Software Protection Platform service is set to use the NETWORK SERVICE account.
4. In Windows Explorer, browse to the `C:\Windows\System32\Tasks\Microsoft\Windows\SoftwareProtectionPlatform` folder, and then verify that the NETWORK SERVICE account has Read permissions for that folder.
5. Restart the Software Protection service if it's running.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
