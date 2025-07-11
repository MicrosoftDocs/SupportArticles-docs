---
title: Repair an Installation of .NET Framework
description: Describes how to repair an installation of .NET Framework after you upgrade your operating system.
ms.date: 07/07/2025
ms.reviewer: V-JEFFBO, jagbal
ms.topic: how-to
ms.custom: sap:Installation and Deployment

#customer intent: As a developer or system administrator, I want to repair my installation of .NET Framework after an operating system upgrade so that my applications function correctly.
---
# Repair an existing installation of .NET Framework

This article describes how to repair an existing installation of Microsoft .NET Framework. You might have to repair this installation after you upgrade your operating system or if the current installation of .NET Framework becomes corrupted.

_Original product version:_ Microsoft .NET Framework

_Original KB number:_ 306160

## Repair .NET Framework

The Windows installer verifies and repairs the .NET Framework installation. Follow these steps:

1. Get the original installation source. For example, if you installed .NET Framework from a CD-ROM or a digital video disc (DVD), insert that disk. If you downloaded .NET Framework, download the installation file again, and make sure that you select **Save to disk**. If you installed .NET Framework from a network share drive, reconnect to that share.

2. Select **Start**, select **Run**, enter the following command, and then select **OK**:

   ```console
   N:\dotnetframework\dotnetfx.exe /t:c:\temp /c:"msiexec.exe /i c:\temp\netfx.msi REINSTALL=ALL ReinstallMODE=vomus"
   ```

   > [!NOTE]
   > - In this command, replace `N:\` with the original installation path.
   > - If you don't have a `C:\temp` folder on your computer, create one before you run this command.
