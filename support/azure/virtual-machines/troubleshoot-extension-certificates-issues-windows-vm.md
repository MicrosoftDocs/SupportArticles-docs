---
title: Troubleshoot extension certificate issues on a Windows VM in Azure
description: Learn how to troubleshoot issues that involve certificates on a Windows virtual machine (VM) that uses an extension in Azure.
ms.date: 05/05/2023
editor: v-jsitser
ms.reviewer: kegregoi, axelg, scotro, v-leedennis
ms.service: virtual-machines
ms.subservice: vm-extensions-not-operating
---
# Troubleshoot extension certificate issues on a Windows VM in Azure

This article discusses how to identify and fix issues that involve certificates on a Windows virtual machine (VM) that uses an extension. Usually, these issues are related to cryptographic operations or the certificate itself.

## Troubleshooting checklist

#### View the guest logs

To get details about an error, check the guest logs. The most useful logs on the Windows VM for troubleshooting extension certificate errors are shown in the following table.

| Log | Description |
|-|-|
| The *C:\\WindowsAzure\\Logs\\WaAppAgent.log* log file | The guest agent log. Describes the extension's operations (such as download, install, enable, and disable) and their results. |
| Log files in the *C:\\WindowsAzure\\Logs\\Plugins\\\<ExtensionName>* folder | Various logs that reflect the operations of a particular extension. Each extension has its own features, but most extensions have a standard set of log files, including *CommandExecution.log*, *CommandExecution_\<Timestamp>.log*, *CustomScriptHandler.log*, and *IaaSBcdrExtension\<Number>.log*.  |

> [!NOTE]  
> This table contains only the most notable log files. It isn't a comprehensive list.

Alternatively, you can run the *CollectGuestLogs.exe* tool to collect all the guest logs into a *.zip* archive file. The *CollectGuestLogs.exe* tool is located on the Windows VM in one of the following directories:

- *C:\\WindowsAzure\\Packages*
- *C:\\WindowsAzure\\GuestAgent_\<VersionNumber>_\<Timestamp>*

## Symptoms

The following list outlines the most common errors that might occur when you use an extension on a Windows VM:

- `FailedToDecryptProtectedSettings` exception: The transport certificate that's used to decrypt the protected settings of the extension is missing from the VM.

  > [!NOTE]  
  > A variant of the `FailedToDecryptProtectedSettings` exception causes incorrect permissions to be set on the *Crypto\\RSA\\MachineKeys* folder. In this scenario, one of the following error messages is displayed:
  >
  > ```output
  > System.Security.Cryptography.CryptographicException: Keyset does not exist  
  >   at System.Security.Cryptography.Pkcs.EnvelopedCms.DecryptContent(RecipientInfoCollection recipientInfos, X509Certificate2Collection extraStore)  
  >   at Microsoft.Azure.Plugins.Diagnostics.dll.PluginConfigurationSettingsProvider.DecryptPrivateConfig(String encryptedConfig)  
  > ```
  >
  > ```output
  > Failed to decode, decrypt, and deserialize the protected settings string. Error Message: Keyset does not exist"
  > ```
  >
  > ```output
  > Decrypting Protected Settings - Invalid provider type specified
  > ```
  >
  > ```output
  > [ERROR] Failed to get TransportCertificate. Error: Microsoft.WindowsAzure.GuestAgent.CertificateManager.CryptographyNative+PInvokeException: Self-signed Certificate Generation failed. Error Code: -2146893808.
  > ```

- "Unable to retrieve the certificate" error message.

- `CryptographicException` exception in the VM diagnostics settings, accompanied by the message, "The enveloped-data message does not contain the specified recipient." The following text describes an example of this exception:

  ```output
  DiagnosticsPluginLauncher.exe Information: 0 : [6/29/2020 1:32:20 PM] Decrypting private configuration
  
  DiagnosticsPluginLauncher.exe Warning: 0 : [6/29/2020 1:32:20 PM] No certficate with given thumbprint found in the certificate store. Thumbprint:34C8CDC747693E0E33A9648703E3990EC4F2C484
  
  DiagnosticsPluginLauncher.exe Information: 0 : [6/29/2020 1:32:20 PM] Retrying after 30 seconds. Retry attempt 1
  
  DiagnosticsPluginLauncher.exe Warning: 0 : [6/29/2020 1:32:50 PM] No certficate with given thumbprint found in the certificate store. Thumbprint:34C8CDC747693E0E33A9648703E3990EC4F2C484
  
  DiagnosticsPluginLauncher.exe Information: 0 : [6/29/2020 1:32:50 PM] Retrying after 30 seconds. Retry attempt 2
  
  DiagnosticsPluginLauncher.exe Warning: 0 : [6/29/2020 1:33:20 PM] No certficate with given thumbprint found in the certificate store. Thumbprint:34C8CDC747693E0E33A9648703E3990EC4F2C484
  
  DiagnosticsPluginLauncher.exe Information: 0 : [6/29/2020 1:33:20 PM] Retrying after 30 seconds. Retry attempt 3
  
  DiagnosticsPluginLauncher.exe Error: 0 : [6/29/2020 1:33:50 PM] System.Security.Cryptography.CryptographicException: The enveloped-data message does not contain the specified recipient.
    at System.Security.Cryptography.Pkcs.EnvelopedCms.DecryptContent(RecipientInfoCollection recipientInfos, X509Certificate2Collection extraStore)
    at Microsoft.Azure.Plugins.Diagnostics.dll.PluginConfigurationSettingsProvider.DecryptPrivateConfig(String encryptedConfig)
  ```

