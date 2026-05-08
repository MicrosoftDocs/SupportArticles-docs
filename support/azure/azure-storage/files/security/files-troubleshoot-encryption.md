---
title: Troubleshoot Encryption Changes Affecting Azure Files
description: Prepare for upcoming changes in Windows Server Active Directory that might impact storage accounts that use Azure Files with Active Directory Domain Services (AD DS) authentication. The default encryption method for AD DS is changing from RC4 to AES-256.
ms.service: azure-file-storage
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
ms.date: 05/08/2026
ms.reviewer: kendownie, v-surmaini, v-weizhu
---
# Troubleshoot Azure Files AD DS authentication support for AES-256 Kerberos encryption

**Applies to:** :heavy_check_mark: SMB Azure file shares

## Summary

This article explains how an upcoming Windows update will change the default Kerberos encryption type in Active Directory Domain Services (AD DS) from RC4 to AES-256, and how to upgrade your storage account so you won't be impacted. Azure Files customers who have already upgraded their storage accounts to use AES-256 encryption won't be impacted.

## Supported encryption methods for Azure Files identity-based access

Azure Files uses Kerberos authentication for identity-based access over SMB. AES-256 Kerberos encryption has been supported since AzFilesHybrid module v0.2.2, and it's been the default encryption method since module v0.2.5. Historically, RC4 was the only supported encryption option until AES-256 support was added.

An upcoming Windows change (**July 2026 Windows Server Update**) will change the default Kerberos encryption type in AD DS from RC4 to AES-256. If you use identity-based authentication with Azure Files and your identity source is on-premises AD DS, you might experience mount errors when this change rolls out. We recommend taking action now and upgrading your storage accounts to use AES-256 encryption to ensure uninterrupted access to your Azure file shares.

Storage accounts configured with custom DNS suffixes or custom Kerberos service principal names (for example, `storageaccount.domain.com` instead of `<storageaccount>.file.core.windows.net`) might be impacted earlier, beginning with the **April 2026 Windows Update**. If you use custom SPNs, upgrade to AES-256 before applying the April update.

