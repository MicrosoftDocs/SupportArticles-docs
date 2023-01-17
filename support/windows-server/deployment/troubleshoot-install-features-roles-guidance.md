---
title: Guidance for troubleshooting the installation of Windows features and roles
description: Provides guidance to help troubleshoot issues when adding or removing roles and features in Windows.
ms.date: 05/12/2022
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:servicing, csstroubleshoot
ms.technology: windows-server-deployment
---
# Installing Windows features and roles troubleshooting guidance

This guidance is designed to help troubleshoot issues when adding or removing roles and features in Windows.

## Troubleshooting checklist

1. Check errors in the Windows event log, especially the System event log and the Windows Setup event log. For example, navigate to the following location in Event Viewer and search for Event IDs in the range of 4000 to 4099.

   *Applications And Services Logs\Microsoft\Windows\ServerManager-MultiMachine*

2. Try to add or remove a different role or feature. This method will help to determine if the issue is specific to a role or feature.

3. Verify the state of the component store for any corruption.

   1. Run the following command to repair the Windows image. For more information, see [Repair a Windows image](/windows-hardware/manufacture/desktop/repair-a-windows-image).

      `Dism /Online /Cleanup-Image /RestoreHealth`

   2. The results are logged in the following log file:

      *%windir%/Logs/CBS/CBS.log*

   3. In the log file, search for the following line:

      `Checking System Update Readiness`

4. After verifying the component store and fixing any corruption, run the `SFC /scannow` command at an elevated command prompt to scan and restore Windows files. For more information, see [Use the System File Checker tool to repair missing or corrupted system files](https://support.microsoft.com/help/929833).

## Common support scenarios

See the following list of common issues for scenario-specific guidance:

|Issue or error|Solution|
|-|-|
|Server Manager is collecting inventory data. The wizard will be available after data collection finishes.|Server Manager can't be used to manage servers that are running a newer version of Windows Server than the version that is running Server Manager. For example, Server Manager running in Windows 8 as part of Remote Server Administration Tools can't be used to manage a server that's running Windows Server 2012 R2.|
|Error 0x00070543 when selecting **Roles** in Server Manager|[Error 0x00070543](../system-management-components/error-event-1601-click-roles-server-manager.md)|
|Error 0x800706BE and can't view roles or features|[Error 0x800706BE](../system-management-components/unable-view-roles-features-error-code-0x800706be.md)|
|Error 0x800F0922 when trying to uninstall roles or features|[Error 0x800F0922](error-0x800f0922-uninstall-role-feature.md)|
|Error 0x800F081F when installing features|[Error 0x800F081F](you-cant-install-features.md)|
|Error 0x800F0818 and can't add roles or features|[Error 0x800F0818](/archive/blogs/shanecothran/server-manager-both-roles-and-features-display-error-hresult-0x800f0818)|

For more information, see [Install or uninstall roles, role services, or features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).
