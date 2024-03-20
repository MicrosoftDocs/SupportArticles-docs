---
title: Troubleshooting BitLocker boot errors on an Azure VM
description: Learn how to troubleshoot BitLocker boot errors in an Azure VM
services: virtual-machines
author: genlin
manager: dcscontentpm
editor: v-jesits
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 04/16/2021
ms.author: genli
ms.custom: has-adal-ref, devx-track-azurepowershell
---
# BitLocker boot errors on an Azure VM

 This article describes BitLocker errors that you may experience when you start a Windows virtual machine (VM) in Microsoft Azure.

## Symptom

 A Windows VM doesn't start. When you check the screenshots in the [Boot diagnostics](./boot-diagnostics.md) window, you see one of the following error messages:

- Plug in the USB driver that has the BitLocker key

- You’re locked out! Enter the recovery key to get going again (Keyboard Layout: US) The wrong sign-in info has been entered too many times, so your PC was locked to protect your privacy. To retrieve the recovery key, go to <https://windows.microsoft.com/recoverykeyfaq> from another PC or mobile device. In case you need it, the key ID is XXXXXXX. Or, you can reset your PC.

- Enter the password to unlock this drive [ ] Press the Insert Key to see the password as you type.
- Enter your recovery key Load your recovery key from a USB device.

## Cause

This problem may occur if the VM cannot locate the BitLocker Recovery Key (BEK) file to decrypt the encrypted disk.

## Decrypt the encrypted OS disk

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To resolve this problem, stop and deallocate the VM, and then start it. This operation forces the VM to retrieve the BEK file from the Azure Key Vault, and then put it on the encrypted disk.

If this method does not the resolve the problem, follow these steps to restore the BEK file manually:

1. Take a snapshot of the OS disk of the affected VM as a backup. For more information, see [Snapshot a disk](/azure/virtual-machines/windows/snapshot-copy-managed-disk).
2. [Attach the OS disk to a recovery VM](troubleshoot-recovery-disks-portal-windows.md). When you attach a managed disk, you might receive a "contains encryption settings and therefore cannot be used as a data disk” error message. In this situation, run the following script to try again to attach the disk:

    ```Powershell
    $rgName = "myResourceGroup"
    $osDiskName = "ProblemOsDisk"
    # Set the EncryptionSettingsEnabled property to false, so you can attach the disk to the recovery VM.
    New-AzDiskUpdateConfig -EncryptionSettingsEnabled $false |Update-AzDisk -diskName $osDiskName -ResourceGroupName $rgName

    $recoveryVMName = "myRecoveryVM" 
    $recoveryVMRG = "RecoveryVMRG" 
    $OSDisk = Get-AzDisk -ResourceGroupName $rgName -DiskName $osDiskName;

    $vm = get-AzVM -ResourceGroupName $recoveryVMRG -Name $recoveryVMName 

    Add-AzVMDataDisk -VM $vm -Name $osDiskName -ManagedDiskId $osDisk.Id -Caching None -Lun 3 -CreateOption Attach 

    Update-AzVM -VM $vm -ResourceGroupName $recoveryVMRG
    ```

     You cannot attach a managed disk to a VM that was restored from a blob image.

