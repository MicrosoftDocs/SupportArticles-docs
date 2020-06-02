---
title: Repair an installation of .NET Framework
description: Describes how to repair the installation of the .NET Framework if you upgrade your operating system.
ms.date: 05/06/2020
ms.prod-support-area-path: 
ms.reviewer: V-JEFFBO
---
# How to repair an existing installation of the.NET Framework

This article describes how to repair the existing installation of the Microsoft .NET Framework if you upgrade your operating system.

_Original product version:_ &nbsp; Microsoft .NET Framework  
_Original KB number:_ &nbsp; 306160

## Summary

You may need to repair your installation of the .NET Framework if you upgrade your operating system or if the current installation of the .NET Framework becomes corrupted.

## Steps to repair the .NET Framework installation

1. Obtain the original installation source. For example, if you installed the .NET Framework from a CD-ROM or from a digital video disc (DVD), insert that disc. If you downloaded the .NET Framework, download the .NET Framework again. Make sure that you click **save** to disk. If you installed the .NET Framework from a network share, reconnect to that share.
2. Click **Start**, click **Run**, type the following command, and then click **OK**:

    ```console
    N:\dotnetframework\dotnetfx.exe /t:c:\temp /c:"msiexec.exe /i c:\temp\netfx.msi REINSTALL=ALL ReinstallMODE=vomus"
    ```

    > [!NOTE]
    >
    > - Replace *N:\\* in this command syntax with the original installation path.
    > - If you don't have a `C:\temp` folder on your computer, create one before you run this command.

The Microsoft Windows Installer will verify and repair the .NET Framework installation.
