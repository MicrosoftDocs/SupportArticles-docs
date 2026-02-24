---
title: Troubleshoot Azure Files identity-based authentication and authorization issues (SMB)
description: Troubleshoot problems using identity-based authentication to connect to SMB Azure file shares and see possible resolutions.
ms.service: azure-file-storage
ms.custom: sap:Security, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
ms.date: 02/05/2026
ms.reviewer: kendownie, v-surmaini, v-weizhu
---
# Troubleshoot Azure Files identity-based authentication and authorization issues (SMB)

This article lists common problems when using SMB Azure file shares with identity-based authentication. It also provides possible causes and resolutions for these problems. Identity-based authentication isn't currently supported for NFS Azure file shares.

## Applies to

| File share type | SMB | NFS |
|-|:-:|:-:|
| Standard file shares (GPv2), LRS/ZRS | :::image type="icon" source="media/files-troubleshoot-smb-authentication/yes-icon.png" border="false":::  | :::image type="icon" source="media/files-troubleshoot-smb-authentication/no-icon.png" border="false"::: |
| Standard file shares (GPv2), GRS/GZRS | :::image type="icon" source="media/files-troubleshoot-smb-authentication/yes-icon.png" border="false":::  | :::image type="icon" source="media/files-troubleshoot-smb-authentication/no-icon.png" border="false"::: |
| Premium file shares (FileStorage), LRS/ZRS | :::image type="icon" source="media/files-troubleshoot-smb-authentication/yes-icon.png" border="false":::  | :::image type="icon" source="media/files-troubleshoot-smb-authentication/no-icon.png" border="false"::: |

## Error when running the AzFilesHybrid module

When you try to run the AzFilesHybrid module, you might receive the following error:

> A required privilege is not held by the client.

### Cause: AD permissions are insufficient

This issue occurs because you don't have the required Active Directory (AD) permissions to run the module.

### Solution

Refer to the AD privileges or contact your AD admin to provide the required privileges.

## Error 5 when mounting an Azure file share

When you try to mount a file share, you might receive the following error:

> System error 5 has occurred. Access is denied.

### Cause: Share-level permissions are incorrect

If end users are accessing the Azure file share using identity-based authentication, access to the file share fails with "Access is denied" error if share-level permissions are incorrect. 

