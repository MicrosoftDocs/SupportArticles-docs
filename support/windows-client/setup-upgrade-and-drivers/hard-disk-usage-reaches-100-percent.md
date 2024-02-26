---
title: Hard disk usage reaches 100 percent after the computer resumes from Sleep mode
description: Fixes an issue in which a Windows 8.1-based computer stops responding and hard disk usage reaches 100 percent. This issue occurs after the computer resumes from Sleep mode.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, aarthit
ms.custom: sap:power-management, csstroubleshoot
---
# Hard disk usage reaches 100 percent after the computer resumes from Sleep mode

After a Windows 8.1-based computer resumes from Sleep mode, the computer stops responding, and the hard disk usage reaches 100 percent. This article provides a solution to this issue.

_Applies to:_ &nbsp; Windows 8.1  
_Original KB number:_ &nbsp; 2922899

## Symptoms

After you resume a Windows 8.1-based computer from Sleep mode, the disk usage reaches 100 percent, and then the computer stops responding. This issue occurs when the following conditions are true:

- Device Initiated Power Management (DIPM) is enabled on the computer. Generally, this feature is enabled by changing the power scheme from **Balanced**  to **Power Saver**, and by using the powercfg command.
- The computer uses a non-Connected Standby Intel Haswell system that uses a Lynx Point Rev4 chipset.
- The computer uses a SATA drive that doesn't implement Automatic Partial to Slumber (APS) transitions, or there is a problem with implementing it.

## Workaround

To work around this issue, follow these steps:

1. Change power plan to **Balanced**.
2. Start Command Prompt as administrator, and then run the following commands:

    ```console
    powercfg /setacvalueindex scheme_max sub_disk 0b2d69d7-a2a1-449c-9680-f91c70521c60 1
    powercfg /setdcvalueindex scheme_max sub_disk 0b2d69d7-a2a1-449c-9680-f91c70521c60 1
    ```

3. Change the power plan back to **Power Saver**. You can also contact the computer vendor for a BIOS update that may fix the issue.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
