---
title: Extranet Smart Lockout feature in Windows Server 2016
description: Describes the Extranet Smart Lockout feature in Windows Server 2016.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, tquerec, dougking, v-jeffbo
ms.custom: sap:active-directory-federation-services-ad-fs, csstroubleshoot
---
# Description of the Extranet Smart Lockout feature in Windows Server 2016

This article describes the Extranet Smart Lockout feature in Windows Server 2016.

_Applies to:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4096478

## Overview

As of the March 2018 update for Windows Server 2016, Active Directory Federation Services (AD FS) has a new feature that is namedExtranet Smart Lockout (ESL). In an era of increased attacks on authentication services, ESL enables AD FS to differentiate between sign-in attempts from a valid user and sign-ins from what may be an attacker. As a result, AD FS can lock out attackers while letting valid users continue to use their accounts. This prevents denial of service for users and protects against targeted attacks against known user accounts.

The ESL feature is available for AD FS in Windows Server 2016.

## How to install and configure ESL

### Install updates on all nodes in the farm

First, make sure that all Windows Server 2016 AD FS servers are up to date as of the March 2018 Windows Updates.

### Update artifact database permissions

Extranet smart lockout requires the AD FS service account to have permissions to create a new table in the AD FS artifact database. Log in to any AD FS server as an AD FS admin, and then grant this permission by executing the following commands in a PowerShell Command Prompt window:

```powershell
$cred= Get-Credential
Update-AdfsArtifactDatabasePermission -Credential$cred
```
  
> [!Note]
> The $cred placeholder is an account that has AD FS administrator permissions. This should provide the write permissions to create the table.

The commands above may fail due to lack of sufficient permission because your AD FS farm is using SQL Server, and the credential provided above does not have admin permission on your SQL server. In this case, you can configure database permissions manually in SQL Server Database by running the following command when you're connected to the AdfsArtifactStore database.

```sql
ALTER AUTHORIZATION ON SCHEMA::[ArtifactStore] TO [db_genevaservice]
```  

### Configure ESL

A new parameter that is named ExtranetLockoutMode is added to support ESL. It contains the following values:

- ADPasswordCounter- This is the legacy AD FS "extranet soft lockout" mode, which does not differentiate based on location. This is the default value.
- ADFSSmartLockoutLogOnly- This is Extranet Smart Lockout. Instead of rejecting authentication requests, AD FS writes admin and audit events.
- ADFSSmartLockoutEnforce- This is Extranet Smart Lockout with full support for blocking unfamiliar requests when thresholds are reached.

We recommend that you first set the lockout provider to log-only for a short period of time (1 to 3 days) by running the following cmdlet. Review audits (see below for details) during this period to determine the number of accounts that may potentially be impacted as well as the frequency of these events. After successful evaluation of the audits, set the setting to "ADFSSmartLockoutEnforce" mode:

```powershell
Set-AdfsProperties -ExtranetLockoutMode AdfsSmartlockoutLogOnly
```
  
In this mode, AD FS performs the analysis but does not block any requests because of lockout counters. This mode is used to validate that smart lockout is running successfully before it enables "enforce" mode.

For the new mode to take effect, restart the AD FS service on all nodes in the farm by running the following command:

```powershell
Restart-service adfssrv
```  

### Set lockout threshold and observation window

There are two key settings for ESL: lockout threshold and observation window.

#### Lockout threshold setting

Every time that a password-based authentication is successful, AD FS stores the client IPs as familiar locations in the account activity table.

If password-based authentication fails and the credentials do not come from a familiar location, the failed authentication count is incremented.

After the number of failed password attempts from unfamiliar locations reaches the lockout threshold, if password-based authentication from an unfamiliar location fails, the account is locked out.

> [!Note]
> Lockout continues to apply to familiar locations separately from this new unfamiliar lockout counter.

The threshold is set by using `Set-AdfsProperties`.

Example:

```powershell
Set-AdfsProperties -ExtranetLockoutThreshold 10
```  

#### Observation window setting

The observation window setting allows an account to automatically unlock after some time. After the account unlocks, one authentication attempt is allowed. If the authentication succeeds, the failed authentication count is reset to 0. If it fails, the system waits for another observation window before the user can try again.

The observation window is set by using `Set-AdfsProperties` as in the following example command:

```powershell
Set-AdfsProperties -ExtranetObservationWindow ( new-timespan -minutes 5 )
```

### Enable lockout

Extranet lockout can be enabled or disabled by using the EnableExtranetLockout parameter as in the following examples.

To enable lockout, run the following command:

```powershell
Set-AdfsProperties -EnableExtranetLockout $true
```
  
To disable lockout, run the following command:

```powershell
Set-AdfsProperties -EnableExtranetLockout $false
```  

### Enable enforce mode

After you're comfortable with the lockout threshold and observation window, ESL can be moved to "enforce" mode by using the following PSH cmdlet:

```powershell
Set-AdfsProperties -ExtranetLockoutMode AdfsSmartLockoutEnforce
```
  
For the new mode to take effect, restart the AD FS service on all nodes in the farm by using the following command:

```powershell
Restart-service adfssrv
```  

## Managing ESL

### Manage user account activity

AD FS provides three cmdlets to manage user account activity data. These cmdlets automatically connect to the node in the farm that holds the master role.

