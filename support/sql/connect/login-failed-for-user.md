---
title: Troubleshooting information for login failed for user errors
description: Provides troubleshooting information for various "Login failed for user" errors that appear when connecting to an instance of SQL Server.  
ms.date: 02/23/2022
author: ramakoni1
ms.author: v-jayaramanp
ms.custom: sap:Connection issues
ms.prod: sql
---

# Troubleshooting "Login failed for user" errors

> [!NOTE]
> Before you start to troubleshoot issues, we recommend that you review the [prerequisites](resolving-connectivity-errors.md#prerequisite) and go through the general checklist for the steps to troubleshoot connectivity-related errors.

_Applies to:_ &nbsp; SQL Server

This article provides troubleshooting information that you can use if you receive various "Login failed for user" error messages when you try to connect to an instance of Microsoft SQL Server. User logins can fail for many reasons, such as invalid credentials, password expiration, and enabling the wrong authentication mode. In many cases, error codes include descriptions. The following examples are some of the common login failures. Select the exact error that you're experiencing to troubleshoot the issue.

- [Login failed for user 'NT AUTHORITY\ANONYMOUS' LOGON](#login-failed-for-user-nt-authorityanonymous-logon)
- [Login failed for user '(null)'](#login-failed-for-user-null)
- [Login failed for user 'empty'](#login-failed-for-user-empty)
- [Login failed for user '\<username>' or login failed for user '\<domain>\\\<username>'](#login-failed-for-user-username-or-login-failed-for-user-domainusername)

## Login failed for user `NT AUTHORITY\ANONYMOUS` LOGON

There are at least four scenarios for this issue. In the following table, examine each applicable potential cause, and use the appropriate resolution.

|Potential causes  |Suggested resolutions  |
|---------|---------|
|There are double-hop scenarios on the same computer. You're trying to do a double hop, but New Technology LAN Manager (NTLM) credentials are being used instead of Kerberos.      | For double-hop scenarios on the same computer, [add the *DisableLoopbackCheck* or *BackConnectionHostNames* registry entries](../../windows-server/networking/accessing-server-locally-with-fqdn-cname-alias-denied.md#method-1-recommended-create-the-local-security-authority-host-names-that-can-be-referenced-in-a-ntlm-authentication-request).
|There are double-hop scenarios across multiple computers. The error could occur if the Kerberos connection is failing because of Service Principal Names (SPN) issues.      | Use [Kerberos Configuration Manager for SQL Server](https://www.microsoft.com/download/details.aspx?id=39046) to check for duplicate or misconfigured SPNs. For more information, see [Troubleshooting authentication failures due to Kerberos issues](using-kerberosmngr-sqlserver.md).|
|No double-hop is involved.      |    If no double-hop is involved, this could mean that there are Duplicate SPNs, and the client is running as *LocalSystem* or another machine account that gets NTLM credentials instead of Kerberos credentials. Use [Kerberos Configuration Manager](using-kerberosmngr-sqlserver.md) or [Setspn.exe](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc731241(v=ws.11)) to diagnose and fix any SPN-related issues. For more information, see [Troubleshooting authentication failures because of Kerberos issues](using-kerberosmngr-sqlserver.md) to diagnose and resolve SPN issues.     |
|Windows Local Security policy might have been configured to prevent the use of the machine account for remote authentication requests.      |      Navigate to **Local Security Policy** > **Local Policies** > **Security Options** > **Network security: Allow Local System to use computer identity for NTLM**, select the **Enabled** option if the setting is disabled, and then select **OK**.<br/><br/>**Note**: As detailed on the **Explain** tab, this policy is enabled in Windows 7 and later versions by default.    |

## Login failed for user '(null)'

An indication of "null" could mean that the Local Security Authority Subsystem Service (LSASS) can't decrypt the security token by using the SQL Server service account credentials. The main reason for this condition is that the SPN is associated with the wrong account.

To fix the issue:

1. Use the [Kerberos Configuration Manager](using-kerberosmngr-sqlserver.md) or [Setspn.exe](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc731241(v=ws.11)) to diagnose and fix SPN-related issues.
1. Use the Kerberos Configuration Manager **Delegation** tab to check whether the SQL Service account is trusted for delegation. If the output indicates that the account isn't trusted for delegation, work with your Active Directory administrator to enable delegation for the account.

1. Diagnose and fix (DNS) name resolution issues (use the NSLookup or PowerShell example):

    `ping -a <your_target_machine>` (use -4 and -6 for IPv4 and IPv6 specifically)

    `ping -a <your_remote_IPAddress>`

    `nslookup` (enter your local and remote computer name and IP address multiple times)

1. Look for any discrepancies and mismatches in the returned results. The accuracy of the DNS configuration on the network is important for a successful SQL Server connection. An incorrect DNS entry could cause numerous connectivity issues later.

1. Make sure that firewalls or other network devices don't block a client from connecting to the domain controller. SPNs are stored in Active Directory. If the clients can't communicate with the directory, the connection can't succeed.
    
## Login failed for user (empty)

This error occurs when a user tries unsuccessfully to log in. This error might occur if your computer isn't connected to the network. For example, you may receive an error message that resembles the following example:

```output
Source: NETLOGON
Date: 8/12/2012 8:22:16 PM
Event ID: 5719
Task Category: None
Level: Error
Keywords: Classic
User: N/A
Computer: <computer name>
Description:This computer was not able to set up a secure session with a domain controller in domain due to the following: The remote procedure call was cancelled. This may lead to authentication problems. Make sure that this computer is connected to the network. If the problem persists, please contact your domain administrator.
```
An empty string means that SQL Server tried to hand off the credentials to LSASS but couldn't because of some problem. Either LSASS wasn't available or the domain controller couldn't be contacted.

Check the event logs on the client and the server for any network-related or Active Directory-related messages that were logged around the time of the failure. If you find any, work with your domain administrator to fix the issues.

## Login failed for user '\<username>' or login failed for user '\<domain>\\\<username>'

If the domain name isn't specified, the problem is a failing SQL Server login attempt. If the domain name is specified, the problem is a failing Windows user account login. See the following table for potential causes and suggested resolution:

| Potential cause   | Suggested resolution   |
| --------- | --------- |
| The database requested is offline or otherwise not available.      |   Check permissions and database availability in the SQL Server Management Studio.        |
| The user doesn't have permissions to the requested database.       |   Try connecting as another user that has sysadmin rights.       |

For other tips, see [Books Online topic MSSQLSERVER 18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?view=sql-server-ver15&preserve-view=true). This topic contains more information about error codes. Also, check the extensive list of error codes at [Troubleshooting Error 18456.](https://sqlblog.org/2011/01/14/troubleshooting-error-18456) (external link).

For more troubleshooting help, see [Troubleshooting Consistent Authentication issues – CSS SQL wiki](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0000-Troubleshooting-Workflows).

## See also

- [Troubleshoot connectivity issues in SQL Server](resolve-connectivity-errors-overview.md)