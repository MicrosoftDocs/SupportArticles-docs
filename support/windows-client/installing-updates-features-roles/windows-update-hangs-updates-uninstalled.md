---
title: Windows Update hangs and updates are uninstalled
description: Discusses that Windows Update hangs and newly installed updates are uninstalled after a system restart in Windows. Provides a workaround.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Windows Update hangs and new updates are uninstalled after a restart

This article provides a workaround for an issue where Windows Update hangs and newly installed updates are uninstalled after a system restart.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3064434

## Symptoms

Consider the following scenario:  

- You have a computer that is running Windows.
- You install updates from Windows Update.
- You restart Windows when you are prompted to do this.

In this scenario, you see the following message during the restart process:

> Working on updates  
13% complete  
Don't turn off your computer  

This is an expected message. However, the system appears to stop responding (hangs) for about 15 minutes. After this time, the system does restart. However, the updates that you installed are now uninstalled.

Additionally, an entry that resembles the following may be logged in the CBS.log file under %SystemRoot%\Logs\CBS:

> Shtd: Timed out waiting for shutdown processing to complete - no progress detected in last 900000 milliseconds

## Cause

This issue occurs because the Trusted Installer service did not finish the installation process within the default time-out period of 15 minutes.

## Workaround

To work around this issue, set the time-out value to a larger value in the registry, and then reapply the hotfix. To do this, follow these steps:  

1. Start Registry Editor.
2. Locate the following subkey:  
    `HKLM\System\CurrentControlSet\Services\TrustedInstaller`  
3. Right-click the **TrustedInstaller** key, and then click **Permissions**.
4. Grant the **Full Control** user right to the Administrators group.
5. Change the **BlockTimeIncrement** value to 2a30 (Hexadecimal).

    > [!NOTE]
    > This change sets the time-out value to three hours. This should be sufficient for most situations. However, you may have to try a larger value in your environment.
6. Restart the server, and then apply the hotfix again.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
