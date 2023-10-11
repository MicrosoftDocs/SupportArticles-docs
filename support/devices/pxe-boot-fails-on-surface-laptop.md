---
title: PXE boot fails on a Surface Laptop
description: Provides a workaround to the issue in which PXE boot fails on a Surface Laptop.
ms.date: 05/31/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: surface
localization_priority: medium
ms.reviewer: v-six, v-lianna
ms.custom: csstroubleshoot
ms.technology: windows
---
# PXE boot fails on a Surface Laptop

This article provides a workaround to the issue in which PXE boot fails on a Surface Laptop.

_Applies to:_ &nbsp; Windows 10  
_Original KB number:_ &nbsp; 4032346

## Symptoms

When you perform the preboot execution environment (PXE) boot on a Surface Laptop by pressing the power and volume-down buttons, the Windows logo may flash, but the PXE boot attempt fails.

## Workaround

To work around this issue, follow these steps:

1. Press the volume-up and power buttons on the Surface Laptop to enter the [Unified Extensible Firmware Interface (UEFI) settings](https://support.microsoft.com/surface/how-to-use-surface-uefi-df2c8942-dfa0-859d-4394-95f45eb1c3f9).
2. Select **Configure boot device order**.
3. Select the PXE Network, and then swipe to the left.
4. You should receive the "Boot this device immediately" message. Select **OK** to exit and perform the PXE Network boot.

    > [!NOTE]
    > As an alternative to this workaround, you change the boot order so that "PXE Network" is at the top of the list.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.