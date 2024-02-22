---
title: The encryption type requested is not supported by the KDC
description: Describes how to resolve errors that occur after changing SharePoint configuration requirements to support Kerberos AES encryption.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: levaznis
appliesto: 
  - SharePoint Server 2019
  - SharePoint Server 2016
  - SharePoint Server 2013
  - SharePoint Server 2010
search.appverid: MET150
ms.date: 12/17/2023
---
# SharePoint server configuration requirements to support Kerberos AES encryption if errors occur

_Original KB number:_ &nbsp; 4501051

## Symptoms

You receive errors after you have modified the setting **Network Security: Configure encryption types allowed for Kerberos** via local policy or GPO from the default values to a value that only allows the following encryption types:

- AES128_HMAC_SHA1
- AES256_HMAC_SHA1
- Future encryption types

If errors are written to the SharePoint Universal Logging System (ULS) logs, they indicate that the encryption type requested isn't supported by the KDC. Actions that trigger these errors include (but are not limited to):

- Accessing the Manage Service Account page in Central Administration
- Accessing the Search Administration page (the Search Topology may not display)
- Making changes to the search configuration

The underlying error message written to the SharePoint ULS logs is:

> Exception : System.ServiceModel.Security.SecurityNegotiationException: **A call to SSPI failed, see inner exception**.  
> \---> System.Security.Authentication.AuthenticationException: A call to SSPI failed, see inner exception.  
> \---> System.ComponentModel.Win32Exception: **The encryption type requested is not supported by the KDC**  
> \--- End of inner exception stack trace ---

The Project Server Service Application might also log a similar message:

> PWA:`https://<SharePoint>/<Site>`, ServiceApp:PWA, User:i:0#.w|Domain\UserId,  
> PSI: failed to send job notification to queue for site \<Guid>, exception System.ServiceModel.  Security.SecurityNegotiationException: A call to SSPI failed, see inner exception.  
> \---> System.Security.Authentication.AuthenticationException: **A call to SSPI failed, see inner exception**.  
> \---> System.ComponentModel.Win32Exception: **The encryption type requested is not supported by the KDC**

During the process of provisioning User Profile Services, you are unable to start the User Profile Synchronization service.

When starting the User Profile Service in Central Administration, the service starts and then stops immediately. Inspection of the SharePoint ULS indicates that the failure to start is a result of the following:

> "UserProfileApplication.SynchronizeMIIS: Failed to configure ILM, will attempt to rerun.  
> Exception: System.Security.SecurityException: The encryption type requested is not supported by the KDC."

Other components might write error messages indicating that the encryption type requested is not supported by the KDC.

## Cause

This behavior occurs because of a conflict between the custom local policy or group policy and the service account's properties in Active Directory. When you configure the property setting **Network Security: Configure encryption types allowed for Kerberos** so that the server only supports AES encryption types and future encryption types, the server won't support older Kerberos encryption types in Kerberos tickets. It's also important to note that user account objects created in Active Directory aren't configured to support Kerberos AES encryption by default.

If the server is configured to require AES encryption types for Kerberos, but the service account's properties in Active Directory haven't been updated to support AES encryption, the result is a scenario where the server is unable to negotiate a common encryption type for Kerberos tickets.

## Resolution

To resolve this issue, follow these steps:

1. Identify all accounts that are used within SharePoint as application pool accounts and service accounts.
2. Locate the accounts in Active Directory Users and Computers.
3. Select **Properties**.
4. Select the **Account** tab.
5. In the section titled **Account Options**, ensure that one or both of the following options are selected. This will enable support for Kerberos AES encryption on these user objects:
   - This account supports Kerberos AES 128 bit encryption
   - This account supports Kerberos AES 256 bit encryption

6. Perform an `iisreset` on the servers and restart any SharePoint related services that are running in the context of the modified service accounts.

If the issue isn't fixed, try the resolution in [SCCM: "The encryption type requested is not supported by the KDC" Error When Running Reports](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/sccm-quot-the-encryption-type-requested-is-not-supported-by-the/ba-p/570914).

## More information

To check whether your SharePoint server is configured to only support AES encryption types or newer types:

1. On the server, start the **Local Security Policy Editor** (secpol.msc).
2. Expand **Security Settings** > **Local Policies** > **Security Options**.
3. Locate **Network Security: Configure encryption types allowed for Kerberos**.
4. Select **Properties**.

If only the following Options are selected:

- AES128_HMAC_SHA1
- AES256_HMAC_SHA1
- Future encryption types

:::image type="content" source="media/configuration-to-support-kerberos-aes-encryption/encryption-types.png" alt-text="Screenshot of encryption types allowed for Kerberos.":::

Then you will need to enable **Support for Kerberos AES Encryption** on the Active Directory user objects that are used to run SharePoint services and application pools.

You can use the following PowerShell script to identify the SharePoint service accounts and test whether they are configured to support AES encryption types:

```powershell
Add-PSSnapin Microsoft.SharePoint.Powershell
$AES_128 = 0x8
$AES_256 = 0x10
$Separator="\"
$option = [System.StringSplitOptions]::RemoveEmptyEntries
Write-Host "Retrieving SharePoint Managed Accounts" -ForegroundColor White
$SharePointAccounts=""
$ManagedAccounts=Get-SPManagedAccount
foreach ($ManagedAccount in $ManagedAccounts)
{
Write-Host "Checking Account: "$ManagedAccount.Username
$temp=$ManagedAccount.Username
$samaccountName=$temp.Split($separator,2, $option)[1]
$userobj=([adsisearcher]"samAccountName=$samaccountName").FindOne()
$EncryptionTypes=$userobj.properties.Item('msds-supportedencryptiontypes')[0]
#$EncryptionTypes
$HexValue='{0:X}' -f $EncryptionTypes
if ($EncryptionTypes -band $AES_128)
{
Write-Host "Account Supports AES128 bit encryption " -ForegroundColor Green
}
Else
{
Write-Host "Account Does Not have AES128 bit encryption support enabled" -ForegroundColor Red
}
if ($EncryptionTypes -band $AES_256)
{
Write-Host "Account Supports AES256 bit encryption " -ForegroundColor Green
}
Else
{ Write-Host "Account Does Not have AES256 bit encryption support enabled" -ForegroundColor Red
}
}
====================== END SCRIPT ========================================================
```
