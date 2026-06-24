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

> [!NOTE]
> This article applies only to Azure Files storage accounts that use **on-premises Active Directory Domain Services (AD DS)** for SMB identity-based authentication. **No action is required** if your storage account uses Microsoft Entra Kerberos, Microsoft Entra Domain Services, or storage account key access only. To verify, run the Azure Resource Graph query in [Step 1a](#step-1a-find-ad-joined-storage-accounts-and-their-domains-azure-resource-graph). If the query returns no results in your subscriptions, you aren't affected by this change.
>
> **FSLogix and Azure Virtual Desktop:** If you use FSLogix with Azure Files storage with **AD DS** authentication, those storage accounts **are in scope** for this article. Azure Virtual Desktop deployments that use Microsoft Entra Kerberos for FSLogix aren't affected.

## Supported encryption methods for Azure Files identity-based access

Azure Files uses Kerberos authentication for identity-based access over SMB. AES-256 Kerberos encryption has been supported since AzFilesHybrid module v0.2.2, and it's been the default encryption method since module v0.2.5. Historically, RC4 was the only supported encryption option until AES-256 support was added.

An upcoming Windows change (**July 2026 Windows Server Update**) will change the default Kerberos encryption type in AD DS from RC4 to AES-256. If you use identity-based authentication with Azure Files and your identity source is on-premises AD DS, you might experience mount errors when this change rolls out. We recommend taking action now and upgrading your storage accounts to use AES-256 encryption to ensure uninterrupted access to your Azure file shares.

Storage accounts configured with custom DNS suffixes or custom Kerberos service principal names (for example, `storageaccount.domain.com` instead of `<storageaccount>.file.core.windows.net`) might be impacted earlier, beginning with the **April 2026 Windows Update**. If you use custom SPNs, upgrade to AES-256 before applying the April update.

For more information about this Windows change, see [How to manage Kerberos KDC usage of RC4 for service account ticket issuance changes related to CVE-2026-20833](https://support.microsoft.com/topic/how-to-manage-kerberos-kdc-usage-of-rc4-for-service-account-ticket-issuance-changes-related-to-cve-2026-20833-1ebcda33-720a-4da8-93c1-b0496e1910dc).

### Step 1: Check if you're impacted

Checking impact is a two-part process:

1. From the Azure side, find every storage account that uses AD DS authentication and discover which AD domains those accounts are joined to.
2. For each of those domains, run an LDAP query against AD DS to find storage account objects that haven't been upgraded to AES-256.

#### Step 1a: Find AD-joined storage accounts and their domains (Azure Resource Graph)

If you have many subscriptions or you're not sure which AD domains your storage accounts are joined to, run the following query in [Azure Resource Graph Explorer](/azure/governance/resource-graph/first-query-portal). It enumerates every storage account across the tenant that uses AD DS authentication and returns the domain, forest, sAMAccountName, and account type for each:

```kusto
resources
| where type =~ 'microsoft.storage/storageaccounts'
| where properties.azureFilesIdentityBasedAuthentication.directoryServiceOptions == 'AD'
| project subscriptionId, resourceGroup, name,
          domainName = properties.azureFilesIdentityBasedAuthentication.activeDirectoryProperties.domainName,
          forestName = properties.azureFilesIdentityBasedAuthentication.activeDirectoryProperties.forestName,
          samAccountName = properties.azureFilesIdentityBasedAuthentication.activeDirectoryProperties.samAccountName,
          accountType = properties.azureFilesIdentityBasedAuthentication.activeDirectoryProperties.accountType
| order by subscriptionId, name
```

If this query returns no results, no storage accounts in the queried subscriptions use AD DS authentication and you don't need to take any action. Otherwise, take note of the unique `domainName` values returned. You'll use them in the next step.

> [!IMPORTANT]
> The accounts returned by this query aren't necessarily impacted. This query lists every AD DS-joined storage account, regardless of whether it has already been upgraded to AES-256. Azure has no visibility into the AD object's `msDS-SupportedEncryptionTypes` attribute, so this list is the *candidate set*. [Step 1b](#step-1b-identify-storage-accounts-that-havent-been-upgraded-to-aes-256-ad-ds) confirms which of these accounts are still on RC4 and need to be upgraded.

> [!NOTE]
> Resource Graph only returns subscriptions you currently have access to. If your tenant spans multiple management groups or partner-managed subscriptions, run this query in each scope to get full coverage.

#### Step 1b: Identify storage accounts that haven't been upgraded to AES-256 (AD DS)

For each unique domain returned by Step 1a, run the following PowerShell command on a machine joined to that domain to identify storage account objects that are still using RC4 (that is, the `msDS-SupportedEncryptionTypes` attribute isn't set):

```PowerShell
Get-ADObject `
    -LDAPFilter "(&(servicePrincipalName=*.file.core.windows.net)(!(msDS-SupportedEncryptionTypes=*)))" -Properties servicePrincipalName, msDS-SupportedEncryptionTypes |
    Select-Object Name, ObjectClass, servicePrincipalName, msDS-SupportedEncryptionTypes
```

If no results are returned, the storage accounts in that domain already support AES-256, and you don't need to take any action for that domain. If any accounts are returned, upgrade those accounts to support AES-256.

> [!NOTE]
> If you're using storage accounts outside of the Azure public cloud, adjust `*.file.core.windows.net` in the LDAP filter to match the endpoint for your environment.

#### Step 1c (optional): Identify which clients are still requesting RC4 tickets

Steps 1a and 1b tell you *which storage accounts* still need to be upgraded. They do **not** tell you *which client machines* are currently mounting those shares with RC4 tickets. This step is **optional** and is intended for customers who want extra confidence before upgrading, for example, to identify legacy clients that might need patching, or to estimate blast radius for a change-management ticket.

On a domain controller, filter the Security event log for Kerberos service ticket events ([Event ID 4769](/windows/security/threat-protection/auditing/event-4769)) where the **Service Name** is the storage account's SPN (`cifs/<storage-account-name>.file.core.windows.net`) and the **Ticket Encryption Type** is `0x17` (RC4-HMAC). The **Client Address** field identifies the requesting client.

> [!NOTE]
> Skipping this step is safe. The upgrade itself is non-disruptive (see [Step 3](#step-3-upgrade-your-storage-account-to-aes-256)). Clients with cached RC4 tickets transparently get an AES-256 ticket on the next renewal. This step is purely diagnostic.

### Step 2: Ensure AES-256 is allowed by clients and by the storage account

Before upgrading the storage account in Step 3, confirm AES-256 is permitted at three layers: the **client operating system**, the **client Kerberos policy**, and the **storage account's SMB security settings**. If AES-256 is blocked at any layer, mounts will fail after the upgrade.

#### Step 2a: Verify client OS supports AES-256

Ensure your clients are running an OS version that supports AES-256 Kerberos ticket encryption. All actively supported OS versions today have support for AES-256 Kerberos ticket encryption. Windows versions older than Vista, MacOS versions older than OS X Lion 10.7, and Linux distributions running krb5 1.3.2 or older don't support AES-256 ticket encryption. If you have questions about client versions, reach out to the [Azure Files authentication team](mailto:filesadauth@microsoft.com).

#### Step 2b: Verify Windows client Kerberos policy allows AES-256

For Windows clients, ensure that client machines don't have a value in the `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters\SupportedEncryptionTypes` registry key that would explicitly disallow AES-256 encryption. See [Mount to Azure Files fails when using Entra Kerberos due to unsupported Kerberos encryption types](files-troubleshoot-smb-authentication.md#mount-to-azure-files-fails-when-using-entra-kerberos-due-to-unsupported-kerberos-encryption-types) for more details.

To verify the client policy on a Windows machine, run the following PowerShell command in an elevated session:

```PowerShell
$path = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters'
$v = (Get-ItemProperty -Path $path -Name SupportedEncryptionTypes -ErrorAction SilentlyContinue).SupportedEncryptionTypes
if ($null -eq $v) {
    'OK: SupportedEncryptionTypes is not set. Windows uses its defaults (AES allowed).'
} elseif ($v -band 0x10) {
    "OK: SupportedEncryptionTypes = 0x{0:X} includes AES-256 (0x10)." -f $v
} else {
    "PROBLEM: SupportedEncryptionTypes = 0x{0:X} does NOT include AES-256 (0x10). AES-256 is disallowed on this client." -f $v
}
```

`SupportedEncryptionTypes` is a bitmask. AES-256 is bit `0x10` (decimal 16). If the registry value exists and bit `0x10` isn't set, AES-256 is explicitly disallowed and the client won't be able to mount the file share once the storage account is upgraded.

| Bit | Encryption type |
|---|---|
| `0x1` | DES_CBC_CRC |
| `0x2` | DES_CBC_MD5 |
| `0x4` | RC4_HMAC_MD5 |
| `0x8` | AES128_CTS_HMAC_SHA1_96 |
| `0x10` | **AES256_CTS_HMAC_SHA1_96** |
| `0x20` | AES256_CTS_HMAC_SHA1_96_SK |
| `0x80000000` | Use Windows default values |

For example, `0x18` (24) allows AES-128 and AES-256 and is a safe value. `0x4` (4) allows only RC4 and is **not** safe. `0x1C` (28) allows RC4, AES-128, and AES-256 and is a valid transitional value. If the value is set by Group Policy, update the policy at **Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > Security Options > Network security: Configure encryption types allowed for Kerberos**.

#### Step 2c: Verify the storage account's SMB security settings allow AES-256

Ensure that the [storage account's SMB security settings](/azure/storage/files/files-smb-protocol#smb-security-settings) don't disallow AES-256 Kerberos ticket encryption.

> [!IMPORTANT]
> The storage account's **SMB security settings** control which Kerberos ticket encryption types the storage account will *accept* on the wire. They do **not** indicate whether the storage account has actually been upgraded to AES-256. In particular, the SMB security settings do **not** reflect:
>
> - whether the associated Active Directory object has `msDS-SupportedEncryptionTypes` set to allow AES-256, or
> - whether the storage account has the matching Kerberos keys (kerb1/kerb2) needed to issue AES-256 tickets.
>
> Confirming that AES-256 is *allowed* in SMB security settings is necessary, but it is **not** sufficient on its own. You must still complete [Step 3: Upgrade your storage account to AES-256](#step-3-upgrade-your-storage-account-to-aes-256) (which uses `Update-AzStorageAccountAuthForAES256` to update both the AD object and the storage account's Kerberos keys in a single operation). Skipping Step 3 will result in mount failures once the July 2026 Windows Server Update changes the default Kerberos encryption type from RC4 to AES-256.

### Step 3: Upgrade your storage account to AES-256

**What to expect during the upgrade.** The upgrade is non-disruptive for most workloads. In-flight SMB sessions remain connected via existing tickets. New mounts after the upgrade negotiate AES-256. There is no data loss and no Azure Files service downtime. End users with cached RC4 tickets transparently get an AES-256 ticket on the next ticket renewal (typically within 10 hours), or immediately after running `klist purge`.

There are two options to upgrade your storage account to AES-256. We strongly recommend [Option 1](#option-1-use-the-azfileshybrid-cmdlet-recommended) using the AzFilesHybrid PowerShell module, as it handles all the necessary steps automatically with a single command. [Option 2](#option-2-manual-steps) provides manual steps if you're unable to use the module.

#### Option 1: Use the AzFilesHybrid cmdlet (recommended)

**Pre-flight checklist.** Before you run the cmdlet, confirm all of the following. Most Option 1 failures trace back to one of these prerequisites being missing:

- **Azure RBAC:** The executing user (or service principal) has the **Storage Account Contributor** role (or higher) on the target storage account.
- **Active Directory permissions:** The executing user has either **Domain Admins** membership, or an explicit delegation on the OU containing the storage account's AD object granting **Reset Password** and **Write `msDS-SupportedEncryptionTypes`** rights.
- **Machine context:** The cmdlet runs from a machine that is **domain-joined to the same AD DS forest** as the storage account, with unimpeded network connectivity to a domain controller (LDAP/Kerberos ports open).
- **PowerShell modules:** Current version of [AzFilesHybrid](https://www.powershellgallery.com/packages/AzFilesHybrid/) is installed and imported.
- **Authenticated session:** You're signed in to the correct subscription (`Connect-AzAccount` followed by `Set-AzContext -Subscription <subscriptionId>`).

Once the prerequisites are in place, run the following cmdlet from an elevated PowerShell session:

```PowerShell
$ResourceGroupName = "<resource-group-name-here>"
$StorageAccountName = "<storage-account-name-here>"

Update-AzStorageAccountAuthForAES256 -ResourceGroupName $ResourceGroupName -StorageAccountName $StorageAccountName
```

**What the cmdlet does:** `Update-AzStorageAccountAuthForAES256` performs three coordinated steps in a single operation. Knowing what's happening helps you reason about RBAC requirements (Storage Account Contributor on the SA + AD modify rights on the OU) and explain the change to AD/security teams who might need to review it:

1. **Rotates one of the storage account's Kerberos keys** (`kerb1` by default). Calling `New-AzStorageAccountKey -KeyName kerb1` generates a new password for the AD object that backs the storage account. This is an Azure-side operation against the storage account's resource provider.
2. **Sets `msDS-SupportedEncryptionTypes` on the AD object** to enable AES-256. This is an AD-side write against the computer or user object representing the storage account, which is why the executing identity needs **Write `msDS-SupportedEncryptionTypes`** on the OU.
3. **Resets the AD object's password to the rotated kerb key.** This synchronizes the AD-side password with the new key so the storage account can issue AES-256 tickets that domain controllers will validate. This is why the executing identity needs **Reset Password** on the OU.

> [!NOTE]
> If the cmdlet fails with **"Insufficient access rights to perform the operation"**, the executing user has the required Azure RBAC roles but lacks Active Directory permissions on the OU containing the storage account's AD object. The cmdlet must update the AD object's `msDS-SupportedEncryptionTypes` attribute and reset its password, which typically requires either membership in **Domain Admins**, or an explicit delegation on the OU granting **Reset Password** and **Write `msDS-SupportedEncryptionTypes`** rights on the storage account's AD object. To confirm, run the following to find the OU and inspect its ACL:
>
> ```PowerShell
> $sa = Get-AzStorageAccountADObject -StorageAccountName "<storage-account-name>" -ResourceGroupName "<resource-group-name>"
> $ou = ($sa.DistinguishedName -split ',', 2)[1]
> Get-Acl -Path "AD:$ou" | Format-List
> ```
>
> Re-run the cmdlet as an identity that has both the required Azure RBAC roles and AD modify permissions on that OU. If no single identity has both, use [Option 2: Manual steps](#option-2-manual-steps) instead, which lets an AD administrator and an Azure administrator each run the parts they're authorized for.

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

> [!IMPORTANT]
> If the domain object representing the storage account is a **service logon (user) account** (`AccountType` = `User`), make sure the user principal name (UPN) is set to match the SPN **before** you refresh the domain object password. Storage accounts enabled with the manual AD DS steps before 2023 (or where the UPN step was skipped) often have the SPN set but **not** the UPN. Once AES-256 is enabled, the UPN must align with the `cifs/<storage-account-name>.file.core.windows.net` SPN, and a missing or mismatched UPN causes SMB authentication to fail with **error 1396 "The target account name is incorrect"** and **`KRB_AP_ERR_MODIFIED`**. This step doesn't apply to computer accounts.
>
> Run the following command, replacing `<domain-name>` and `<domain-dns-root>` with values for your environment:
>
> ```PowerShell
> Set-ADUser `
>     -Identity $identity `
>     -Server <domain-name> `
>     -UserPrincipalName cifs/$StorageAccountName.file.core.windows.net@<domain-dns-root>
> ```

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

To confirm the upgrade across an entire domain (rather than one client at a time), re-run the [Step 1b](#step-1b-identify-storage-accounts-that-havent-been-upgraded-to-aes-256-ad-ds) LDAP query. Any storage accounts you upgraded should no longer appear in the results. Once `msDS-SupportedEncryptionTypes` is set on the AD object, the filter excludes it.

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