> [!Note]
> This behavior can be overridden by passing the -Server parameter.

- `Get-ADFSAccountActivity`
  
    Read the current account activity for a user account. The cmdlet always automatically connects to the farm master by using the Account Activity REST endpoint. Therefore, all data should always be consistent.

    ```powershell
    Get-ADFSAccountActivity user@contoso.com
    ```

- `Set-ADFSAccountActivity`
  
    Update the account activity for a user account. This can be used to add new familiar locations or erase state for any account.

    ```powershell
    Set-ADFSAccountActivity user@contoso.com -FamiliarLocation "1.2.3.4"
    ```

- `Reset-ADFSAccountLockout`
  
    Resets the lockout counter for a user account.

    ```powershell
    Reset-ADFSAccountLockout user@contoso.com -Familiar
    ```

## Troubleshooting

### Updating database permissions

If any errors are returned from the `Update-AdfsArtifactDatabasePermission` cmdlet, verify the following:

- Verification will fail if nodes are on the farm list but are no longer members of the farm. This can be fixed by running `remove-adfsnode <node name>`.
- Verify that the update is deployed on all nodes in the farm.
- Verify that the credentials that are passed to the cmdlet have permission to modify the owner of the AD FS artifact database schema.

### Logging/auditing

When an authentication request is rejected because the account exceeds the lockout threshold, AD FS will write an ExtranetLockoutEvent to the security audit stream.

#### Example logged event

> An extranet lockout event has occurred. See XML for failure details.  
Activity ID: 172332e1-1301-4e56-0e00-0080000000db  
Additional Data  
XML: \<?xml version="1.0" encoding="utf-16"?>
\<AuditBase xmlns:xsd="`http://www.w3.org/2001/XMLSchema`" xmlns:xsi="`http://www.w3.org/2001/XMLSchema-instance`" xsi:type="ExtranetLockoutAudit">
\<AuditType>ExtranetLockout\</AuditType>  
\<AuditResult>Failure\</AuditResult>  
\<FailureType>ExtranetLockoutError\</FailureType>  
\<ErrorCode>AccountRestrictedAudit\</ErrorCode>  
\<ContextComponents>  
\<Component xsi:type="ResourceAuditComponent">  
\<RelyingParty>`http://contoso.com` /adfs/services/trust\</RelyingParty>  
\<ClaimsProvider>N/A\</ClaimsProvider>  
\<UserId>TQDFTD\Administrator\</UserId>  
\</Component>  
\<Component xsi:type="RequestAuditComponent">  
\<Server>N/A\</Server>  
\<AuthProtocol>WSFederation\</AuthProtocol>  
\<NetworkLocation>Intranet\</NetworkLocation>  
\<IpAddress>4.4.4.4\</IpAddress>  
\<ForwardedIpAddress />  
\<ProxyIpAddress>1.2.3.4\</ProxyIpAddress>  
\<NetworkIpAddress>1.2.3.4\</NetworkIpAddress>  
\<ProxyServer>N/A\</ProxyServer>  
\<UserAgentString>Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36\</UserAgentString>  
\<Endpoint>/adfs/ls\</Endpoint>  
\</Component>  
\<Component xsi:type="LockoutConfigAuditComponent">  
\<CurrentBadPasswordCount>5\</CurrentBadPasswordCount>  
\<ConfigBadPasswordCount>5\</ConfigBadPasswordCount>  
\<LastBadAttempt>02/07/2018 21:47:44\</LastBadAttempt>  
\<LockoutWindowConfig>00:30:00\</LockoutWindowConfig>  
\</Component>  
\</ContextComponents>  
\</AuditBase>

## Uninstall

SQL Server database farms can uninstall the update by using the Settings application without issue.

WID database farms must follow these steps because of the updated WID database verification binary:

1. Run the Uninstall psh script that stops the service and drops the account activity table.

    ```powershell
    Stop-Service adfssrv -ErrorAction Stop
    
    $doc = new-object Xml
    $doc.Load("$env:windir\ADFS\Microsoft.IdentityServer.Servicehost.exe.config")
    $connString = $doc.configuration.'microsoft.identityServer.service'.policystore.connectionString
    
    if ( -not $connString -like "*##wid*" )
    {
        Write-Error "SQL installs don't require DB updates, skipping DB table drop"
    }
    else
    {
            $connString = "Data Source=np:\\.\pipe\microsoft##wid\tsql\query;Initial Catalog=AdfsArtifactStore;Integrated Security=True"
            stop-service adfssrv
            $cli = new-object System.Data.SqlClient.SqlConnection
            $cli.ConnectionString = $connString
            $cli.Open()
            try
            {
            $cmd = new-object System.Data.SqlClient.SqlCommand
            $cmd.CommandText = "IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ArtifactStore].[AccountActivity]') AND type in (N'U')) DROP TABLE [ArtifactStore].[AccountActivity]"
            $cmd.Connection = $cli
            $cmd.ExecuteNonQuery()
        }
        finally
        {
            $cli.CLose()
        } write-warning "Finish removing the patch using the Settings app and then restart the complete to complete the uninstall"
    }
    ```

2. Uninstall the update by using the settings application.
3. Restart the computer.