3. After the disk is attached, make a remote desktop connection to the recovery VM.
1. [Install the Az PowerShell module and Az.Account 1.9.4](#install-az-powershell-module) in the recovery VM.

4. Open an elevated Azure PowerShell session (Run as administrator). Run the following commands to sign in to Azure subscription:

    ```Powershell
    Add-AzAccount -SubscriptionID [SubscriptionID]
    ```

5. Run the following script to check the name of the BEK file (secret name):

    ```powershell
    $vmName = "myVM"
    $vault = "myKeyVault"
    Get-AzKeyVaultSecret -VaultName $vault | where {($_.Tags.MachineName -eq $vmName) -and ($_.ContentType -match 'BEK')} `
            | Sort-Object -Property Created `
            | ft  Created, `
                @{Label="Content Type";Expression={$_.ContentType}}, `
                @{Label ="MachineName"; Expression = {$_.Tags.MachineName}}, `
                @{Label ="Volume"; Expression = {$_.Tags.VolumeLetter}}, `
                @{Label ="DiskEncryptionKeyFileName"; Expression = {$_.Tags.DiskEncryptionKeyFileName}}
    ```

    The following is sample of the output. In this case, we assume that the file name is EF7B2F5A-50C6-4637-0001-7F599C12F85C.BEK.

    ```
    Created               Content Type Volume MachineName DiskEncryptionKeyFileName
    -------               ------------ ------ ----------- -------------------------
    11/20/2020 7:41:56 AM BEK          C:\    myVM   EF7B2F5A-50C6-4637-0001-7F599C12F85C.BEK
    ```

    If you see two duplicated volumes, the volume that has the newer timestamp is the current BEK file that is used by the recovery VM.

    If the **Content Type** value is **Wrapped BEK**, go to the [Key Encryption Key (KEK) scenarios](#key-encryption-key-scenario--wrapped-bek).

    Now that you have the name of the BEK file for the drive, you have to create the secret-file-name.BEK file to unlock the drive.

6. Download the BEK file to the recovery disk. The following sample saves the BEK file to the C:\BEK folder. Make sure that the `C:\BEK\` path exists before you run the scripts.

    ```powershell
    $vault = "myKeyVault"
    $bek = "EF7B2F5A-50C6-4637-0001-7F599C12F85C"
    $keyVaultSecret = Get-AzKeyVaultSecret -VaultName $vault -Name $bek
    $bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($keyVaultSecret.SecretValue)
    $bekSecretBase64 = [Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
    $bekFileBytes = [Convert]::FromBase64String($bekSecretbase64)
    $path = "C:\BEK\DiskEncryptionKeyFileName.BEK"
    [System.IO.File]::WriteAllBytes($path,$bekFileBytes)
    ```

7. To unlock the attached disk by using the BEK file, run the following command.

    ```powershell
    manage-bde -unlock F: -RecoveryKey "C:\BEK\EF7B2F5A-50C6-4637-0001-7F599C12F85C.BEK"
    ```

    In this sample, the attached OS disk is drive F. Make sure that you use the correct drive letter.

8. After the disk was successfully unlocked by using the BEK key, detach the disk from the recovery VM, and then recreate the VM by using this new OS disk.

    > [!NOTE]
    > Swapping OS disk is available for any VM encrypted with Single pass ADE version, but is not supported for Dual Pass.

9. If the new VM still cannot boot normally, try one of following steps after you unlock the drive:

    - Suspend protection to temporarily turn BitLocker OFF by running the following:

    ```console
    manage-bde -protectors -disable F: -rc 0
    ```

    - Fully decrypt the drive. To do this, run the following command:

    ```console
    manage-bde -off F:
    ```

## Key Encryption Key scenario  (Wrapped BEK)

For a Key Encryption Key scenario, follow these steps:

1. Make sure that the logged-in user account requires the "unwrapped" permission in the Key Vault Access policies in the **USER|Key permissions|Cryptographic Operations|Unwrap Key**.
2. Save the following script to a .PS1 file:
    > [!NOTE]
    > The ADAL Assemblies (dll files) that are used in this script are only available in [Az.Account 1.9.4](https://www.powershellgallery.com/packages/Az.Accounts/1.9.4), and the earlier versions. To install the Az.Account module, see [Install Az PowerShell module](#install-az-powershell-module).

    ```powershell
    #Set the Parameters for the script. If you have question about the Parameters, see the "KEK script parameters" section.
    param (
            [Parameter(Mandatory=$true)]
            [string] 
            $keyVaultName,
            [Parameter(Mandatory=$true)]
            [string] 
            $kekName,
            [Parameter(Mandatory=$true)]
            [string]
            $secretName,
            [Parameter(Mandatory=$true)]
            [string]
            $bekFilePath,
            [Parameter(Mandatory=$true)]
            [string] 
            $adTenant
            )
    # Load ADAL Assemblies. If the ADAL Assemblies cannot be found, please see the "Install Az PowerShell module" section. 

    $adal = "${env:ProgramFiles}\WindowsPowerShell\Modules\Az.Accounts\1.9.4\PreloadAssemblies\Microsoft.IdentityModel.Clients.ActiveDirectory.dll"
    $adalforms = "${env:ProgramFiles}\WindowsPowerShell\Modules\Az.Accounts\1.9.4\PreloadAssemblies\Microsoft.IdentityModel.Clients.ActiveDirectory.Platform.dll"  
  
    If ((Test-Path -Path $adal) -and (Test-Path -Path $adalforms)) { 

    [System.Reflection.Assembly]::LoadFrom($adal)
    [System.Reflection.Assembly]::LoadFrom($adalforms)
     }
     else
     {
      Write-output "ADAL Assemblies files cannot be found. Please set the correct path for `$adal` and `$adalforms`, then run the script again." 
      exit    
     }  

    # Set well-known client ID for AzurePowerShell
    $clientId = "1950a258-227b-4e31-a9cf-717495945fc2" 
    # Set redirect URI for Azure PowerShell
    $redirectUri = "urn:ietf:wg:oauth:2.0:oob"
    # Set Resource URI to Azure Service Management API
    $resourceAppIdURI = "https://vault.azure.net"
    # Set Authority to Azure AD Tenant
    $authority = "https://login.windows.net/$adtenant"
    # Create Authentication Context tied to Azure AD Tenant
    $authContext = New-Object "Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContext" -ArgumentList $authority
    # Acquire token
    $platformParameters = New-Object "Microsoft.IdentityModel.Clients.ActiveDirectory.PlatformParameters" -ArgumentList "Auto"
    $authResult = $authContext.AcquireTokenAsync($resourceAppIdURI, $clientId, $redirectUri, $platformParameters).result
    # Generate auth header 
    $authHeader = $authResult.CreateAuthorizationHeader()
    # Set HTTP request headers to include Authorization header
    $headers = @{'x-ms-version'='2014-08-01';"Authorization" = $authHeader}

    ########################################################################################################################
    # 1. Retrieve wrapped BEK
    # 2. Make KeyVault REST API call to unwrap the BEK
    # 3. Convert the Base64Url string returned by KeyVault unwrap to Base64 string 
    # 4. Convert Base64 string to bytes and write to the BEK file
    ########################################################################################################################

    #Get wrapped BEK and place it in JSON object to send to KeyVault REST API
    $keyVaultSecret = Get-AzKeyVaultSecret -VaultName $keyVaultName -Name $secretName
    $bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($keyVaultSecret.SecretValue)
    $wrappedBekSecretBase64 = [Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
    $jsonObject = @"
    {
    "alg": "RSA-OAEP",
    "value" : "$wrappedBekSecretBase64"
    }
    "@

    #Get KEK Url
    $kekUrl = (Get-AzKeyVaultKey -VaultName $keyVaultName -Name $kekName).Key.Kid;
    $unwrapKeyRequestUrl = $kekUrl+ "/unwrapkey?api-version=2015-06-01";

    #Call KeyVault REST API to Unwrap 
    $result = Invoke-RestMethod -Method POST -Uri $unwrapKeyRequestUrl -Headers $headers -Body $jsonObject -ContentType "application/json" -Debug

    #Convert Base64Url string returned by KeyVault unwrap to Base64 string
    $base64UrlBek = $result.value;
    $base64Bek = $base64UrlBek.Replace('-', '+');
    $base64Bek = $base64Bek.Replace('_', '/');
    if($base64Bek.Length %4 -eq 2)
    {
        $base64Bek+= '==';
    }
    elseif($base64Bek.Length %4 -eq 3)
    {
        $base64Bek+= '=';
    }

    #Convert base64 string to bytes and write to BEK file
    $bekFileBytes = [System.Convert]::FromBase64String($base64Bek);
    [System.IO.File]::WriteAllBytes($bekFilePath,$bekFileBytes)

    #Delete the key from the memory
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
    clear-variable -name wrappedBekSecretBase64
    ```

3. Set the parameters. The script will process the KEK secret to create the BEK key, and then save it to a local folder on the recovery VM. If you receive errors when you run the script, see the [script troubleshooting](#script-troubleshooting) section.

4. You see the following output when the script begins:

    GAC    Version        Location
    ---    -------        --------
    False  v4.0.30319     C:\Program Files\WindowsPowerShell\Modules\Az.Accounts\...
    False  v4.0.30319     C:\Program Files\WindowsPowerShell\Modules\Az.Accounts\...

    When the script finishes, you see the following output:

    ```output
    VERBOSE: POST https://myvault.vault.azure.net/keys/rondomkey/<KEY-ID>/unwrapkey?api-
    version=2015-06-01 with -1-byte payload
    VERBOSE: received 360-byte response of content type application/json; charset=utf-8
    ```

5. To unlock the attached disk by using the BEK file, run the following command:

    ```powershell
    manage-bde -unlock F: -RecoveryKey "C:\BEK\EF7B2F5A-50C6-4637-9F13-7F599C12F85C.BEK
    ```

    In this sample, the attached OS disk is drive F. Make sure that you use the correct drive letter.

6. After the disk was successfully unlocked by using the BEK key, detach the disk from the recovery VM, and then use the **Swap OS disk** feature to replace the OS disk of the original VM with this repaired disk.

7. If the new VM still cannot boot normally, try one of following steps after you unlock the drive:

    - Suspend protection to temporarily turn BitLocker OFF by running the following command:

    ```console
    manage-bde -protectors -disable F: -rc 0
    ```

    - Fully decrypt the drive. To do this, run the following command:

    ```console
    manage-bde -off F:
    ```

## Script troubleshooting

**Error: Could not load file or assembly**

This error occurs because the paths of the ADAL Assemblies are wrong. You can search for `Az.Accounts` folder to find the correct path.

**Error: Get-AzKeyVaultSecret or Get-AzKeyVaultSecret is not recognized as the name of a cmdlet**

If you are using the old Az PowerShell module, you must change the two commands to `Get-AzureKeyVaultSecret` and `Get-AzureKeyVaultSecret`.

## KEK script parameters

| Parameters  | Example  |How to check   |
|---|---|---|
|  $keyVaultName | myKeyVault2707  | Run `Get-AzVM -ResourceGroupName $rgName -Name $vmName -DisplayHint Expand`and check **Settings** and **KeyEncryptionKeyURL** in the output. Here is an example:</br>"KeyEncryptionKeyURL":`https://myKeyVault2707.vault.azure.net/keys/mykey/000072b987145a3b79b0ed415f0000` |
|$kekName   |mykey   | Run `Get-AzVM -ResourceGroupName $rgName -Name $vmName -DisplayHint expand` and check **Settings** and **KeyEncryptionKeyURL** in the output.  Here is an example:</br>"KeyEncryptionKeyURL":`https://myKeyVault2707.vault.azure.net/keys/mykey/000072b987145a3b79b0ed415f0000`|
|$secretName   |7EB4F531-5FBA-4970-8E2D-C11FD6B0C69D  | The name of the secret of the VM key.</br> To find the correct secret name, check the step 6 in the [Decrypt the encrypted OS disk](#decrypt-the-encrypted-os-disk) section.|
|$bekFilePath   |c:\bek\7EB4F531-5FBA-4970-8E2D-C11FD6B0C69D.BEK |A local path where you want to save the BEK file. In the example, You need to create the "bek" folder before running the script or it will error out.|
|$adTenant  |contoso.onmicrosoft.com   | FQDN or GUID of your Microsoft Entra ID that hosts the key vault |

## Install Az PowerShell module

To install Az PowerShell module for the recovery VM, follow these steps:

1. Open a PowerShell session as administrator, and set the HTTP APIs security protocol to TLS 1.2 for current session. The security protocol will be reverted to the default value after you close the current session.

    ```powershell
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    ```

2. Download the latest version of the Nuget package:

    ```powershell
     Install-PackageProvider -Name "Nuget" -Force

    ```

3. Install the latest version of the PowerShellGet package, and then restart the PowerShell.

    ```powershell
    Install-Module -Name PowerShellGet -Force
    ```

4. Run the following command to install the latest version of the Azure Az module:

    ```powershell
    Install-Module -Name Az -Scope AllUsers -Repository PSGallery -Force
    ```

5. Install the Az.Account 1.9.4 package:

    ```powershell
    Install-Module -Name Az.Accounts -Scope AllUsers -RequiredVersion "1.9.4" -Repository PSGallery -Force
    ```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
