---
title: Access is denied error when you connect to an Azure Windows VM
description: Resolves an access denial problem that occurs when you try to connect to an Azure Windows VM by using Remote Desktop.
services: virtual-machines
documentationCenter: ''
author: JarrettRenshaw
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 09/14/2021
ms.author: jarrettr
ms.custom: sap:Cannot connect to my VM
---
# Access is denied when you try to connect to an Azure Windows VM

**Applies to:** :heavy_check_mark: Windows VMs

This article explains how to troubleshoot a problem that prevents you from connecting to an Azure Windows virtual machine (VM) because of an "access is denied" error.

## Symptoms

When you try to connect to an Azure Windows VM by using Remote Desktop Protocol (RDP), you receive the following error message on the login screen:

   >Access is denied.

You can connect to the VM by using an administrative RDP session (mstsc /admin). However, you notice that a networking connectivity error is indicated in the notification area.

## Cause

This problem might occur for the following reasons:

- The user does not have permissions to read the certificate registry entries on the terminal services.
- The user profile didn't load. This situation usually occurs because of some user policies that cause a conflict on the profile.
- The size of the Kerberos token is not large enough to contain all the group membership information for the user. This situation occurs if the user belongs to many Active Directory (AD) groups and nested AD groups. Windows builds the token to represent the user for authorization. This token (also called an authorization context) includes the security identifiers (SID) of the user together with the SIDs of all of the groups that the user belongs to.

## Resolution

Before you begin troubleshooting, [back up the OS disk](/azure/virtual-machines/windows/snapshot-copy-managed-disk). Then, connect to the VM by using the Azure Serial Console, and [start a PowerShell session]( serial-console-windows.md#use-serial-console). If the Azure Serial Console does not work, connect to the VM by Remote PowerShell. For more information,see [How to use remote tools to troubleshoot Azure VM issues](remote-tools-troubleshoot-azure-vm-issues.md).

After you connect to the VM by using PowerShell, follow these steps to troubleshoot the issues. After each step, restart the VM, and check whether the problem is resolved.

 1. Check whether the **Remote Desktop Users**  group has the Read permission for the following key:

    ```powershell
    Get-Acl -Path "HKLM:\SOFTWARE\Microsoft\SystemCertificates\Remote Desktop\Certificates" | Format-List 
    ```

    If this permission is not granted, run the following commands to grant Read access to the **Remote Desktop Users** group:

    ```powershell
    $NewAcl = Get-Acl -Path " HKLM:\SOFTWARE\Microsoft\SystemCertificates\Remote Desktop\Certificates"
    # Set properties
    $identity = "BUILTIN\Remote Desktop Users"
    $fileSystemRights = "read"
    $type = "Allow"
    # Create new rule
    $fileSystemAccessRuleArgumentList = $identity, $fileSystemRights, $type
    $fileSystemAccessRule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $fileSystemAccessRuleArgumentList
    # Apply new rule
    $NewAcl.SetAccessRule($fileSystemAccessRule)
    Set-Acl -Path " HKLM:\SOFTWARE\Microsoft\SystemCertificates\Remote Desktop\Certificates " -AclObject $NewAcl
    ```

 2. Set the following registry key value to ignore the profile loading error:

    ```powershell
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -name "IgnoreRegUserConfigErrors" 1 -Type DWord -force
    ```

 3. Set the size of the token to its maximum value:

     ```powershell
     Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters' -name "MaxTokenSize" 65535 -Type DWord -force 
     ```

 1. Set the correct account for the terminal services:

    ```powershell
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\services\termservice' -name "ObjectName" "NT Authority\NetworkService" -Type String -force
    ```

 1. Restart VM to make the registry changes take effect.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
