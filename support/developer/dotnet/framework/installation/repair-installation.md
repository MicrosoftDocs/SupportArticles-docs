---
title: Repair an installation of .NET Framework
description: Describes how to repair the installation of the .NET Framework if you upgrade your operating system.
ms.date: 07/07/2025
ms.reviewer: V-JEFFBO, jagbal
ms.topic: how-to
ms.custom: sap:Installation and Deployment

#customer intent: As a developer or system administrator, I want to repair my installation of .NET Framework after an operating system upgrade so that my applications function properly.
---
# Repair an existing installation of .NET Framework

This article describes how to repair the existing installation of Microsoft .NET Framework. You may need to repair your installation of the .NET Framework if you upgrade your operating system or if the current installation of the .NET Framework becomes corrupted.

## Repair .NET Framework

1. Obtain the original installation source. For example, if you installed the .NET Framework from a CD-ROM or from a digital video disc (DVD), insert that disk. If you downloaded the .NET Framework, download the .NET Framework again. Make sure that you select **save** to disk. If you installed the .NET Framework from a network share, reconnect to that share.

2. Select **Start**, select **Run**, type the following command, and then select **OK**:

   ```console
   N:\dotnetframework\dotnetfx.exe /t:c:\temp /c:"msiexec.exe /i c:\temp\netfx.msi REINSTALL=ALL ReinstallMODE=vomus"
   ```

   > [!NOTE]
   > - Replace `N:\` in this command syntax with the original installation path.
   > - If you don't have a `C:\temp` folder on your computer, create one before you run this command.

The Windows Installer will verify and repair the .NET Framework installation.
