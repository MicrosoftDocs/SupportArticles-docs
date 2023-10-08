---
title: Can't install Visual Studio administrator updates through SCCM and WSUS
description: Provides a resolution for an issue where you can't install Visual Studio administrator updates through SCCM and WSUS.
ms.date: 09/26/2023
ms.reviewer: khgupta, raviuppa, aartigoyle, v-sidong
ms.custom: sap:installation
---
# Unable to install Visual Studio administrator updates through SCCM and WSUS

_Applies to:_ &nbsp; Visual Studio 2022

## Symptoms

You can't install Visual Studio 2022 [administrator updates](/visualstudio/install/applying-administrator-updates) through Microsoft System Center Configuration Manager (SCCM) and [Windows Server Update Services](/windows-server/administration/windows-server-update-services/get-started/windows-server-update-services-wsus) (WSUS).

## Resolution

To enable your Visual Studio client machine to receive updates through WSUS, make sure to prepare the client machine by setting up a few prerequisites.

1. Ensure that the Visual Studio administrator update (for example, the Visual Studio 2022 version 17.7.4 or above update) is [imported into WSUS](/mem/configmgr/sum/get-started/synchronize-software-updates) and approved.

1. Enable the client machine to receive administrator updates by setting a registry key on the client machine:

    a. Open **Registry Editor** by typing *regedit* in the **Start** menu.

    b. Navigate to the registry key depending on the version of Visual Studio you're using:

      - If you're using a 64-bit version of Visual Studio on a 64-bit operating system, use *HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\VisualStudio\Setup*.
      - If you're using a 32-bit version of Visual Studio on a 64-bit operating system, use *HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\VisualStudio\Setup*.

    c. Set the `AdministratorUpdatesEnabled` (type `REG_DWORD`) key to `1`.

   For more information, see [Enabling administrator updates to Visual Studio with Microsoft Endpoint Configuration Manager](/visualstudio/install/enabling-administrator-updates).

1. The Visual Studio Client Detector Utility ([KB5001148 - Visual Studio Client Detector Utility for Administrator Updates](https://support.microsoft.com/topic/kb5001148-visual-studio-client-detector-utility-for-administrator-updates-ad593454-547c-43c3-b5a3-6f201ae63f03)) must be installed on the client machine in order for the administrator updates to be properly recognized and received.

   Ensure that you execute the following command line via an admin PowerShell cmdlet to ensure that it populates the Visual Studio instances installed on the machine:

   `Get-CimInstance MSFT_VSInstance`

1. The ChannelURI in *C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances\\<RandomID\>\state.json* must point to the [release channel](https://aka.ms/vs/17/release/channel).

1. The client machine's SYSTEM account downloads and installs the Visual Studio administrator updates. This means that the SYSTEM account must have administrative privileges to the machine, and it must also have access to the internet or the network layout location to download the updated product bits.