- A new certificate that's pushed to the VM, but interferes with other operations.

## Cause: Workflow and dependency code changes

The issue is primarily caused by a change in the Azure platform that was implemented around May 2020. The change was to improve the workflow of the VM extensions and eliminate some dependencies on other Azure components. It requires that extensions, custom resource providers (CRPs), and the guest agent work collectively. Minor bugs have caused secondary issues that are reflected in the extension certificate problems.

## Solution 1: Update the extension certificate

Follow these steps to update to a certificate that can be used successfully together with an extension:

1. Check whether the **Windows Azure CRP Certificate Generator** certificate is included in the Certificates snap-in of the Microsoft Management Console. To do this, follow the instructions in [Multiple certificates on an Azure IaaS VM that uses extensions](multiple-certificates-iaas-vm-extensions.md#windows) to find the Windows VM symptoms.
1. Delete that certificate. To do this, select the **Windows Azure CRP Certificate Generator** certificate, and then select the **Delete** icon.

   > [!NOTE]  
   > When the **Windows Azure CRP Certificate Generator** certificate is needed, the VM re-creates the certificate if it's missing.

1. Trigger a new goal state for the guest agent by applying one of the following options:

   - Run the following PowerShell script that contains the [Get-AzureRmVM](/powershell/module/azurerm.compute/get-azurermvm) and [Update-AzureRmVM](/powershell/module/azurerm.compute/update-azurermvm) commands:

     ```azurepowershell
     $rg = "<name-of-the-resource-group-containing-the-virtual-machine>"
     $vmName = "<name-of-the-virtual-machine>"
     $vm = Get-AzureRmVM -ResourceGroupName $rg -Name $vmName  
     Update-AzureRmVM -ResourceGroupName $rg -VM $vm  
     ```

   - Perform a "reapply" operation on your VM by following the instructions in the "Resolution" section of the [Virtual machine stuck in a failed state](vm-stuck-in-failed-state.md) article.

1. Retry the extension operation.

If the certificate update didn't fix the issue, stop or deallocate the VM, and then start the VM again.

## Solution 2: Fix the access control list (ACL) in the MachineKeys or SystemKeys folders

In the *Crypto\\RSA\\MachineKeys* folder, fix the access control list (ACL) so that the correct permissions are applied.

1. In an administrative PowerShell console, run the following commands to get the unique key container name of the tenant certificate. Make sure that you comment out one of the `$certName` definitions, depending on whether you're using a classic RedDog Front End (RDFE) VM (for which the certificate name is `Windows Azure Service Management for Extensions`) or an Azure Resource Manager VM (for which the certificate name is `Windows Azure CRP Certificate Generator`):

   ```powershell
   # Comment out one of the following certificate name definitions.
   $certName = "Windows Azure Service Management for Extensions"  # Classic RDFE VM
   $certName = "Windows Azure CRP Certificate Generator"          # Azure Resource Manager VM

   $fileName = (Get-ChildItem Cert:\LocalMachine\My |
                   Where-Object {$_.Subject -eq 'DC=$certName'}
               ).PrivateKey.CspKeyContainerInfo.UniqueKeyContainerName
   ```

1. Make a backup of the ACL by running the [icacls](/windows-server/administration/windows-commands/icacls) command:

   ```powershell
   icacls C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /save machinekeys_permissions_before.aclfile /t
   ```

1. Run the following `icacls` commands to correct the *MachineKeys* permissions:

   ```powershell
   icacls C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys\$fileName /grant SYSTEM:(F)
   icacls C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys\$fileName /grant Administrators:(RX)
   ```

1. Run `icacls` again to redirect the updated *MachineKeys* ACLs to a text file:

   ```powershell
   icacls C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /t > machinekeys_permissions_after.txt
   ```

1. View the *machinekeys_permissions_after.txt* file in a text editor to verify that the permission changes appear as expected.

1. Try the extension again, or try to restart the guest agent services by running the *WaAppAgent.exe* or *WindowsAzureGuestAgent.exe* tool.

If this procedure doesn't work, you can try to run the `icacls` commands again (steps 2-4) on the *C:\\ProgramData\\Microsoft\\Crypto\\SystemKeys\\\** wildcard folders instead of the *C:\\ProgramData\\Microsoft\\Crypto\\RSA\\MachineKeys\\$fileName* folder.

## More information

- [Multiple certificates on an Azure IaaS VM that uses extensions](./multiple-certificates-iaas-vm-extensions.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
