---
title: Access is denied error when you connect to an Azure Windows VM | Microsoft Docs
description: Provides resolution to the Access is denied issue when you connect to an Azure Windows VM by remote desktop  | Microsoft Docs
services: virtual-machines
documentationCenter: ''
author: genlin
manager: dcscontentpm
editor: ''
ms.service: virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 09/14/2021
ms.author: genli
---

# Access is denied error when you connect to an Azure Windows VM

This article shows how to troubleshoot a problem in which you cannot connect to an Azure Windows virtual machine (VM) because the "Access is denied" error.

## Symptoms

When you connect to an Azure Windows VM by remote desktop, the following error is received in the login screen:

   >Access is denied.

You can connect to the VM by using an administrative RDP session (mstsc /admin), however you notice that there is a networking connectivity error in the notification area.

## Cause

This issue might occur for the following reasons:

- The user does not have permission to read the certificate registry entries on terminal services.
- Fail to load the user profile. This is usually due to some user policies causing a conflict on the profile.
- The size of the Kerberos token is not large enough to contain all the group memberships information for the user. This situation happens when the user belongs to many AD groups and nested AD groups. Windows builds the token to represent the user for purposes of authorization. This token (also called an authorization context) includes the security identifiers (SID) of the user, and the SIDs of all of the groups that the user belongs to.


## Solution

Before start troubleshooting, [back up the OS disk](/azure/virtual-machines/windows/snapshot-copy-managed-disk). Then connect to the VM by using the Azure Serial Console and [start a PowerShell session]( serial-console-windows.md#use-serial-console). If the Azure Serial Console does not work, connect the VM by remote PowerShell. For more information see [How to use remote tools to troubleshoot Azure VM issues](remote-tools-troubleshoot-azure-vm-issues.md).

After you connect to the VM by using PowerShell, follow these steps to troubleshoot the issues. Restart the VM and check if the problem is resolved after each step.

 1. Check if the local **Remote Desktop Users** have read permission over the following key:

    ```
    Get-Acl -Path "HKLM:\SOFTWARE\Microsoft\SystemCertificates\Remote Desktop\Certificates" | Format-List 
    ```
    
    If this permission is not granted, run the following commands to grant the read access for local Remote Desktop Users.

    ```
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

    ```
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -name "IgnoreRegUserConfigErrors" 1 -Type DWord -force
    ```

 3. Set the size of the token to maximum
     ```
	Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters' -name "MaxTokenSize" 65535 -Type DWord -force 
    ```
1. Set correct account for the Terminal services:
    ```
	Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\services\termservice' -name "ObjectName" "NT Authority\NetworkService" -Type String -force
   ```



## Need help? Contact support

If you still need help, [contact support](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) to get your issue resolved.