For more information about this Windows change, see [How to manage Kerberos KDC usage of RC4 for service account ticket issuance changes related to CVE-2026-20833](https://support.microsoft.com/topic/how-to-manage-kerberos-kdc-usage-of-rc4-for-service-account-ticket-issuance-changes-related-to-cve-2026-20833-1ebcda33-720a-4da8-93c1-b0496e1910dc).

### Step 1: Check if you're impacted

Run the following PowerShell command on a domain-joined machine to identify storage accounts that use Azure Files with AD DS authentication but haven't been upgraded to AES-256:

```PowerShell
Get-ADObject `
    -LDAPFilter "(&(servicePrincipalName=*.file.core.windows.net)(!(msDS-SupportedEncryptionTypes=*)))" -Properties servicePrincipalName, msDS-SupportedEncryptionTypes |
    Select-Object Name, ObjectClass, servicePrincipalName, msDS-SupportedEncryptionTypes
```

If no results are returned, your storage accounts already support AES-256, and you don't need to take any action. If any accounts are returned, upgrade those accounts to support AES-256.

> [!NOTE]
> If you're using storage accounts outside of the Azure public cloud, adjust `*.file.core.windows.net` in the LDAP filter to match the endpoint for your environment.

### Step 2: Ensure AES-256 is allowed by clients and by the storage account

Ensure that client machines don't have a value in the `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters\SupportedEncryptionTypes` registry key that would explicitly disallow AES-256 encryption. See [Mount to Azure Files fails when using Entra Kerberos due to unsupported Kerberos encryption types](files-troubleshoot-smb-authentication.md#mount-to-azure-files-fails-when-using-entra-kerberos-due-to-unsupported-kerberos-encryption-types) for more details.

Additionally, ensure that the [storage account's SMB security settings](/azure/storage/files/files-smb-protocol#smb-security-settings) don't disallow AES-256 Kerberos ticket encryption.

### Step 3: Upgrade your storage account to AES-256

There are two options to upgrade your storage account to AES-256. We strongly recommend [Option 1](#option-1-use-the-azfileshybrid-cmdlet-recommended) using the AzFilesHybrid PowerShell module, as it handles all the necessary steps automatically with a single command. [Option 2](#option-2-manual-steps) provides manual steps if you're unable to use the module.

#### Option 1: Use the AzFilesHybrid cmdlet (recommended)

[Download the latest AzFilesHybrid module](https://www.powershellgallery.com/packages/AzFilesHybrid/) and run the following PowerShell script.

```PowerShell
$ResourceGroupName = "<resource-group-name-here>"
$StorageAccountName = "<storage-account-name-here>"

Update-AzStorageAccountAuthForAES256 -ResourceGroupName $ResourceGroupName -StorageAccountName $StorageAccountName
```

As part of the update, the cmdlet rotates the Kerberos keys, which is necessary to switch to AES-256. You don't need to rotate back unless you want to regenerate both passwords.

#### Option 2: Manual steps

If you can't use the AzFilesHybrid module, you can manually upgrade to AES-256 by following these steps.

First, check the domain properties that are configured on the storage account:

```PowerShell
$ResourceGroupName = "<resource-group-name-here>"
$StorageAccountName = "<storage-account-name-here>"

$sa = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName
$sa.AzureFilesIdentityBasedAuth.ActiveDirectoryProperties | Select-Object DomainName, SamAccountName, AccountType
```

You should check that `DomainName`, `SamAccountName`, and `AccountType` all return values, and that they match the values of the AD account. You can check these values on the AD account with the following PowerShell cmdlet.

```PowerShell
$domainInformation = Get-ADDomain
$domainName = $domainInformation.DnsRoot
$samAccountName = $saAdObject.sAMAccountName.TrimEnd('$')
$type = if ($saAdObject.objectClass -contains "computer") { "Computer" } `
    elseif ($saAdObject.objectClass -contains "user") { "User" }

Write-Host "DomainName=$domainName, samAccountName=$samAccountName, type=$type"
```

> [!IMPORTANT]
> The properties described in this section are used to generate the salt for the AES-256 encryption key. If the values configured on the storage account don't match the values from AD DS, SMB authentication will fail after upgrading to AES-256.

To ensure all domain properties are correctly configured on the storage account, run the following script. It's safe to run even if the domain properties are already configured correctly on the storage account.

```PowerShell
$ResourceGroupName = "<resource-group-name-here>"
$StorageAccountName = "<storage-account-name-here>"

$domainInformation = Get-ADDomain
$domainGuid = $domainInformation.ObjectGUID.ToString()
$domainName = $domainInformation.DnsRoot
$domainSid = $domainInformation.DomainSID.Value
$forestName = $domainInformation.Forest
$netBiosDomainName = $domainInformation.DnsRoot

$saAdObject = Get-ADObject `
    -LDAPFilter "(servicePrincipalName=cifs/$StorageAccountName.file.core.windows.net)" `
    -Properties *

$saADObjectSid = $saAdObject.objectSid.Value
$samAccountName = $saAdObject.sAMAccountName.TrimEnd('$')
$type = if ($saAdObject.objectClass -contains "computer") { "Computer" } `
    elseif ($saAdObject.objectClass -contains "user") { "User" }

Set-AzStorageAccount `
    -ResourceGroupName $ResourceGroupName `
    -Name $StorageAccountName `
    -EnableActiveDirectoryDomainServicesForFile $true `
    -ActiveDirectoryDomainName $domainName `
    -ActiveDirectoryNetBiosDomainName $netBiosDomainName `
    -ActiveDirectoryForestName $forestName  `
    -ActiveDirectoryDomainGuid $domainGuid `
    -ActiveDirectoryDomainSid $domainSid `
    -ActiveDirectoryAzureStorageSid $saADObjectSid `
    -ActiveDirectorySamAccountName $samAccountName `
    -ActiveDirectoryAccountType $type
```

For more information, see [Enable AD DS authentication for Azure Files](/azure/storage/files/storage-files-identity-ad-ds-enable).

##### Enable AES-256 on the domain object

If you already ran the preceding domain properties script and have the `$saAdObject` variable in your session, you can skip the following query and set `$identity = $saAdObject.DistinguishedName` directly.

```PowerShell
$saAdObject = Get-ADObject `
    -LDAPFilter "(servicePrincipalName=cifs/$StorageAccountName.file.core.windows.net)" `
    -Properties *

$identity = $saAdObject.DistinguishedName
```

To determine your account type, check the `AccountType` value from the domain properties check, or run `$saAdObject.objectClass`. If the object class is `computer`, use `Set-ADComputer`. If it's `user`, use `Set-ADUser`.

To enable AES-256 encryption on a **computer account**, run the following command.

```PowerShell
Set-ADComputer -Identity $identity -KerberosEncryptionType "AES256"
```

To enable AES-256 encryption on a **service logon account**, run the following command instead.

```PowerShell
Set-ADUser -Identity $identity -KerberosEncryptionType "AES256"
```

##### Refresh the domain object password

After you run the preceding cmdlet, run the following script to refresh your domain object password. This step is critical to generating the appropriate authentication metadata on the service side.

```PowerShell
$KeyName = "kerb1" # Could be either the first or second kerberos key, this script assumes we're refreshing the first
$KerbKeys = New-AzStorageAccountKey -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -KeyName $KeyName
$KerbKey = $KerbKeys.keys | Where-Object {$_.KeyName -eq $KeyName} | Select-Object -ExpandProperty Value
$NewPassword = ConvertTo-SecureString -String $KerbKey -AsPlainText -Force

Set-ADAccountPassword -Identity $identity -Reset -NewPassword $NewPassword
```

### Step 4: Confirm the AES-256 upgrade

After completing either Option 1 or Option 2, purge cached Kerberos tickets on the client and verify the upgrade by remounting the file share.

1. Run `klist purge` from an elevated command prompt to clear any cached Kerberos tickets that still use RC4.
1. Remount the Azure file share.
1. Run `klist get cifs/<storage-account-name>.file.core.windows.net` to verify that the new Kerberos ticket uses AES-256 encryption.

The output should show `AES-256-CTS-HMAC-SHA1-96` for both the **KerbTicket Encryption Type** and **Session Key Type**, similar to the following:

```
#1>     Client: user @ DOMAIN.CONTOSO.COM
        Server: cifs/<storage-account-name>.file.core.windows.net @ DOMAIN.CONTOSO.COM
        KerbTicket Encryption Type: AES-256-CTS-HMAC-SHA1-96
        Ticket Flags 0x40a10000 -> forwardable renewable pre_authent name_canonicalize
        Start Time: 3/20/2026 23:16:32 (local)
        End Time:   3/21/2026 9:16:32 (local)
        Renew Time: 3/27/2026 23:16:32 (local)
        Session Key Type: AES-256-CTS-HMAC-SHA1-96
        Cache Flags: 0
        Kdc Called: <domain-controller-name>
```

## Reverting the AES-256 upgrade

If you encounter authentication problems after upgrading to AES-256, you can revert to RC4 using the following steps. While you should still upgrade to AES-256 before Windows Update changes the default encryption type in AD DS, these steps allow you to temporarily revert to RC4 while troubleshooting AES-256 issues.

1. Ensure client machines don't have the following registry key value. Check for the `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters\SupportedEncryptionTypes` registry key. It explicitly disallows RC4 encryption. For details, see [Mount to Azure Files fails when using Entra Kerberos due to unsupported Kerberos encryption types](files-troubleshoot-smb-authentication.md#mount-to-azure-files-fails-when-using-entra-kerberos-due-to-unsupported-kerberos-encryption-types).

2. Ensure the storage account's SMB security settings don't disallow RC4 Kerberos ticket encryption. For more information, see [storage account's SMB security settings](/azure/storage/files/files-smb-protocol#smb-security-settings).

3. Get the distinguished name of the AD object representing the storage account. Use the following PowerShell command.

```PowerShell
$StorageAccountName = "<storage-account-name-here>"

$saAdObject = Get-ADObject `
    -LDAPFilter "(servicePrincipalName=cifs/$StorageAccountName.file.core.windows.net)" `
    -Properties *

$identity = $saAdObject.DistinguishedName

```

**If the AD object is a computer account**, run the following command to clear the **msDS-SupportedEncryptionTypes** property.

```PowerShell
Set-ADComputer -Identity $identity -Clear msDS-SupportedEncryptionTypes

```

**If the AD object is a service logon account**, run the following command instead.

```PowerShell
Set-ADUser -Identity $identity -Clear msDS-SupportedEncryptionTypes

```

4. Run `klist purge` from an elevated command prompt on affected client machines. Clear any cached Kerberos tickets that still use AES-256. After the next mount, **klist** should show a storage account with **KerbTicket Encryption Type** of RC4-HMAC. Use the following command to verify the Kerberos ticket encryption type:

```
#1>     Client: user @ DOMAIN.CONTOSO.COM
        Server: cifs/<storage-account-name>.file.core.windows.net @ DOMAIN.CONTOSO.COM
        KerbTicket Encryption Type: RSADSI RC4-HMAC(NT)
        Ticket Flags 0x40a10000 -> forwardable renewable pre_authent name_canonicalize
        Start Time: 3/20/2026 23:16:32 (local)
        End Time:   3/21/2026 9:16:32 (local)
        Renew Time: 3/27/2026 23:16:32 (local)
        Session Key Type: AES-256-CTS-HMAC-SHA1-96
        Cache Flags: 0
        Kdc Called: <domain-controller-name>
```

## See also

- [Windows Kerberos Information Disclosure Vulnerability](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2026-20833)
- [How to manage Kerberos KDC usage of RC4 for service account ticket issuance changes related to CVE-2026-20833](https://support.microsoft.com/topic/how-to-manage-kerberos-kdc-usage-of-rc4-for-service-account-ticket-issuance-changes-related-to-cve-2026-20833-1ebcda33-720a-4da8-93c1-b0496e1910dc).
- [Enable AD DS authentication for Azure Files](/azure/storage/files/storage-files-identity-ad-ds-enable)