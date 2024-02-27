---
title: Package Manager can install only the first package when you extract two or more packages to the same folder in Windows Vista
description: Describes a problem that occurs because Package Manager can't manage two or more packages in the same sandbox. To resolve this problem, don't expand two or more packages to the same folder. Or, create a different sandbox for each package.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: tarekr, cochen, kaushika
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Package Manager can install only the first package when you extract two or more packages to the same folder in Windows Vista

This article describes a problem that occurs because Package Manager can't manage two or more packages in the same sandbox.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 932224

## Symptoms

In Windows Vista, the Package Manager tool can install only the first package when you extract two or more packages to the same folder.

For example, consider the following scenario:

- On a computer that is running Windows Vista, you create a C:\\Temp folder.
- You download the following hotfix packages to this folder:

  - Windows6.0-KB929761-x86.msu
  - Windows6.0-KB932590-x86.msu

    These hotfix packages are for hotfix 929761 and hotfix 932590.
- You run the following commands to expand the hotfix packages:

    ```console
    c:\temp>expand c:\temp\Windows6.0-KB929761-x86.msu -F:Windows6.0-KB929761-x86.cab c:\temp

    c:\temp>expand c:\temp\Windows6.0-KB932590-x86.msu -F:Windows6.0-KB932590-x86.cab c:\temp
    ```

- You run the following commands to install the packages:

    ```console
    start /w Pkgmgr /ip /m:c:\temp\Windows6.0-KB929761-x86.cab

    start /w Pkgmgr /ip /m:c:\temp\Windows6.0-KB932590-x86.cab
    ```

In this scenario, Package Manager installs only the package for hotfix 929761.

When this problem occurs, information that resembles the following may appear in the Cbs.log file:

In this example Cbs.log file, Package Manager indicates that it will install the .cab file for hotfix 932590. However, it actually installs the Package_1_for_KB929761~31bf3856ad364e35~x86~~6.0.1.1 package. This is the hotfix 929761 package.

> [!NOTE]
> This problem also applies to Windows Server 2008.

## Cause

This problem occurs because Package Manager can't manage two or more packages in the same sandbox.

## Resolution

To work around this problem perform one of the following methods.

Method 1:

Expand each package to different folder before you installing them with pkgmgr. To do this, type the following commands at a command prompt:

```console
Delete update*.*

Mkdir c:\temp\sandbox1

Mkdir c:\temp\sandbox2

Start /w pkgmgr /ip /m:c:\temp\ CabFile /s:c:\temp\sandbox1

Start /w pkgmgr /ip /m:c:\temp\ CabFile /s:c:\temp\sandbox2
```

In these commands, **CabFile** represents the .cab file for the hotfix package.

Method 2:

Another workaround is to use DISM to service Windows Vista SP1 and Windows Server 2008 offline images.

Considerations of using DISM with Windows Server 2008/Vista SP1 Images:  

- The Windows image that you're updating must be Windows Vista with SP1 or Windows Server 2008 or later.
- If you're servicing a Windows Vista with SP1 or Windows Server 2008 image, DISM will translate the DISM command to the equivalent Package Manager command so that the image can be updated. DISM provides functional parity to Package Manager.
- Only offline scenarios are supported
- DISM is pre-installed with Windows 7 and Windows Server 2008 R2, and is included in the Windows Automated Installation Kit for Windows 7. The Windows Automated Installation Kit can be installed on Windows Vista and Windows 2008.

*Editor note: download link for Win7 waik: [The Windows Automated Installation Kit (AIK) for Windows 7](https://www.microsoft.com/download/details.aspx?id=5753)*

Add the Packages to an Offline Image by Using DISM

1. At an elevated command prompt, navigate to the OPK servicing folder, and type the following command to retrieve the name or index number for the image you want to modify.

    ```console
    Dism /Get-WIMInfo /WimFile:C:\test\images\install.wim
    ```

    > [!NOTE]
    > An index or name value is required for most operations that specify a Windows imaging (WIM) file.

2. Type the following command to mount the offline Windows image.

    ```console
    Dism /Mount-WIM /WimFile:C:\test\images\install.wim /Name:"Windows 7 HomeBasic" /MountDir:C:\test\offline
    ```

3. At a command prompt, type the following command to add a specific package to the image. You can add multiple packages on one command line. The packages will be installed in the order listed in the command line.

    ```console
    Dism /Image:C:\test\offline /Add-Package /PackagePath:C:\packages\package1.cab /PackagePath:C:\packages\package2.cab
    ```

    > [!NOTE]
    > .cab is extracted from .msu file.

4. At a command prompt, type the following command to commit the changes and unmount the image.

    ```console
    Dism /Unmount-WIM /MountDir:C:\test\offline /Commit
    ```

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
