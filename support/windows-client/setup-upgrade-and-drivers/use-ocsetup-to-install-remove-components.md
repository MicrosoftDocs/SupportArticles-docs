---
title: Use Ocsetup.exe to install/remove optional components
description: Describes the Windows optional component setup (Ocsetup.exe) tool.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jomcc
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# How to use the Ocsetup.exe tool to install or to remove Windows optional components in Windows Vista

This article describes how to use the Windows optional component setup tool (Ocsetup.exe) to install or to remove Windows optional components.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 936209

## Summary

Windows optional components are parts of the Windows operating system that can be individually added, removed, enabled, or disabled. You can use the Ocsetup.exe tool at the command prompt to install or to remove Windows Vista optional components. You must have administrative credentials to run the Ocsetup.exe tool.

### Use Ocsetup.exe to install Windows optional components

1. Click **Start**, right-click **Command Prompt**, and then click **Run as administrator**.
2. At the command prompt, type the following command, and then press ENTER: `start /w ocsetup <Optional component name>`

     > [!NOTE]
     >
     > - In step 2, **Optional component name** specifies the name of the Windows optional component. The optional component name is case-sensitive. For example, if you want to install the DHCP Server role, type `start /w ocsetup DHCPServerCore`, and then press ENTER.
     > - To determine the correct optional component name for Windows Vista to use with the ocsetup command line, visit the following Web page, and then review the "Command-Line Name" column in the Microsoft-Windows-Foundation-Package Features table: [Windows Vista Packages](https://technet.microsoft.com/library/cc722041.aspx )

3. Type *exit*, and then press ENTER to close the Command Prompt window.

> [!NOTE]
> To display the list of command-line switches that the Ocsetup.exe tool supports, type ocsetup at the command prompt, and then press ENTER.

### Use Ocsetup.exe to remove Windows optional components

1. Click **Start**, right-click **Command Prompt**, and then click **Run as administrator**.
2. At the command prompt, type the following command, and then press ENTER: `start /w ocsetup <Optional component name> /uninstall`

    > [!NOTE]
    >
    > - In step 2, **Optional component name** specifies the name of the Windows optional component. The optional component name is case-sensitive. For example, if you want to remove the DHCP Server role, type `start /w ocsetup DHCPServerCore/uninstall`, and then press ENTER.
    > - To determine the name of the Windows optional component, click **Start**, type *optionalfeatures* in the **Start Search** box, and then click **optionalfeatures** in the **Programs** list.

3. Type *exit*, and then press ENTER to close the Command Prompt window.

    > [!NOTE]
    > To display the list of command-line switches that the Ocsetup.exe tool supports, type ocsetup at the command prompt, and then press ENTER.

## Ocsetup.exe tool functionality

The Ocsetup.exe tool provides functionality that resembles the functionality that the Sysocmgr.exe tool provides in Microsoft Windows XP and in Microsoft Windows Server 2003. In Windows Vista, Windows Defender Software Explorer and Windows Update use the Ocsetup.exe tool. In Windows Server 2008, Server Manager uses the Ocsetup.exe tool.

The Ocsetup.exe tool is used as a wrapper for Package Manager (Pkgmgr.exe) and for Windows Installer (Msiexec.exe). Ocsetup.exe is a command-line utility that can be used to perform scripted installs and scripted uninstalls of Windows optional components. The Ocsetup.exe tool replaces the Sysocmgr.exe tool that Windows XP and Windows Server 2003 use.

Windows optional components can be MSI-based or component-based. The Ocsetup.exe tool detects the type of optional component that is passed as a parameter. Additionally, the Ocsetup.exe tool calls the correct child process to install or to remove the optional component. If the optional component is MSI-based, the Ocsetup.exe tool calls Msiexec.exe. If the optional component is component-based, the Ocsetup.exe tool calls Pkgmgr.exe. The Ocsetup.exe tool returns back to the caller the exit code that is received from Pkgmgr.exe, from Msiexec.exe, or from the custom bootstrapping application.

For system optional components that are MSI-based, the Ocsetup.exe tool first checks a registry location to determine one of the following:

- If a component uses the generic bootstrapping application (Ocsetup.exe).
- If a component has a special custom-made bootstrapping application that performs install tasks or removal tasks.
    Based on this determination, the Ocsetup.exe tool passes the task to the custom bootstrapping application, or the Ocsetup.exe tool internally performs generic bootstrapping tasks. The Ocsetup.exe tool performs the following generic tasks:
- Checks the cache directory for updates.
- Passes the MSI package name and the MSI package location to Windows Installer.
- Passes names of one or more .msp files to Windows Installer. The Ocsetup.exe tool also accepts configuration information that is supplied as an unattended file. For more information, see the unattended documentation.

## References

For more information about command-line options that are available for Package Manager, visit the following Microsoft Web site: [Package Manager Command-Line Options](https://technet.microsoft.com/library/cc749465.aspx)

For more information about Windows Installer, visit the following Microsoft Web site: [Windows Installer](/windows/win32/msi/windows-installer-portal)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