> [!NOTE]
> This error might be caused by issues other than incorrect share-level permissions. For information on other possible causes and solutions, see [Troubleshoot Azure Files connectivity and access issues](../connectivity/files-troubleshoot-smb-connectivity.md#error5).

### Solution

Validate that permissions are configured correctly. See [Assign share-level permissions](/azure/storage/files/storage-files-identity-assign-share-level-permissions).

<a name='error-aaddstenantnotfound-in-enabling-azure-ad-ds-authentication-for-azure-files-unable-to-locate-active-tenants-with-tenant-id-aad-tenant-id'></a>

## Error AadDsTenantNotFound in enabling Microsoft Entra Domain Services authentication for Azure Files "Unable to locate active tenants with tenant ID Microsoft Entra tenant-id"

### Cause

Error AadDsTenantNotFound happens when you try to [enable Microsoft Entra Domain Services authentication for Azure Files](/azure/storage/files/storage-files-identity-auth-active-directory-domain-service-enable) on a storage account where Microsoft Entra Domain Services isn't created on the Microsoft Entra tenant of the associated subscription.  

### Solution

Enable Microsoft Entra Domain Services on the Microsoft Entra tenant of the subscription that your storage account is deployed to. You need administrator privileges of the Microsoft Entra tenant to create a managed domain. If you aren't the administrator of the Microsoft Entra tenant, contact the administrator and follow the step-by-step guidance to [create and configure a Microsoft Entra Domain Services managed domain](/azure/active-directory-domain-services/tutorial-create-instance).


## Error: All newly added URIs must contain a tenant verified domain, tenant ID, or app ID

### Cause

This error occurs during configuration of identity-based authentication for Azure Files when adding a redirect URI or identifier URI that doesn't meet Microsoft Entra ID application security requirements.

Microsoft Entra ID enforces restrictions on application identifier URIs and redirect URIs. Newly added URIs must reference one of the following:
- A tenant-verified custom domain
- The Microsoft Entra tenant ID
- The application (client) ID

If a URI uses an unverified domain, a `.local` hostname, or an arbitrary URL that is not associated with the tenant, the request is blocked by default tenant policy.

This behavior is enforced by Microsoft Entra ID and is not specific to the Azure Files service.

For more information, see:
[Restrictions on identifier URIs of Microsoft Entra applications](/entra/identity-platform/identifier-uri-restrictions)
[Redirect URI (reply URL) outline and restrictions](/entra/identity-platform/reply-url)
[Managing custom domain names in your Microsoft Entra ID](/entra/identity/users/domains-manage)

### Solution
When configuring application registration or identity-based authentication for Azure Files, ensure that any redirect URI or identifier URI uses one of the supported formats:
- Use a tenant-verified custom domain
- Use the Microsoft Entra tenant ID
- Use the application (client) ID

Do not use unverified domains, `.local` hostnames, or arbitrary URLs, as these will be rejected by Microsoft Entra ID tenant policy.
If you are unsure which domains are verified in your tenant, review the Custom domain names section in the Microsoft Entra admin center or contact your tenant administrator.

  
## Unable to mount Azure file shares with AD credentials

### Self diagnostics steps

First, make sure that you've followed the steps to [enable Azure Files AD DS Authentication](/azure/storage/files/storage-files-identity-ad-ds-overview).

Second, try [mounting Azure file share with storage account key](/azure/storage/files/storage-how-to-use-files-windows). If the share fails to mount, download [AzFileDiagnostics](https://github.com/Azure-Samples/azure-files-samples/tree/master/AzFileDiagnostics/Windows) to help you validate the client running environment. AzFileDiagnostics can detect incompatible client configurations that might cause access failure for Azure Files, give prescriptive guidance on self-fix, and collect the diagnostics traces.

Third, you can run the `Debug-AzStorageAccountAuth` cmdlet to conduct a set of basic checks on your AD configuration with the logged-on AD user. This cmdlet is supported on [AzFilesHybrid v0.1.2+](https://github.com/Azure-Samples/azure-files-samples/tree/master/AzFilesHybrid).

1. Sign in to Azure PowerShell interactively as an AD user that has owner permission on the target storage account:

    ```azurepowershell-interactive
    Connect-AzAccount
    ```

2. Run the `Debug-AzStorageAccountAuth` cmdlet:

    ```azurepowershell-interactive
    $ResourceGroupName = "<resource-group-name-here>"
    $StorageAccountName = "<storage-account-name-here>"

    Debug-AzStorageAccountAuth `
        -StorageAccountName $StorageAccountName `
        -ResourceGroupName $ResourceGroupName `
        -Verbose
    ```

The cmdlet performs these checks in sequence and provides guidance for failures:

1. `CheckADObjectPasswordIsCorrect`: Ensure that the password configured on the AD identity that represents the storage account is matching that of the storage account kerb1 or kerb2 key. If the password is incorrect, you can run [Update-AzStorageAccountADObjectPassword](/azure/storage/files/storage-files-identity-ad-ds-update-password) to reset the password.
2. `CheckADObject`: Confirm that there is an object in the Active Directory that represents the storage account and has the correct SPN (service principal name). If the SPN isn't correctly set up, run the `Set-AD` cmdlet returned in the debug cmdlet to configure the SPN.
3. `CheckDomainJoined`: Validate that the client machine is domain joined to AD. If your machine isn't domain joined to AD, refer to [Join a Computer to a Domain](/windows-server/identity/ad-fs/deployment/join-a-computer-to-a-domain) for domain join instructions.
4. `CheckPort445Connectivity`: Check if port 445 is opened for SMB connection. If port 445 isn't open, refer to the troubleshooting tool [AzFileDiagnostics](https://github.com/Azure-Samples/azure-files-samples/tree/master/AzFileDiagnostics/Windows) for connectivity issues with Azure Files.
5. `CheckSidHasAadUser`: Check if the logged on AD user is synced to Microsoft Entra ID. If you want to look up whether a specific AD user is synchronized to Microsoft Entra ID, you can specify the `-UserName` and `-Domain` in the input parameters. For a given SID, it checks if there is a Microsoft Entra user associated.
6. `CheckAadUserHasSid`: Check if the logged on AD user is synced to Microsoft Entra ID. If you want to look up whether a specific AD user is synchronized to Microsoft Entra ID, you can specify the `-UserName` and `-Domain` in the input parameters. For a given Microsoft Entra user, it checks its SID. To run this check, you must provide the `-ObjectId` parameter, along with the object ID of the Microsoft Entra user.
7. `CheckGetKerberosTicket`: Attempt to get a Kerberos ticket to connect to the storage account. If there isn't a valid Kerberos token, run the `klist get cifs/storage-account-name.file.core.windows.net` cmdlet and examine the error code to determine the cause of the ticket retrieval failure.
8. `CheckStorageAccountDomainJoined`: Check if the AD authentication is enabled and the account's AD properties are populated. If not, [enable AD DS authentication on Azure Files](/azure/storage/files/storage-files-identity-ad-ds-enable).
9. `CheckUserRbacAssignment`: Check if the AD identity has the proper RBAC role assignment to provide share-level permissions to access Azure Files. If not, [configure the share-level permission](/azure/storage/files/storage-files-identity-assign-share-level-permissions). (Supported on AzFilesHybrid v0.2.3+)
10. `CheckUserFileAccess`: Check if the AD identity has the proper directory/file permission (Windows ACLs) to access Azure Files. If not, [configure the directory/file level permission](/azure/storage/files/storage-files-identity-configure-file-level-permissions). To run this check, you must provide the `-FilePath` parameter, along with the path of the mounted file that you want to debug the access to. (Supported on AzFilesHybrid v0.2.3+)
11. `CheckKerberosTicketEncryption`: Check if the storage account is configured to accept the encryption type used by the Kerberos ticket. (Supported on AzFilesHybrid v0.2.5+)
12. `CheckChannelEncryption`: Check if the storage account is configured to accept the SMB channel encryption type used by the client. (Supported on AzFilesHybrid v0.2.5+)
13. `CheckDomainLineOfSight`: Check if the client has unimpeded network connectivity to the domain controller. (Supported on AzFilesHybrid v0.2.5+)
14. `CheckDefaultSharePermission`:  Check if the [default share-level permission](/azure/storage/files/storage-files-identity-assign-share-level-permissions#share-level-permissions-for-all-authenticated-identities) is configured. (Supported on AzFilesHybrid v0.2.5+)
15. `CheckAadKerberosRegistryKeyIsOff`: Check if the Microsoft Entra Kerberos registry key is off. If the key is on, run `reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters /v CloudKerberosTicketRetrievalEnabled /t REG_DWORD /d 0` from an elevated command prompt to turn it off, and then reboot your machine. (Supported on AzFilesHybrid v0.2.9+)

If you just want to run a subselection of the previous checks, you can use the `-Filter` parameter, along with a comma-separated list of checks to run. For example, to run all checks related to share-level permissions (RBAC), use the following PowerShell cmdlets:

```PowerShell
$ResourceGroupName = "<resource-group-name-here>"
$StorageAccountName = "<storage-account-name-here>"

Debug-AzStorageAccountAuth `
    -Filter CheckSidHasAadUser,CheckUserRbacAssignment `
    -StorageAccountName $StorageAccountName `
    -ResourceGroupName $ResourceGroupName `
    -Verbose
```

If you have the file share mounted on `X:`, and if you only want to run the check related to file-level permissions (Windows ACLs), you can run the following PowerShell cmdlets:

```PowerShell
$ResourceGroupName = "<resource-group-name-here>"
$StorageAccountName = "<storage-account-name-here>"
$FilePath = "X:\example.txt"

Debug-AzStorageAccountAuth `
    -Filter CheckUserFileAccess `
    -StorageAccountName $StorageAccountName `
    -ResourceGroupName $ResourceGroupName `
    -FilePath $FilePath `
    -Verbose
```

## Unable to mount Azure file shares with Microsoft Entra Kerberos

### Self diagnostics steps

First, make sure that you've followed the steps to [enable Microsoft Entra Kerberos authentication](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable).

Second, you can run the `Debug-AzStorageAccountAuth` cmdlet to perform a set of basic checks. This cmdlet is supported for storage accounts configured for Microsoft Entra Kerberos authentication, on [AzFilesHybrid v0.3.0+](https://github.com/Azure-Samples/azure-files-samples/tree/master/AzFilesHybrid).

1. Sign in to Azure PowerShell interactively as an AD user that has owner permission on the target storage account:

    ```azurepowershell-interactive
    Connect-AzAccount
    ```

2. Run the `Debug-AzStorageAccountAuth` cmdlet:

    ```azurepowershell-interactive
    $ResourceGroupName = "<resource-group-name-here>"
    $StorageAccountName = "<storage-account-name-here>"

    Debug-AzStorageAccountAuth -StorageAccountName $StorageAccountName -ResourceGroupName $ResourceGroupName -Verbose
    ```

The cmdlet performs these checks in sequence and provides guidance for failures:

1. `CheckPort445Connectivity`: Check if port 445 is opened for SMB connection. If port 445 isn't open, use the troubleshooting tool [AzFileDiagnostics](https://github.com/Azure-Samples/azure-files-samples/tree/master/AzFileDiagnostics/Windows) for connectivity issues with Azure Files.
1. `CheckAADConnectivity`: Check for Entra connectivity. SMB mounts with Kerberos authentication can fail if the client can't reach out to Entra. If this check fails, it indicates that there is a networking error (perhaps a firewall or VPN issue).
1. `CheckEntraObject`: Confirm that there is an object in the Entra that represents the storage account and has the correct service principal name (SPN). If the SPN isn't correctly set up, disable and re-enable Entra Kerberos authentication on the storage account.
1. `CheckRegKey`: Check if the `CloudKerberosTicketRetrieval` registry key is enabled. This registry key is required for Entra Kerberos authentication.
1. `CheckRealmMap`: Check if the user has [configured any realm mappings](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable#configure-coexistence-with-storage-accounts-using-on-premises-ad-ds) that would join the account to another Kerberos realm than `KERBEROS.MICROSOFTONLINE.COM`.
1. `CheckAdminConsent`: Check if the Entra service principal has been [granted admin consent](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable#grant-admin-consent-to-the-new-service-principal) for the Microsoft Graph permissions that are required to get a Kerberos ticket.
1. `CheckWinHttpAutoProxySvc`: Checks for the WinHTTP Web Proxy Auto-Discovery Service (WinHttpAutoProxySvc) that's required for Microsoft Entra Kerberos authentication. Its state should be set to `Running`. For security reasons, you may optionally [disable Web Proxy Auto-Discovery (WPAD)](../../../../windows-server/networking/disable-http-proxy-auth-features.md#how-to-disable-wpad) via registry keys. However, you shouldn't disable the the entire `WinHttpAutoProxySvc` service, as it is responsible for a host of other functionalities, including Kerberos Key Distribution Center Proxy (KDC Proxy) requests.
1. `CheckIpHlpScv`: Check for the IP Helper service (iphlpsvc) that's required for Microsoft Entra Kerberos authentication. Its state should be set to `Running`.
1. `CheckFiddlerProxy`: Check if a Fiddler proxy that prevents Microsoft Entra Kerberos authentication exists.
1. `CheckEntraJoinType`: Check if the machine is Entra domain joined or hybrid Entra domain Joined. It is a prerequisite for Microsoft Entra Kerberos authentication.

If you just want to run a subselection of the previous checks, you can use the `-Filter` parameter, along with a comma-separated list of checks to run.

## Mount to Azure Files fails when using Entra Kerberos due to unsupported Kerberos encryption types

When mounting an Azure file share using Entra Kerberos authentication, the mount operation fails. Log collection might show that the Kerberos service ticket can't be decrypted.
You might also find that the following registry key is configured: `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters\SupportedEncryptionTypes`

### Cause

If the `SupportedEncryptionTypes` registry key is configured with a value that does **not include AES**, Windows will only allow the encryption types specified in the bitmask. For example, the value `0x7` indicates that the client supports only the following Kerberos encryption types:

- DES_CBC_CRC  
- DES_CBC_MD5  
- RC4_HMAC  

Because Entra Kerberos always encrypts service tickets with **AES-256 (AES256-CTS-HMAC-SHA1-96)**, mounts will fail if AES isn't included in the supported encryption types for the account or machine.

> [!NOTE]  
> AES encryption is enabled by default on modern Windows operating systems. If the `SupportedEncryptionTypes` registry key isn't configured, Windows will automatically negotiate AES when available.

### Solution

To successfully mount Azure file shares using Entra Kerberos, AES-256 must be included in the supported encryption types.

Use one of the following options:

#### Option 1: Remove the registry key (recommended if not intentionally configured)

If the encryption types weren't deliberately restricted:

1. Delete the registry key: `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters\SupportedEncryptionTypes`
1. Reboot the computer.

After rebooting, retry mounting the file share.

> [!TIP]  
> Removing the key restores Windows default behavior, allowing Active Directory to automatically negotiate AES for Kerberos tickets.

#### Option 2: Explicitly enable AES-256 using Group Policy

If your organization requires explicitly configured Kerberos encryption types:

1. Press **Win + R**, type `gpedit.msc`, and select **Enter**.
1. Navigate to:  **Local Computer Policy > Computer Configuration > Windows Settings > Security Settings > Local Policies > Security Options**
1. Open **Network Security: Configure encryption types allowed for Kerberos**.
1. Enable the following encryption types:
   - **AES256_HMAC_SHA1**  
   - **AES128_HMAC_SHA1** (optional)  
1. Apply the change and reboot the computer.

After rebooting, retry mounting the file share.

> [!IMPORTANT]  
> Entra Kerberos requires **AES256_HMAC_SHA1** to successfully mount Azure file shares. RC4 or DES-only configurations will fail.
> To understand more about registry keys, see [Decrypting the Selection of Supported Kerberos Encryption Types](https://techcommunity.microsoft.com/blog/coreinfrastructureandsecurityblog/decrypting-the-selection-of-supported-kerberos-encryption-types/1628797).

## Unable to configure directory/file level permissions (Windows ACLs) with Windows File Explorer

### Symptom

You might experience one of the symptoms described below when trying to configure Windows ACLs with Windows File Explorer on a mounted file share:

- After you click on **Edit permission** under the **Security** tab, the Permission wizard doesn't load. 
- When you try to select a new user or group, the domain location doesn't display the right AD DS domain. 
- You're using multiple AD forests and get the following error message: "The Active Directory domain controllers required to find the selected objects in the following domains are not available. Ensure the Active Directory domain controllers are available, and try to select the objects again."

### Solution

We recommend that you [configure directory/file level permissions using icacls](/azure/storage/files/storage-files-identity-configure-file-level-permissions#configure-windows-acls-with-icacls) instead of using Windows File Explorer.

## Unable to view UserPrincipalName (UPN) of a file/directory owner in File Explorer 

### Symptom

File Explorer displays the security identifier (SID) of a file/directory owner, but not the UPN.

### Cause

File Explorer calls an RPC API directly to the server (Azure Files) to translate the SID to a UPN. Azure Files doesn't support this API, so the UPN isn't displayed.

### Solution

On a domain-joined client, use the following PowerShell command to view all items in a directory and their owner, including UPN: 

```PowerShell
Get-ChildItem <Path> | Get-ACL | Select Path, Owner
```

## Errors when running Join-AzStorageAccountForAuth cmdlet

### Error: "The directory service was unable to allocate a relative identifier"

This error might occur if a domain controller that holds the RID Master FSMO role is unavailable or was removed from the domain and restored from backup.  Confirm that all Domain Controllers are running and available.

### Error: "Cannot bind positional parameters because no names were given"

This error is most likely triggered by a syntax error in the `Join-AzStorageAccountforAuth` command.Check the command for misspellings or syntax errors and verify that the latest version of the **AzFilesHybrid** module (https://github.com/Azure-Samples/azure-files-samples/releases) is installed.

## Azure Files on-premises AD DS Authentication support for AES-256 Kerberos encryption

Azure Files supports AES-256 Kerberos encryption for AD DS authentication beginning with the AzFilesHybrid module v0.2.2. AES-256 is the recommended encryption method, and it's the default encryption method beginning in AzFilesHybrid module v0.2.5. If you've enabled AD DS authentication with a module version lower than v0.2.2, you need to [download the latest AzFilesHybrid module](https://github.com/Azure-Samples/azure-files-samples/releases) and run the following PowerShell script. If you haven't enabled AD DS authentication on your storage account yet, follow this [guidance](/azure/storage/files/storage-files-identity-ad-ds-enable#option-one-recommended-use-azfileshybrid-powershell-module).

> [!IMPORTANT]
> If you were previously using RC4 encryption and update the storage account to use AES-256, you should run `klist purge` on the client and then remount the file share to get new Kerberos tickets with AES-256.

```PowerShell
$ResourceGroupName = "<resource-group-name-here>"
$StorageAccountName = "<storage-account-name-here>"

Update-AzStorageAccountAuthForAES256 -ResourceGroupName $ResourceGroupName -StorageAccountName $StorageAccountName
```
As part of the update, the cmdlet rotates the Kerberos keys, which is necessary to switch to AES-256. There is no need to rotate back unless you want to regenerate both passwords.

## User identity formerly having the Owner or Contributor role assignment still has storage account key access
The storage account Owner and Contributor roles grant the ability to list the storage account keys. The storage account key enables full access to the storage account's data including file shares, blobs, tables, and queues. It also provides limited access to the Azure Files management operations via the legacy management APIs exposed through the FileREST API. If you're changing role assignments, you should consider that the users being removed from the Owner or Contributor roles might continue to have access to the storage account through saved storage account keys.

### Solution 1
You can remedy this issue easily by rotating the storage account keys. We recommend rotating the keys one at a time, switching access from one to the other as they are rotated. There are two types of shared keys the storage account provides: the storage account keys, which provide super-administrator access to the storage account's data, and the Kerberos keys, which function as a shared secret between the storage account and the Windows Server Active Directory domain controller for Windows Server Active Directory scenarios.

To rotate the Kerberos keys of a storage account, see [Update the password of your storage account identity in AD DS](/azure/storage/files/storage-files-identity-ad-ds-update-password).

### [Portal](#tab/azure-portal)

Navigate to the desired storage account in the Azure portal. In the table of contents for the desired storage account, select **Access keys** under the **Security + networking** heading. In the **Access key** pane, select **Rotate key** above the desired key. 

:::image type="content" source="media/files-troubleshoot-smb-authentication/access-keys.png" alt-text="Screenshot that shows the 'Access key' pane."

### [PowerShell](#tab/azure-powershell)

The following script rotates both keys for the storage account. If you desire to swap out keys during rotation, you'll need to provide additional logic in your script to handle this scenario. Remember to replace `<resource-group>` and `<storage-account>` with the appropriate values for your environment.

```powershell
$resourceGroupName = "<resource-group>"
$storageAccountName = "<storage-account>"

# Rotate primary key (key 1). You should switch to key 2 before rotating key 1.
New-AzStorageAccountKey `
    -ResourceGroupName $resourceGroupName `
    -Name $storageAccountName `
    -KeyName "key1"

# Rotate secondary key (key 2). You should switch to the new key 1 before rotating key 2.
New-AzStorageAccountKey `
    -ResourceGroupName $resourceGroupName `
    -Name $storageAccountName `
    -KeyName "key2"
```

### [Azure CLI](#tab/azure-cli)

The following script rotates both keys for the storage account. If you desire to swap out keys during rotation, you'll need to provide additional logic in your script to handle this scenario. Remember to replace `<resource-group>` and `<storage-account>` with the appropriate values for your environment.

```bash
RESOURCE_GROUP_NAME="<resource-group>"
STORAGE_ACCOUNT_NAME="<storage-account>"

# Rotate primary key (key 1). You should switch to key 2 before rotating key 1.
az storage account keys renew \
    --resource-group $RESOURCE_GROUP_NAME \
    --account-name $STORAGE_ACCOUNT_NAME \
    --key "primary"

# Rotate secondary key (key 2). You should switch to the new key 1 before rotating key 2.
az storage account keys renew \
    --resource-group $RESOURCE_GROUP_NAME \
    --account-name $STORAGE_ACCOUNT_NAME \
    --key "secondary"
```

---

## Set the API permissions on a newly created application

After enabling Microsoft Entra Kerberos authentication, you must explicitly grant admin consent to the new Microsoft Entra application registered in your Microsoft Entra tenant to complete your configuration. You can configure the API permissions from the [Azure portal](https://portal.azure.com) by following these steps.

1. Open **Microsoft Entra ID**.
2. Select **App registrations** in the left pane.
3. Select **All Applications** in the right pane.
4. Select the application with the name matching *[Storage Account] $storageAccountName.file.core.windows.net*.
5. Select **API permissions** in the left pane.
6. Select **Add permissions** at the bottom of the page.
7. Select **Grant admin consent for "DirectoryName"**.

<a name='potential-errors-when-enabling-azure-ad-kerberos-authentication-for-hybrid-users'></a>

## Potential errors when enabling Microsoft Entra Kerberos authentication

You might encounter the following errors when enabling Microsoft Entra Kerberos authentication.

### Error - Grant admin consent disabled

In some cases, Microsoft Entra admin may disable the ability to grant admin consent to Microsoft Entra applications. Here's a screenshot of what this looks like in the Azure portal.

   :::image type="content" source="media/files-troubleshoot-smb-authentication/grant-admin-consent-disabled.png" alt-text="Screenshot that shows the 'Configured permissions' blade displaying a warning that some actions may be disabled due to your permissions." lightbox="media/files-troubleshoot-smb-authentication/grant-admin-consent-disabled.png":::

If this is the case, ask your Microsoft Entra admin to grant admin consent to the new Microsoft Entra application. To find and view your administrators, select **roles and administrators**, then select **Cloud application administrator**.

<a name='error---the-request-to-aad-graph-failed-with-code-badrequest'></a>

### Error - "The request to Microsoft Graph failed with code BadRequest"

#### Cause 1: An application management policy is preventing credentials from being created

When enabling Microsoft Entra Kerberos authentication, you might encounter this error if you (or your administrator) has set a [tenant-wide policy](/graph/api/resources/tenantappmanagementpolicy) or an [application management policy](/graph/api/resources/appmanagementpolicy) that:

- Applies to the "Storage Resource Provider" Enterprise Application (app ID `a6aa9161-5291-40bb-8c5c-923b567bee3b`).
- Sets a restriction on service principal passwords, which either blocks password addition or restricts maximum password lifetime to fewer than 365.5 days.

To resolve this error, you should configure the offending policy to [grant an exception](/entra/identity/enterprise-apps/configure-app-management-policies#grant-an-exception-to-a-user-or-service) to the "Storage Resource Provider" Enterprise Application (app ID `a6aa9161-5291-40bb-8c5c-923b567bee3b`).

#### Cause 2: An application already exists for the storage account

You might also encounter this error if you previously enabled Microsoft Entra Kerberos authentication through manual limited preview steps. To delete the existing application, the customer or their IT admin can run the following script. Running this script will remove the old manually created application and allow the new experience to auto-create and manage the newly created application. After initiating the connection to Microsoft Graph, sign in to the Microsoft Graph Command Line Tools application on your device and grant permissions to the app.

```powershell
$storageAccount = "exampleStorageAccountName"
$tenantId = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
Install-Module Microsoft.Graph
Import-Module Microsoft.Graph
Connect-MgGraph -TenantId $tenantId -Scopes "User.Read","Application.Read.All"

$application = Get-MgApplication -Filter "DisplayName eq '${storageAccount}'"
if ($null -ne $application) {
   Remove-MgApplication -ObjectId $application.ObjectId
}
```

<a name='error---service-principal-password-has-expired-in-azure-ad'></a>

## Error - Service principal password has expired in Microsoft Entra ID

If you've previously enabled Microsoft Entra Kerberos authentication through manual limited preview steps, the password for the storage account's service principal is set to expire every six months. Once the password expires, users won't be able to get Kerberos tickets to the file share.

To mitigate this, you have two options: either rotate the service principal password in Microsoft Entra every six months, or follow these steps to disable Microsoft Entra Kerberos, delete the existing application, and reconfigure Microsoft Entra Kerberos.

<a name='option-2-disable-azure-ad-kerberos-delete-the-existing-application-and-reconfigure'></a>

Be sure to save domain properties (domainName and domainGUID) before disabling Microsoft Entra Kerberos, as you'll need them during reconfiguration if you want to configure directory and file-level permissions using Windows File Explorer. If you didn't save domain properties, you can still [configure directory/file-level permissions using icacls](/azure/storage/files/storage-files-identity-configure-file-level-permissions#configure-windows-acls-with-icacls) as a workaround.

1. [Disable Microsoft Entra Kerberos](/azure/storage/files/storage-files-identity-auth-azure-active-directory-enable#disable-azure-ad-authentication-on-your-storage-account)
1. [Delete the existing application](#cause-2-an-application-already-exists-for-the-storage-account)
1. [Reconfigure Microsoft Entra Kerberos via the Azure portal](/azure/storage/files/storage-files-identity-auth-azure-active-directory-enable#enable-azure-ad-kerberos-authentication-for-hybrid-user-accounts)

Once you've reconfigured Microsoft Entra Kerberos, the new experience will auto-create and manage the newly created application.

## Error 1326 - The username or password is incorrect when using private link

If you're connecting to a storage account via a private endpoint/private link using Microsoft Entra Kerberos authentication, when attempting to mount a file share via `net use` or other method, the client is prompted for credentials. The user will likely type their credentials in, but the credentials are rejected.

#### Cause 

This is because the SMB client has tried to use Kerberos but failed, so it falls back to using NTLM authentication, and Azure Files doesn't support using NTLM authentication for domain credentials. The client can't get a Kerberos ticket to the storage account because the private link FQDN isn't registered to any existing Microsoft Entra application.

#### Solution

The solution is to add the privateLink FQDN to the storage account's Microsoft Entra application before you mount the file share. You can add the required identifierUris to the application object using the [Azure portal](https://portal.azure.com) by following these steps.

1. Open **Microsoft Entra ID**.
1. Select **App registrations** in the left pane.
1. Select **All Applications**.
1. Select the application with the name matching **[Storage Account] $storageAccountName.file.core.windows.net**.
1. Select **Manifest** in the left pane.
1. Copy and paste the existing content so you have a duplicate copy.
1. Edit the JSON manifest. For every `<storageAccount>.file.core.windows.net` entry, add a corresponding `<storageAccount>.privatelink.file.core.windows.net` entry. For instance, if your manifest has the following value for `identifierUris`:

   ```json
   "identifierUris": [
       "api://<tenantId>/HOST/<storageaccount>.file.core.windows.net",
       "api://<tenantId>/CIFS/<storageaccount>.file.core.windows.net",
       "api://<tenantId>/HTTP/<storageaccount>.file.core.windows.net",
       "HOST/<storageaccount>.file.core.windows.net",
       "CIFS/<storageaccount>.file.core.windows.net",
       "HTTP/<storageaccount>.file.core.windows.net"
   ],
   ```

   Then you should edit the `identifierUris` field to the following:

   ```json
   "identifierUris": [
       "api://<tenantId>/HOST/<storageaccount>.file.core.windows.net",
       "api://<tenantId>/CIFS/<storageaccount>.file.core.windows.net",
       "api://<tenantId>/HTTP/<storageaccount>.file.core.windows.net",
       "HOST/<storageaccount>.file.core.windows.net",
       "CIFS/<storageaccount>.file.core.windows.net",
       "HTTP/<storageaccount>.file.core.windows.net",

       "api://<tenantId>/HOST/<storageaccount>.privatelink.file.core.windows.net",
       "api://<tenantId>/CIFS/<storageaccount>.privatelink.file.core.windows.net",
       "api://<tenantId>/HTTP/<storageaccount>.privatelink.file.core.windows.net",
       "HOST/<storageaccount>.privatelink.file.core.windows.net",
       "CIFS/<storageaccount>.privatelink.file.core.windows.net",
       "HTTP/<storageaccount>.privatelink.file.core.windows.net"
   ],
   ```

1. Review the content and select **Save** to update the application object with the new identifierUris.
1. Update any internal DNS references to point to the private link.
1. Retry mounting the share.


## Intermittent authentication failures after network changes when using Microsoft Entra Kerberos

### Symptom

Windows clients that use Microsoft Entra Kerberos authentication to access Azure Files intermittently lose access after a network change (for example, VPN reconnect, Wi-Fi change, sleep or resume). Access may fail until the user signs out and signs back in to Windows.

### Cause

This issue is caused by a known Windows behavior where certain network changes clear the cached KDC proxy configuration on the client. When the KDC proxy configuration is removed, the client is unable to refresh Kerberos service tickets from Microsoft Entra ID.

Although the user’s Primary Refresh Token (PRT) remains valid, the missing KDC proxy configuration prevents the client from acquiring a new service ticket, resulting in authentication failures.

This is a Windows client limitation and is not caused by Azure Files or Microsoft Entra ID configuration.

### Solution

**Option one**: Signing out and signing back in to Windows restores access by fetching a new PRT, which includes a refreshed Ticket Granting Ticket (TGT) and KDC proxy configuration. However, this results in a poor user experience.

**Option two**: Configure a Group Policy setting to persist the KDC proxy configuration on the client, reducing authentication interruptions caused by network changes.
1. Configure KDC proxy settings using Group Policy.
2. Open Group Policy Management and edit the applicable policy.
3. Navigate to: **Administrative Templates** > **System** > **Kerberos** > **Specify KDC proxy servers for Kerberos clients**
4. Select **Enabled**.
5. Under **Options**, select **Show** to open the Show Contents dialog box.
6. Add the following mapping, replacing `Microsoft_Entra_tenant_id` with your Microsoft Entra tenant ID. Include the space after https and before the closing /.

|Value name |Value |
|-----------|--------------|
| KERBEROS.MICROSOFTONLINE.COM| <https login.microsoftonline.com:443:your_Microsoft_Entra_tenant_id/kerberos /> |

7. Select **OK**, then select **Apply**.

After this policy is applied, Windows clients retain the KDC proxy configuration across network changes, reducing authentication disruptions.

## Authentication stops after approximately 10 hours when using Microsoft Entra Kerberos

### Symptom

Windows clients using Microsoft Entra Kerberos authentication to access Azure Files lose access after approximately 10 hours of continuous use. Access is restored only after the user signs out and signs back in to Windows.

### Cause

This issue is caused by a known limitation in Microsoft Entra Kerberos authentication. Microsoft Entra ID does not currently support renewal of Ticket Granting Tickets (TGTs).

In Microsoft Entra Kerberos scenarios, the TGT is obtained as part of the user’s Primary Refresh Token (PRT). Because TGT renewal is not supported, the client cannot refresh the TGT once it expires. When the TGT expires, the client is unable to acquire new service tickets, resulting in authentication failures.

Signing out and signing back in to Windows resolves the issue by obtaining a new PRT, which includes a new TGT.
This is a known limitation of Microsoft Entra Kerberos and is not caused by Azure Files configuration.

### Solution

As a mitigation, customers can use cloud trust between on-premises Active Directory Domain Services (AD DS) and Microsoft Entra ID when accessing Azure Files.

With cloud trust configured, Windows clients obtain their TGT from AD DS instead of Microsoft Entra ID. AD DS-issued TGTs support renewal, avoiding the expiration behavior seen with Microsoft Entra Kerberos. The AD DS-issued TGT is then exchanged for an Entra referral TGT, which is used to obtain service tickets for Azure Files.

This mitigation applies only to clients that are:
- AD DS domain joined, or
- Hybrid Microsoft Entra joined
- Cloud-native (Microsoft Entra–only) clients can't use this workaround.

To apply this mitigation, configure a cloud trust between on-premises AD DS and Microsoft Entra ID for accessing Azure Files. For step-by-step guidance, see [Configure a cloud trust for Azure Files authentication](/azure/storage/files/storage-files-identity-auth-hybrid-cloud-trust).

## Error AADSTS50105

### Symptom

The request was interrupted by the following error AADSTS50105:

> Your administrator has configured the application "Enterprise application name" to block users unless they are specifically granted (assigned) access to the application. The signed in user '{EmailHidden}' is blocked because they are not a direct member of a group with access, nor had access directly assigned by an administrator. Please contact your administrator to assign access to this application.

### Cause

If you set up "assignment required" for the corresponding enterprise application, you won't be able to get a Kerberos ticket, and Microsoft Entra sign-in logs will show an error even though users or groups are assigned to the application.

### Solution

Don't select **Assignment required for Microsoft Entra application** for the storage account because we don't populate entitlements in the Kerberos ticket that's returned back to the requestor. For more information, see [Error AADSTS50105 - The signed in user is not assigned to a role for the application](../../../entra-id/app-integration/error-code-AADSTS50105-user-not-assigned-role.md).

## See also

- [Troubleshoot Azure Files](../connectivity/files-troubleshoot.md)
- [Troubleshoot Azure Files performance](../performance/files-troubleshoot-performance.md)
- [Troubleshoot Azure Files connectivity (SMB)](../connectivity/files-troubleshoot-smb-connectivity.md)
- [Troubleshoot Azure Files general SMB issues on Linux](files-troubleshoot-linux-smb.md)
- [Troubleshoot Azure Files general NFS issues on Linux](files-troubleshoot-linux-nfs.md)
- [Troubleshoot Azure File Sync issues](../file-sync/file-sync-troubleshoot.md)
