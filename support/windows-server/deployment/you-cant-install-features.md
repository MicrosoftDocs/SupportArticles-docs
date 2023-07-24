---
title: You can't install features
description: Resolves an issue that prevents you from adding features to a Windows Server 2012 R2-based computer that's running the Server Core installation option. This problem occurs if the server doesn't have Internet access or access to Windows Update.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, wesk
ms.custom: sap:servicing, csstroubleshoot
ms.technology: windows-server-deployment
---
# You can't install features in Windows Server 2012 R2

This article provides a solution to an issue that prevents you from adding features to a Windows Server 2012 R2-based computer that's running the Server Core installation option.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2913316

## Symptoms

Consider the following scenario:

- You have a computer that's running Windows Server 2012 R2.
- The computer is running the Server Core installation option.
- The Server Core option was installed by using Volume Licensing media that doesn't have access to Windows Update.

In this scenario, the feature installation fails. Also, you receive the following error message:

> Error: 0x800f081f  
The source files could not be found.
Use the "Source" option to specify the location of the files that are required to restore the feature. For more information
on specifying a source location, see [Configure a Windows Repair Source](https://go.microsoft.com/fwlink/?LinkId=243077).

## Resolution

To resolve this problem, use one of the following methods.

### Method 1: Connect to the Internet

­If the server can connect to Windows Update for the feature installation, let the server make the connection.

### Method 2: Use Windows Server 2012 R2 installation media

If the server can't connect to Windows Update, download the new Volume Licensing media (released on December 11, 2013) and use the [Install-WindowsFeature](/powershell/module/servermanager/install-windowsfeature?view=winserver2012r2-ps&preserve-view=true) PowerShell command. To do it, follow these steps:

1. Insert the updated Windows Server 2012 R2 DVD into the computer's DVD drive.

2. Type the following command to determine the index number that's required for steps 3 and 4.

    ```powershell
    Dism /get-wiminfo /wimfile:<drive>:\sources\install.wim
    ```

    > [!NOTE]
    > In this command, \<drive> represents the actual drive letter.

    Example output from the DISM command:

    ```console
    Index : 1
    Name : Windows Server 2012 R2 SERVERSTANDARDCORE
    Description : Windows Server 2012 R2 SERVERSTANDARDCORE
    Size : 6,653,342,051 bytes
    Index : 2
    Name : Windows Server 2012 R2 SERVERSTANDARD
    Description : Windows Server 2012 R2 SERVERSTANDARD
    Size : 11,807,528,410 bytes
    Index : 3
    Name : Windows Server 2012 R2 SERVERDATACENTERCORE
    Description : Windows Server 2012 R2 SERVERDATACENTERCORE
    Size : 6,653,031,430 bytes
    Index : 4
    Name : Windows Server 2012 R2 SERVERDATACENTER
    Description : Windows Server 2012 R2 SERVERDATACENTER
    Size : 11,809,495,151 bytes
    ```

    > [!NOTE]
    > When you specify the \<index> number in the Install-WindowsFeature PowerShell cmdlet in step 4, you must use the index number for the full (non-core) version of the SKU that you currently have installed. For example, if you have Windows Server 2012 R2 Datacenter installed, the required index number is 4. If you have Windows Server 2012 R2 Standard installed, the required index number is 2.
3. Open a PowerShell command prompt by typing the following command:

    ```Powershell
    Powershell.exe
    ```

4. Type the following PowerShell command, in which \<drive> represents the location of the Windows Server 2012 R2 installation files and \<index> represents the numbered index from step 2:

    ```Powershell
    Install-WindowsFeature Server-Gui-Mgmt-Infra,Server-Gui-Shell -Source wim:<drive>:\sources\install.wim:<index>
    ```

    For example: If your media is on drive F, and you're installing the full version of Datacenter, enter the following command:

    ```Powershell
    Install-WindowsFeature Server-Gui-Mgmt-Infra,Server-Gui-Shell -Source wim:f:\sources\install.wim:4
    ```

## More information

The Windows Server 2012 R2 Volume Licensing media was designed to require access to Windows Update to add optional components or features that aren't included in the side-by-side repository. If the server doesn't have Internet access, or if access to Windows Update has been restricted, you can't enable optional components or features by using the DISM command, Windows PowerShell cmdlets, or Server Manager.

## Status

Microsoft has confirmed it to be a problem in the packaging of volume licensed media for Windows Server 2012 R2. This behavior isn't by design and has been corrected in the Volume Licensing build that was released on December 11, 2013. Use the new media for any Windows Server 2012 R2 installations. See the [Resolution](#resolution) section to resolve this problem on servers on which you can't install features.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
