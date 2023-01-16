---
title: Troubleshoot a failed trust relationship in an Azure Windows VM
description: This article shows how to troubleshoot a failed trust relationship between the workstation and primary domain in an Azure Windows virtual machine (VM).
services: virtual-machines, azure-resource-manager
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: top-support-issue, azure-resource-manager
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting
ms.date: 09/03/2021
ms.author: tibasham

---

# Troubleshoot a failed trust relationship in an Azure Windows VM

This article shows how to troubleshoot a failed trust relationship between the workstation and primary domain in an Azure Windows virtual machine (VM).

If your Azure issue isn't addressed in this article, visit the Azure forums on [MSDN and Stack Overflow](https://azure.microsoft.com/support/forums/). You can post your issue in these forums, or post to [@AzureSupport on Twitter](https://twitter.com/AzureSupport). You also can [submit a Microsoft Azure support request](/azure/azure-portal/supportability/how-to-create-azure-support-request).

To submit a support request, go to the [Azure support page](https://azure.microsoft.com/support/options/) and select **Get support**.

## Symptom

You're unable to complete a remote desktop protocol (RDP) connection to the VM and you receive the error: "The trust relationship between this workstation and the primary domain failed".

:::image type="content" source="media/troubleshoot-broken-secure-channel/other-user-failed-ok-button.png" alt-text="Screenshot of the error The trust relationship between this workstation and the primary domain failed. This screenshot also includes the ok button." border="false":::

## Cause

The Active Directory Secure Channel between this VM and the primary domain is broken. This error shows that the machine can't establish a secure communication with a domain controller in its domain, because the secret password isn't set to the same value in the domain controller.

## Solution

Complete the following steps on the VM. If available, try to connect to the VM via remote desktop connection (RDC) using a local user. If you can't connect to the VM using RDC, try an alternate [remote troubleshooting tool for Azure VMs](remote-tools-troubleshoot-azure-vm-issues.md).

### Check the connectivity to the domain controller

1. To find the domain controller that your VM is using, enter the following command in CMD.exe.

   `set | find /i "LOGONSERVER"`

2. Check network connectivity to the domain controller. For example, you can use the [Test-Connection](/powershell/module/microsoft.powershell.management/test-connection) cmdlet to test connectivity to the Fully Qualified Domain Name (FQDN) of the domain controller identified in step 1.

3. If there is no connectivity to the domain controller from your VM, troubleshoot the network path. [Network Watcher diagnostics](/azure/network-watcher/network-watcher-monitoring-overview#diagnostics) may help in this troubleshooting.

### Check the health of the secure channel

1. Using PowerShell, execute the '[Test-ComputerSecureChannel](/powershell/module/microsoft.powershell.management/test-computersecurechannel)' cmdlet to see if the secure channel is healthy.

   Example:

   `Test-ComputerSecureChannel -verbose`

2. If the secure channel is healthy, attempt to RDP to the VM using your domain user. If the secure channel isn't healthy, attempt to repair the secure channel.

### Repair the secure channel

If the secure channel isn't healthy, either try to fix it, or rejoin the VM to the domain.

1. Using PowerShell, execute the '[Test-ComputerSecureChannel](/powershell/module/microsoft.powershell.management/test-computersecurechannel)' cmdlet to repair the secure channel.

   `Test-ComputerSecureChannel -Repair`

2. If the secure channel is not repaired, reset the machine password.

### Reset the machine password

If you couldn't repair the secure channel, try to reset the machine password.

1. Using PowerShell, execute the '[Reset-ComputerMachinePassword](/powershell/module/microsoft.powershell.management/reset-computermachinepassword)' cmdlet to reset the machine password of the VM.

   Example:

   ```powershell
   $cred = Get-Credential
   Invoke-Command -ComputerName "Server01" -ScriptBlock {Reset-ComputerMachinePassword -Credential $using:cred}
   ```

2. If this doesn't re-establish the secure channel, remove the VM from the domain and re-join the domain.

### Remove the VM from the domain and re-join the domain

As a last option, remove the VM from the domain and then re-join the domain.

1. Using PowerShell, execute the '[Remove-Computer](/powershell/module/microsoft.powershell.management/remove-computer)' cmdlet to remove the VM from the domain.

   Example:

   ```powershell
   'Remove-Computer -UnjoinDomaincredential Domain01\Admin01 -PassThru -Verbose -Restart'
   ```

2. Using PowerShell, execute the '[Add-Computer](/powershell/module/microsoft.powershell.management/add-computer)' cmdlet to re-join the VM to the domain.

   Example:

   ```powershell
   'Add-Computer -ComputerName Server01 -LocalCredential Server01\Admin01 -DomainName Domain02 -Credential Domain02\Admin02 -Restart -Force'
   ```

## Additional resources

[Detailed Concepts: Secure Channel Explained](https://social.technet.microsoft.com/wiki/contents/articles/24644.detailed-concepts-secure-channel-explained.aspx#What_is_a_broken_secure_channel)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
