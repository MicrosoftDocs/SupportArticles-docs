---
title: Introduction to consistent authentication issues
description: This article introduces to consistent authentication issues, the types of error messages, and workarounds to troubleshoot various issues.
ms.date: 02/29/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes v-jayaramanp
ms.custom: sap:Connection issues
---

# Troubleshoot consistent authentication issues

_Applies to:_ &nbsp; SQL Server

> [!NOTE]
> The commands provided in this article are for Windows systems only.

A consistent authentication issue in SQL Server typically refers to problems related to authentication and authorization of users or applications trying to access the SQL Server database. These issues can lead to authentication failures, access denied errors, or other security-related problems.

Before you start to troubleshoot errors, it's important to understand what each error means and also what is the type of error. Some errors might appear in more than one category. You can use the troubleshooting information mentioned in the [Errors](#errors) section to resolve the error. If you still encounter issues, check the possible causes and solutions or workarounds in the other sections such as:

- [Causes and scenarios specific to various aspects of SQL Server](#causes-and-scenarios-specific-to-various-aspects-of-sql-server)

- [Causes specific to connection string](#causes-related-to-connection-string)

- [Causes specific to Windows permissions or Policy settings](#causes-related-to-windows-permissions-or-policy-settings)

- [Causes specific to NT LAN Manager (NTLM)](#causes-specific-to-nt-lan-manager-ntlm)

- [Causes and scenarios specific to Active Directory and Domain Controller](#causes-and-scenarios-related-to-active-directory-and-domain-controller)

- [Causes and scenarios related to Kerberos authentication](#causes-and-scenarios-related-to-kerberos-authentication)

- [Causes and scenarios specific to other aspects](#causes-related-to-other-aspects)

## Prerequisites

Before you start troubleshooting, check the [prerequisites](../connect/resolve-connectivity-errors-checklist.md) and go through the checklist.

- Make sure to install the WIRESHARK and Problem Steps Recorder (PSR.EXE) utilities. For more information, see *Methods of collecting data for troubleshooting various types of errors*.

- Collect the Service Provider Name (SPN) information based on the service accounts by using the `SETSPN -L` command.

## Errors

This section describes the types of errors and its related information.

- Directory services errors

  If the SQL Server error log file contains both or either of the following messages, then this error is related to Active Directory (AD). This error might occur if the domain controller (DC) can't be contacted by Windows on the SQL Server computer or the local security service (LSASS) is having an issue.

  ```output
   Error -2146893039 (0x80090311): No authority could be contacted for authentication.
   Error -2146893052 (0x80090304): The Local Security Authority cannot be contacted.
  ```

- Login failed errors

  When you are troubleshooting the "Login Failed" error message, the SQL Server error log file can provide more information in the [SQL state value](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#additional-error-information) with error 18456 (Login Failed). You can try to fix the issue according to the description of the state value.

  This section lists some specific "Login Failed" error messages and their possible causes and solutions.

  |Error message  |More information  |
  |---------|---------|
  |"Login failed for user '\<username\>'. Reason: Password did not match that for the login provided."|This error might occur if a bad password is used. For more information, see [Login failed for user '\<username\>' or login failed for user '\<domain>\<username>'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).|
  |"SQL Server does not exist or access denied."  | [Named Pipes connections](named-pipes-connection-fail-no-windows-permission.md) fail because the user doesn't have permission to log into Windows.     |
  |"Cannot open database \<test\> requested by the login. The login failed."|The database might be offline, or the permissions might not be sufficient. For more information, see [Database offline in MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-NT-AUTHORITY-ANONYMOUS-LOGON).<br/> Also, check if the database name in the connection string is correct.|
  |"A transport-level error has occurred when sending the request to the server."|Check if the [linked server account mapping](linked-server-account-mapping-error.md) is correct. For more information, see [sp_addlinkedsrvlogin](/sql/relational-databases/system-stored-procedures/sp-addlinkedsrvlogin-transact-sql).|
  |SSPI (Security Support Provider Interface) Context.|Check if the [SPN is on the wrong account](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).|
  |"Login failed for user \<username\>." | This error can occur if the [proxy account](../../integration-services/ssis-package-doesnt-run-when-called-job-step.md) isn't properly authenticated.    |
  |"Login Failed for user: 'NT AUTHORITY\ANONYMOUS LOGON'"|This error might occur if the [SPN is missing, SPN is duplicated, or the SPN is on the wrong account](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).|
  |"Login failed for user \<username\>." </br> "Login failed for user '\<database\username\>"</br>    | Check if there's a [bad server name in connection string](bad-server-name-connection-string-error.md). Also, check if the user doesn't belong to a local group used to grant access to the server. For more causes, see [NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#Login-failed-for-user-NT-AUTHORITY-ANONYMOUS-LOGON).    |
  |"Cannot generate SSPI context" | The explicit SPN account might be [wrong](wrong-explicit-spn-account-connection-string.md), missing, or misplaced. |
  |"The user account is not allowed the Network Login type"|You might not be able to [log in to the network](network-login-disallowed.md).|
  |"The login is from an untrusted domain and cannot be used with Windows authentication."|This error might be related to the [Local Security Subsystem](local-security-subsystem-errors.md) issues.|

## Causes and scenarios specific to SQL login

This section lists various causes related to failure of SQL Login.

- [Bad password](#bad-password)
- [Invalid username](#invalid-username)
- [SQL logins aren't enabled](#sql-logins-are-not-enabled)
- [Named Pipes connections fail because the user doesn't have permission to log into Windows](#named-pipes-connections-fail-because-the-user-doesnt-have-permission-to-log-into-windows)

## Causes and scenarios specific to various aspects of SQL Server

This section lists various causes that are related to aspects such as database, logon account permissions, and linked servers.

- [Database is offline](#database-is-offline)
- [Database permissions](#database-permissions)
- [User has not logged in](#user-has-not-logged-in)
- [Linked Server Account Mapping](#linked-server-account-mapping)
- [Proxy account doesn't have permissions](#proxy-account-doesnt-have-permissions)
- [Unable to log in to SQL Server database](#unable-to-log-in-to-sql-server-database)
- [Metadata of the linked server is inconsistent](#metadata-of-the-linked-server-is-inconsistent)

## Causes related to connection string

This section lists various causes related to connection string.

- [Bad server name in connection string](#bad-server-name-in-connection-string)
- [Wrong database name in connection string](#wrong-database-name-in-connection-string)
- [Wrong explicit SPN account](#wrong-explicit-spn-account)
- [Explicit SPN is missing](#explicit-spn-is-missing)
- [Explicit misplaced SPN](#explicit-misplaced-spn)
- [Explicit SPN is duplicated](#explicit-spn-is-duplicated)

## Causes related to Windows permissions or Policy settings

This section lists various issues that might arise due to problems in permissions or settings. Some of the causes are:

- [Access is granted through local groups](#access-is-granted-through-local-groups)
- [Network login disallowed](#network-login-disallowed)
- [Only admins can log in](#only-admins-can-log-in)
- [Service account isn't trusted for delegation](#service-account-isnt-trusted-for-delegation)
- [Local security subsystem errors](#local-security-subsystem-errors)
- [User profile is corrupt](#user-profile-is-corrupt)
- [Credential guard is enabled](#credential-guard-is-enabled)

## Causes specific to NT LAN Manager (NTLM)

This section lists some of the consistent authentication causes related to NTLM.

- [Access is denied for NTLM peer logins](#access-is-denied-for-ntlm-peer-logins)
- [Loopback protection isn't set correctly](#loopback-protection-isnt-set-correctly)
- [Loopback protection fails when you connect to the Always-on listener](#loopback-protection-fails-when-you-connect-to-the-always-on-listener)
- [Double hop scenarios on multiple computers](#double-hop-scenarios-on-multiple-computers)
- [Issue with LANMAN compatibility level](#issue-with-lanman-compatibility-level)

## Causes and scenarios related to Active Directory and Domain Controller

This section lists various causes and scenarios related to directory services and servers and their possible solutions:

- [An account is disabled](#an-account-is-disabled)
- [An account isn't in the group](#an-account-isnt-in-the-group)
- [No permissions for cross-domain groups](#no-permissions-for-cross-domain-groups)
- [Firewall blocks the Domain Controller](#firewall-blocks-the-domain-controller)
- [Domain Controller is offline](#domain-controller-is-offline)
- [Selective authentication is disabled](#selective-authentication-is-disabled)
- [Account migration failed](#account-migration-is-incorrect)
- [Login is from untrusted domain](#login-is-from-an-untrusted-domain)

## Causes and scenarios related to Kerberos authentication

This section lists various causes related to Kerberos authentication.

- [Missing SPN](#missing-spn)
- [Duplicate SPN](#duplicate-spn)
- [Delegating sensitive accounts to other services](#delegating-sensitive-accounts-to-other-services)
- [Service account can't be trusted for delegation](#service-account-isnt-trusted-for-delegation)
- [SPN is associated with a wrong account](#spn-is-associated-with-a-wrong-account)
- [An incorrect DNS suffix is appended to the NetBIOS name](#an-incorrect-dns-suffix-is-appended-to-the-netbios-name)
- [Expired tickets](#expired-tickets)
- [User belongs to many groups](#user-belongs-to-many-groups)
- [Clock skew is too high](#clock-skew-is-too-high)
- [Not a constrained target](#not-a-constrained-target)
- [Disjoint DNS namespace](#disjoint-dns-namespace)
- [NTLM and constrained delegation](#choose-constrained-delegation-instead-of-ntlm)
- [Issue with per-service security identifier (SID) permissions](#issue-with-per-service-security-identifier-sid-permissions)
- [Some legacy providers don't support Kerberos over Named Pipes](#some-legacy-providers-dont-support-kerberos-over-named-pipes)
- [Kernel-mode authentication](#kernel-mode-authentication)
- [Limit delegation rights to Access or Excel](#limit-delegation-rights-to-access-or-excel)
- [Use HTTP host header](#use-http-host-header)
- [HOSTS file is incorrect](#hosts-file-is-incorrect)
- [Delegating to a file share](#assign-permissions-to-a-file-share-without-proper-constraints)
- [Enable HTTP ports on SPNs](#enable-http-ports-on-spns)
- [SQL Alias may not function correctly](#sql-alias-may-not-function-properly)

## Causes related to other aspects

This section lists various miscellaneous authentication issues.

- [Integrated authentication isn't enabled](#integrated-authentication-isnt-enabled)
- [Wrong Internet zone](#wrong-internet-zone)
- [IIS Authentication isn't allowed](#iis-authentication-isnt-allowed)

### Bad password

Refers to the login related issue. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-NT-AUTHORITY-ANONYMOUS-LOGON).

### Invalid username

Refers to the Login related issue. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-NT-AUTHORITY-ANONYMOUS-LOGON).

### SQL logins are not enabled

Refers to the scenario where you try to connect to a Microsoft SQL Server instance using SQL Server authentication but the login associated with the account is disabled. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-NT-AUTHORITY-ANONYMOUS-LOGON).

### Named Pipes connections fail because the user doesn't have permission to log into Windows

Refers to the permissions issue in Windows. For more information, see [Troubleshooting the Named Pipes connections issue in SQL Server](named-pipes-connection-fail-no-windows-permission.md).

### Database is offline

Refers to a scenario where a SQL Server database attempts to reconnect to a SQL Server authentication mode. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-NT-AUTHORITY-ANONYMOUS-LOGON).

### Database permissions

Refers to enabling or restricting access to SQL Server database. For more information, see  [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

### User has not logged in

Refers to the Anonymous Logon Account error. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

### Linked Server Account Mapping

You might encounter an authentication process issue with linked servers in the context of SQL Server. For more information, see [linked servers](linked-server-account-mapping-error.md).

### Proxy account doesn't have permissions

An SSIS job run by SQL Agent might need permissions other than the SQL Agent service account can provide. For more information, see [SSIS package does not run when called from a SQL Server Agent job step.](../../integration-services/ssis-package-doesnt-run-when-called-job-step.md).

### Unable to log in to SQL Server database

The inability to log in can cause failures in authentication. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

### Metadata of the linked server is inconsistent

Refers to a scenario where metadata of the linked server is inconsistent or doesn't match the expected metadata.

A view or stored procedure queries tables or views in the linked server but receives login failures whereas a distributed `SELECT` statement copied from them doesn't. This issue might happen if the View was created and then the linked server was recreated, or a remote table was modified without rebuilding the View. To resolve this issue, you can refresh the metadata of the linked server by running the `sp_refreshview` stored procedure.

### Bad server name in connection string

This issue might occur if the specified server name is incorrect or can't be found. For more information, see [bad server name in connection string](bad-server-name-connection-string-error.md).

### Wrong database name in connection string

This issue occurs if the database name provided for authentication is incorrect. Check if the name is spelled correctly. For more information, see [MSSQLSERVER_4064](/sql/relational-databases/errors-events/mssqlserver-4064-database-engine-error).

### Wrong explicit SPN account

This issue might occur if the SPN is associated with the wrong account in AD. For more information on these scenarios, see [Cannot generate SSPI context error](cannot-generate-sspi-context-error.md).

### Explicit SPN is missing

This issue occurs when the SPN isn't configured or registered correctly. For more information, see ["Cannot generate SSPI context" error when using Windows authentication to connect SQL Server.](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

### Explicit misplaced SPN

This issue occurs when the SPN is associated with the wrong account in AD. For more information, [Explicit misplaced SPN](explicit-spn-is-misplaced.md).

### Explicit SPN is duplicated

This issue occurs when an SPN is duplicated that's registered more than once. For more information, see ["Cannot generate SSPI context" error when using Windows authentication to connect SQL Server.](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

### Access is granted through local groups

If the user doesn't belong to a local group that's used to grant access to the server, the provider displays the "Login failed for user 'contoso/user1'" error message. The DBA can double-check this by looking at the Security or Logins in SSMS. If it's a contained database, check under `databasename`. For more information, see [Login failed for user '\<username\>' or login failed for user '\<domain\>\\<username\>'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

### Network login disallowed

This scenario occurs when you attempt to log in to a network but your login request is denied for certain reasons. For more information, see [Troubleshooting the network login](network-login-disallowed.md) issue.

### Only admins can log in

This issue occurs if the security log on a computer is full and doesn't have space to fill events. The security feature **[CrashOnAuditFail](/previous-versions/windows/it-pro/windows-2000-server/cc963220(v=technet.10))** is used by system administrators to check all security events. The valid values for `CrashOnAuditFail` are *0*, *1*, and *2*. If the key for `CrashOnAuditFail` is set to *2*, it means that the security event log is full and the "Only Admins can login" error message is shown.

To resolve this issue, follow these steps:

 1. Start the Registry editor.
 1. Locate the following key, and then check whether the value of the key `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa!crashonauditfail` is set to *2*. This indicates that the security event log requires manual clearing.
 1. Set the value to *0* and then reboot the server. You might also want to change the security event log to allow events to roll over. For more information about how the setting affects all services such as SQL, IIS, file share, and login, see [Users cannot access Web sites when the security event log is full](../../../developer/webapps/iis/general/users-cannot-access-web-sites-when-log-full.md).

> [!NOTE]
> This only affects integrated logins. A Named Pipe connection will also be affected with a SQL Login because Named Pipes first logs into Windows Admin Pipe before connecting to SQL Server.

### Service account isn't trusted for delegation

This type of issue usually occurs when a service account is not allowed to assign credentials to other servers. This can affect services that require delegation. If a delegation scenario isn't enabled, check the SQL Server *secpol.msc* to see if the SQL Server service account is listed under **Local Policies -> User Rights Assignment -> Impersonate a client after authentication** security policy settings. For more information, see [Enable computer and user accounts to be trusted for delegation](/windows/security/threat-protection/security-policy-settings/enable-computer-and-user-accounts-to-be-trusted-for-delegation).

### Local security subsystem errors

Refers to a consistent authentication issue related to the unresponsive LSASS. For more information, see [Troubleshoot LSASS errors with SQL Server authentication](local-security-subsystem-errors.md).

### User profile is corrupt

Refers to the Windows user profile issue. For more information, see troubleshooting the [Windows user profile issue](corrupt-user-profile.md).

### Credential guard is enabled

This scenario indicates that the Credential Guard feature is enabled on a Windows system and is used to create a secure environment to store sensitive information. However, in certain situations, this feature might lead to authentication issues. For more information, see [Considerations and known issues when using Credential Guard](/windows/security/identity-protection/credential-guard/considerations-known-issues).

### Access is denied for NTLM peer logins

When communicating between computers that are either in workstations or in domains that don't trust each other, you can set up identical accounts on both machines and use NTLM peer authentication. Logins only work if both the user account and the password match on both machines. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

### Loopback protection isn't set correctly

Loopback protect is designed to prohibit applications from calling other services on the same machine. If loopback protect isn't configured correctly or if there's any malfunction, it can indirectly cause authentication issues. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

### Loopback protection fails when you connect to the Always-on listener

This issue is related to loopback protection. When connecting to the Always-On Listener from the primary node, the connection uses NTLM authentication. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

### Double hop scenarios on multiple computers

Performing a double-hop will fail if NTLM credentials are used. Kerberos credentials are required. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

### Issue with LANMAN compatibility level

The LAN Manager (LANMAN) authentication issue usually occurs if there is a mismatch in the authentication protocols used by older (pre Windows 2008) and newer computers. When you set the compatibility level to 5, NTLMv2 isn't allowed. Switching to Kerberos avoids this issue as Kerberos is more secure. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

### An account is disabled

You might experience this scenario if the user account was disabled by an administrator or by a user. In such a case, you can't login with this account or start a service with it. This might lead to consistent authentication issues because it can prevent you from accessing resources or performing actions that require authentication.

### An account isn't in the group

This issue might happen if a user is trying to access a resource that's restricted to a specific group. Check the SQL logins to enumerate allowed groups and make sure the user belongs to one of them.

### No permissions for cross-domain groups

Users from the [remote domain should belong to a group](../../../windows-server/windows-security/trust-between-windows-ad-domain-not-work-correctly.md) in the SQL Server domain. There might be a problem if you attempt to use a domain local group to connect to a SQL Server instance from another domain. If the domains lack proper trust, adding the users in a group in the remote domain might prevent the SQL Server from enumerating the group's membership.

### Firewall blocks the Domain Controller

You might encounter issues when managing the user's access to resources. Make sure the DC is accessible from the client or the SQL Server using the `nltest /SC_QUERY:CONTOSO` command.

### Domain Controller is offline

Use the `nltest` command to force the computer to switch to another DC. For more information, see [Active Directory replication Event ID 2087: DNS lookup failure caused replication to fail](../../../windows-server/identity/active-directory-replication-event-id-2087.md).

### Selective authentication is disabled

Selective authentication is a feature of domain trusts that allows the domain administrator to limit which users have access to resources in the remote domain. If selective authentication isn't enabled, all users in the trusted domain can get access to the remote domain. To resolve this issue, make sure the users aren't allowed to authenticate in the remote domain by enabling selective authentication.

### Account migration is incorrect

If old user accounts can't connect to the SQL Server, but newly created accounts can, this could happen if account migration isn't correct. This issue is related to AD. For more information, see [Transfer logins and passwords between instances of SQL Server](../security/transfer-logins-passwords-between-instances.md).

### Login is from an untrusted domain

This issue is related to the trust level between domains. You might see the following error message "Login failed. The login is from an untrusted domain and cannot be used with Windows authentication. (18452)."

 Error 18452 indicates that the login uses Windows Authentication but the login is an unrecognized Windows principal. An unrecognized Windows principal indicates that the login can't be verified by Windows. This could be because the Windows login is from an untrusted domain. The trust level between domains might cause failures in account authentication or the visibility of Service Provider Name (SPN)s. To resolve this error, follow these steps:

 1. List SPNs for the service account using the `- setspn -l` command.
 1. [Register the SPNs](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc731241(v=ws.11)) if required using the `- setspn -s` link.
 1. Test authentication with the `- runas /user:<Username> "cmd"` command.

### Missing SPN

This scenario might happen when an SPN related to a SQL Sever instance is absent. For more information, see [Fix the error with Kerberos Configuration Manager (Recommended)](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

### SPN is associated with a wrong account

This issue might occur if an SPN is associated with the wrong account in AD. For more information, see [Fix the error with Kerberos Configuration Manager (Recommended)](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

You might receive an error message if your SPN is configured on the wrong account in Active Directory. To resolve the error, follow these steps:

1. Use `SETSPN -Q spnName` to locate the SPN and its current account.
1. Use `SETSPN -D` to delete the existing SPNs.
1. Use the `SETSPN -S` to migrate it to the correct account.

### Duplicate SPN

This scenario refers to a situation where two or more SPNs are identical within a domain. SPNs are used to uniquely identify services running on servers in a Windows domain. There can be authentication issues when duplicates occur. For more information, see [Fix the error with Kerberos Configuration Manager (Recommended)](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

### Delegating sensitive accounts to other services

Some accounts may be marked as Sensitive in AD. These accounts can't be delegated to another service in a double-hop scenario. Sensitive accounts are critical to providing security but can impact authentication. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

### Service account can't be trusted for delegation

In a double-hop scenario, the service account of the mid-tier service must be trusted for delegation in AD. If the service account isn't trusted for delegation, Kereberos authentication can fail. If you're an administrator, enable the **Trusted for delegation** option.

### An incorrect DNS suffix is appended to the NetBIOS name

This can happen when you just use the NetBIOS name, example SQLPROD01, rather than the fully qualified domain (FQDN) name, example SQLPROD01.CONTOSO.COM. When this is done, the wrong DNS suffix might be appended. Check the network settings for the default suffixes and make sure they're correct or use the FQDN to avoid issues.

### User belongs to many groups

When a user belongs to multiple groups, there can be authentication issues in Kerberos. If you use Kerberos over UDP, the entire security token must fit within a single packet. Users that belong to many groups have a larger security token than users who belong to fewer groups. If you use Kerberos over TCP, you can increase the [`MaxTokenSize`] setting. For more information, see [MaxTokenSize and Kerberos Token Bloat](/archive/blogs/shanecothran/maxtokensize-and-kerberos-token-bloat).

### Expired tickets

Refers to Kerberos tickets. Using expired Kerberos tickets can cause issues in authentication. For more information, see [Expired tickets](expired-tickets-issue.md).

### Clock skew is too high

Refers to a scenario when clocks on more than one device on a network aren't synchronized. For Kerberos server to work, the clocks between machines can't be turned off for more than five minutes.

### Not a constrained target

If constrained delegation is enabled for a particular service account, Kerberos will fail if the target server's SPN isn't on the list of targets of constrained delegation.

### Disjoint DNS namespace

Refers to a consistent authentication issue that might arise when the DNS suffix doesn't match between the domain member and DNS. You might experience authentication issues if you use a disjoint namespace. If the organizational hierarchy in Active Directory (AD) and in DNS don't match, the wrong Service Provider Name (SPN) might be generated if you use the NETBIOS name in the database application connection string. The SPN won't be found and NTLM credentials are used instead of Kerberos credentials. Use the fully qualified domain name (FQDN) of the server or specify the SPN name in the connection string to mitigate problems. For information on FQDN, see [Computer Naming](/windows-server/identity/ad-ds/plan/computer-naming).

### Choose constrained delegation instead of NTLM

If the target is a file share, the delegation type of the mid-tier service account must be **Constrained-Any** and not **Constrained-Kerberos**. If the delegation type is set to **Constrained-Kerberos**, the mid-tier account can only allocate to specific services whereas the other option allows the service account to delegate to any service. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

### Issue with per-service security identifier (SID) permissions

Per-service-SID is a security feature of SQL Server that limits local connections to use New Technology LAN Manager (NTLM) and not Kerberos as the authentication method. The service can make a single hop to another server using NTLM credentials, but it can't be delegated further without using the constrained delegation. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

### Some legacy providers don't support Kerberos over Named Pipes

The legacy OLE DB Provider (SQLOLEDB) and ODBC Driver (SQL Server) that come with Windows don't support Kerberos over Named Pipes, only NTLM. Use a TCP connection to allow Kerberos.

### Kernel-mode authentication

The SPN on the App Pool account is normally required for web servers; however, when using Kernel-mode authentication, the computer's HOST SPN is used for authentication, which takes place in the kernel. This setting might be used if the server hosts many different websites using the same host header URL, different App Pool accounts, and [Windows Authentication](/iis/configuration/system.webserver/security/authentication/).

### Limit delegation rights to Access or Excel

The Joint Engine Technology (JET) and Access Connectivity Engine (ACE) providers are similar to any of the file systems. You must use constrained delegation to allow SQL Server to read files located on another machine. In general, the ACE provider shouldn't be used in a linked server as this is explicitly not supported. The JET provider is deprecated and is available on 32-bit machines only.

### Use HTTP host header

If the website has a host header name, the HOSTS SPN can't be used. An explicit HTTP SPN must be used. If the web site doesn't have a host header name, NTLM is used and it can't be delegated to a backend SQL Server or other service.

### HOSTS file is incorrect

The HOSTS file overrides DNS lookups and might generate an unexpected SPN name. This causes NTLM credentials to be used. If an unexpected IP address is in the HOSTS file, the SPN generated might not match the backend pointed to.

### Assign permissions to a file share without proper constraints

Refers to an instance in which a user or application delegates its credentials to access a file share. Without proper constraints, delegating credentials to a file share might lead to security risks. To resolve this kind of an issue, make sure to use constrained delegation.

### Enable HTTP ports on SPNs

Normally, HTTP SPNs don't use port numbers, example `http/web01.contoso.com`, but you can enable this through the policy on the clients. The SPN would then have to be in the `http/web01.contoso.com:88` format, to enable Kerberos to function correctly. Otherwise, NTLM credentials are used, which aren't recommended because it would be difficult to diagnose the issue and it might be an excessive administrative overhead.

### SQL Alias may not function properly

A SQL Server alias may cause an unexpected SPN to be generated. This results in NTLM credentials if the SPN isn't found, or an SSPI failure, if it inadvertently matches the SPN of another server.

### Integrated authentication isn't enabled

This might be related to the integrated authentication issues. To resolve this type of error, make sure that the **Integrated Windows Authentication** is enabled in the **Internet Options**.

### Wrong Internet zone

This might happen if you try to access a web site that isn't in the correct Internet zone in IE. The credentials won't work if the web site is in the Local Intranet zone.

### IIS Authentication isn't allowed

Configure the web site to allow Windows Authentication and set the `<identity impersonate="true"/>` value in the *web.config* file.
