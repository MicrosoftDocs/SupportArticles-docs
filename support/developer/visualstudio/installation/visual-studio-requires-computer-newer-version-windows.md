---
title: Visual Studio requires a computer with a newer version of Windows
description: Provides a resolution for the issue "This version of Visual Studio requires a computer with a newer version of Windows".
ms.date: 04/07/2022
author: jasonchlus
ms.author: jasonchlus
ms.reviewer: terry.g.lee
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---

# Error "This version of Visual Studio requires a computer with a newer version of Windows"

_Applies to:_&nbsp;Visual Studio 2015

## Symptom

When attempting to install Visual Studio 2015, you receive the following message:

> This version of Visual Studio requires a computer with a newer version of Windows.

The minimum operating [system requirement](/visualstudio/productinfo/vs2015-sysrequirements-vs) for Visual Studio 2015 is Windows 7 with Service Pack 1 (or higher).

## Resolution

To resolve the issue, follow these steps:

1. Download Service Pack 1 (SP1).

    You can download and install SP1 for Windows 7 from [Microsoft.com](https://support.microsoft.com/help/15090/windows-7-install-service-pack-1-sp1) for free.

1. Confirm that SP1 is installed by following these steps:

    1. Select **Start**, right-click **Computer**, and then select **Properties**.

    1. Check the Windows edition section. If Service Pack 1 is listed, Windows 7 SP1 is already installed on your computer.

1. Launch the Visual Studio installer again.
