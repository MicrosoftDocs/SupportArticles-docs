---
title: Cannot install the May 2019 update of Windows 10 on computers that run certain versions of AMD RAID drivers
description: Discusses that certain AMD RAID drivers do not support the May 2019 update of Windows 10. The fix is to obtain new drivers directly from AMD.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, paudina, mingcheh, caroul, v-jesits, v-tea, tlavoy
ms.custom: sap:servicing, csstroubleshoot
ms.subservice: deployment
---
# Cannot install the May 2019 update of Windows 10 on computers that run certain versions of AMD RAID drivers

This article provides a solution to an issue where the May 2019 update of Windows 10 cannot be installed on computers that run certain versions of AMD RAID drivers.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4504107

## Symptoms

When you install the May 2019 update on a Windows 10-based computer, the installation process stops, and you receive a message that resembles the following:
> AMD Ryzen™ or AMD Ryzen™ Threadripper™ configured in SATA or NVMe RAID mode.  
A driver is installed that causes stability problems on Windows. This driver will be disabled. Check with your software/driver provider for an updated version that runs on this version of Windows.

## Cause

On computers that have AMD Ryzen or AMD Ryzen Threadripper processors, certain versions of AMD RAID drivers are not compatible with the Windows 10 May 2019 update. If a computer has these drivers installed and configured in RAID mode, it cannot install the May 2019 update of Windows 10. If you start the installation process, the process stops.

Version 9.2.0.105 and later versions of the AMD RAID drivers do not cause this issue. A computer that has these drivers installed can receive the May 2019 update.

For more information about this issue, see [Article PA-260, Unable to proceed with installation or upgrade of Windows® 10 May 2019 Update with SATA or NVMe RAID on AMD Ryzen™ systems](https://www.amd.com/en/support/kb/faq/pa-260) on the AMD website.

## Resolution

To resolve this issue, download the latest AMD RAID drivers directly from AMD at [X399 Drivers & Support](https://www.amd.com/en/support/chipsets/amd-socket-tr4/x399). The drivers must be version 9.2.0.105 or a later version. Install the drivers on the affected computer, and then restart the installation process for the May 2019 update.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]

