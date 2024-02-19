---
title: Power/shutdown button is missing from start screen
description: The power/shutdown button's presence on the Windows 8.1 start screen depends on the kind of hardware that you have.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, scottmca
ms.custom: sap:power-management, csstroubleshoot
---
# Power/shutdown button may be missing from the Windows 8.1 start screen

This article describes an issue where the power/shutdown button is missing from the start screen after you install or upgrade to Windows 8.1.

_Applies to:_ &nbsp; Windows 8.1  
_Original KB number:_ &nbsp; 2959188

## Summary

After you install or upgrade to Windows 8.1, the power/shutdown button may not be present on the start screen, depending on the kind of hardware that you have.

## More information

The following table summarizes when the power/shutdown button should be present on the start screen after you install the Windows 8.1 update:

|Device type|Supports Connected Standby|Screen size|Show power/shutdown button by default|Default behavior is customizable by the manufacturer|
|---|---|---|---|---|
|Slate|Yes|<8.5"|No|No|
|Slate|No|<8.5"|No|Yes|
|Slate|Yes|>=8.5"|No|Yes|
|Slate|No|>=8.5"|Yes|Yes|
|All other devices|Doesn't matter|All sizes|Yes|Yes|

> [!NOTE]
> An entry of Slate in the **Device type** column means that the hardware reported a [Power_Platform_Role](/windows/win32/api/winnt/ne-winnt-power_platform_role) of **PlatformRoleSlate**. To determine what a system is reporting, run the `powercfg /energy` command, and then notice what is listed for **Platform Role** in the output.

Example of Microsoft Surface behavior for new installations is as follows:

- Surface RT or Surface 2: No power button on start screen
- Surface 3: No power button on start screen
- Surface Pro or Surface Pro 2: Power button on start screen
- Surface Pro 3: No power button on start screen

> [!NOTE]
> The images that ship with the Surface 3 and Surface Pro 3 are configured to show the power button. This is a customization that is included with the image.

To change the default behavior when Windows images are being deployed, IT professionals should set the Microsoft-Windows-Shell-Setup [ShowPowerButtonOnStartScreen](/windows-hardware/customize/desktop/unattend/microsoft-windows-shell-setup-showpowerbuttononstartscreen) setting for new installations.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
