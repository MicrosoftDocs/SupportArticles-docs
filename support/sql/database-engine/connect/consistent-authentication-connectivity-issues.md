---
title: Introduction to consistent authentication issues
description: This article introduces to consistent authentication issues, the types of error messages, and workarounds to troubleshoot various issues.
ms.date: 01/31/2024
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

- [Issues specific to various aspects of SQL Server]#issues-specific-to-various-aspects-of-sql-server)

- [Issues related to Connection String](#issues-related-to-connection-string)

- [Issues related to Windows permissions or Policy settings](#issues-related-to-active-directory-and-domain-controller)

- [Issues related to Active Directory and Domain Controller](#issues-related-to-kerberos-authentication)

- [Issues related to other aspects](#issues-related-to-other-aspects)

## Prerequisites

Before you start troubleshooting, check the [prerequisites](../connect/resolve-connectivity-errors-checklist.md) and go through the checklist.

- Make sure to install the WIRESHARK and Problem Steps Recorder (PSR.EXE) utilities. For more information, see *Methods of collecting data for troubleshooting various types of errors*.

- Collect the Service Provider Name (SPN) information based on the service accounts by using the `SETSPN -L` command.

## Errors

This section describes the types of errors and its related information.

### Directory services errors

If the SQL Server error log file contains both or either of the following messages, then this error is related to Active Directory (AD). This error might occur if the domain controller (DC) can't be contacted by Windows on the SQL Server computer or the local security service (LSASS) is having an issue.

  ```output
   Error -2146893039 (0x80090311): No authority could be contacted for authentication.
   Error -2146893052 (0x80090304): The Local Security Authority cannot be contacted.
  ```

### Login failed errors

When you are troubleshooting the "Login Failed" error message, the SQL Server error log file can provide more information in the [SQL state value](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#additional-error-information) with error 18456 (Login Failed). You can try to fix the issue according to the description of the state value.

This section lists the possible error messages and their possible causes.

|Error message  |More information  |
|---------|---------|
|"Login failed for user '\<username\>'. Reason: Password did not match that for the login provided."|This error might occur if a bad password is used. For more information, see [Login failed for user '\<username\>' or login failed for user '\<domain>\<username>'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).|
|"SQL Server does not exist or access denied."  | [Named Pipes connections](named-pipes-connection-fail-no-windows-permission.md) fail because the user doesn't have permission to log into Windows.     |
|"Cannot open database \<test\> requested by the login. The login failed."|The database might be offline, or the permissions might not be sufficient. For more information, see [Database offline in MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).<br/> Also, check if the database name in the connection string is correct.|
|"A transport-level error has occurred when sending the request to the server."|Check if the [linked server account mapping](linked-server-account-mapping-error.md) is correct. For more information, see [sp_addlinkedsrvlogin](/sql/relational-databases/system-stored-procedures/sp-addlinkedsrvlogin-transact-sql).|
|SSPI (Security Support Provider Interface) Context.|Check if the [SPN is on the wrong account](cannot-generate-sspi-context-error.md).|
|"Login failed for user \<username\>." | This error can occur if the [proxy account](../../integration-services/ssis-package-doesnt-run-when-called-job-step.md) isn't properly authenticated.    |
|"Login Failed for user: 'NT AUTHORITY\ANONYMOUS LOGON'"|This error might occur if the [SPN is missing, SPN is duplicated, or the SPN is on the wrong account](cannot-generate-sspi-context-error.md).|
|"Login failed for user \<username\>." </br> "Login failed for user '\<database\username\>"</br>    | Check if there's a [bad server name in connection string](bad-server-name-connection-string-error.md). Also, check if the user doesn't belong to a local group used to grant access to the server. For more causes, see [NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).    |
|"Cannot generate SSPI context" | The explicit SPN account might be [wrong](wrong-explicit-spn-account-connection-string.md), missing, or misplaced. |
|"The user account is not allowed the Network Login type"|You might not be able to [log in to the network](network-login-disallowed.md).|
|"The login is from an untrusted domain and cannot be used with Windows authentication."|This error might be related to the [Local Security Subsystem](local-security-subsystem-issues.md) issues.|

## Causes

The consistent authentication errors have several causes and they are listed in the next few sections.

## Causes specific to various aspects of SQL Server

This section lists various causes that are related to aspects such as database, logon account permissions, and linked servers.

- Database is offline: For detailed information regarding the issue, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).
- Database permissions: For detailed information regarding the issue, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).
- Linked Server Account Mapping: For more information, see [linked servers](linked-server-account-mapping-error.md).
- |Proxy account doesn't have permissions: An SSIS job run by SQL Agent might need permissions other than the SQL Agent service account can provide. For more information, see [SSIS package does not run when called from a SQL Server Agent job step.](../../integration-services/ssis-package-doesnt-run-when-called-job-step.md).
- No Login: For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).
- Inconsistent metadata: Refers to a scenario where metadata of the linked server is inconsistent or doesn't match the expected metadata. A view or stored procedure receives login failures on a linked server whereas a distributed `SELECT` statement copied from them doesn't. This situation can happen if the View was created and then the linked server was recreated, or a remote table was modified without rebuilding the View. To resolve this issue, you can refresh the metadata of the linked server by running the `sp_refreshview` stored procedure.

## Issues related to connection string

This section lists various causes related to connection string.

- Bad server name in connection string: This scenario might occur if the specified server name is incorrect or can't be found. For more information, see [bad server name in connection string](bad-server-name-connection-string-error.md).

- Invalid username: For more information, see [Login failed for user '\<username\>' or login failed for user '\<domain>\<username\>'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

- Wrong database name in connection string: This issue might occur if the [database name is incorrect](wrong-database-name-in-connection-string.md). Check if the name is spelled correctly.

- Wrong explicit SPN account: For more information on these scenarios, see [Cannot generate SSPI context error](cannot-generate-sspi-context-error.md).

- Explicit SPN is missing: For more information, see ["Cannot generate SSPI context" error when using Windows authentication to connect SQL Server.](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

- Explicit misplaced SPN: For more information, [Explicit misplaced SPN](explicit-spn-is-misplaced.md).

- Explicit SPN is duplicated: For more information, see ["Cannot generate SSPI context" error when using Windows authentication to connect SQL Server.](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

### Causes related to Windows permissions or Policy settings

This section lists various issues that might arise due to problems in permissions or settings. Some of the causes are:

- Access via group: If the user doesn't belong to a local group that's used to grant access to the server, the provider displays the "Login failed for user 'contoso/user1'" error message. The DBA can double-check this by looking at the Security or Logins in SSMS. If it's a contained database, check under `databasename`. For more information, see [Login failed for user '\<username\>' or login failed for user '\<domain\>\\<username\>'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

- Network login disallowed: For more information, see [Troubleshooting the network login](network-login-disallowed.md) issue.

- Only admins can log in: This issue occurs if the security log on a computer if full and doesn't have space to fill events. The security feature **[CrashOnAuditFail](/previous-versions/windows/it-pro/windows-2000-server/cc963220(v=technet.10))** is used by system administrators to check all security events. The valid values for `CrashOnAuditFail` are *0*, *1*, and *2*. If the key is set to *2*, it means that the security event log is full and the "Only Admins can login" error message is shown. To resolve this issue, follow these steps:

 1. Start the Registry editor.
 1. Locate the following key, and then check whether the value of the key `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa!crashonauditfail` is set to *2*. This indicates that the security event log requires manual clearing.
 1. Set the value to *0* and then reboot the server. You might also want to change the security event log to allow events to roll over. For more information about how the setting affects all services such as SQL, IIS, file share, and login, see [Users cannot access Web sites when the security event log is full](../../../developer/webapps/iis/general/users-cannot-access-web-sites-when-log-full.md).

> [!NOTE]
> This only affects integrated logins. A Named Pipe connection will also be affected with a SQL Login because Named Pipes first logs into Windows Admin Pipe before connecting to SQL Server.

- Service account isn't trusted for delegation: This type of issue usually occurs when a service account is not allowed to assign credentials to other servers. This can affect services that require delegation. If a delegation scenario isn't enabled, check the SQL Server *secpol.msc* to see if the SQL Server service account is listed under **Local Policies -> User Rights Assignment -> Impersonate a client after authentication** security policy settings. For more information, see [Enable computer and user accounts to be trusted for delegation](/windows/security/threat-protection/security-policy-settings/enable-computer-and-user-accounts-to-be-trusted-for-delegation).

- Local security subsystem issues: Refers to a consistent authentication issue related to the unresponsive LSASS. For more information, see [Troubleshooting LSASS errors](local-security-subsystem-errors.md).

- Corrupt User Profile: Refers to the Windows user profile issue. For more information, see Troubleshooting the [Windows user profile issue](corrupt-user-profile.md).

- Credential guard is enabled: For more information, see [Considerations and known issues when using Credential Guard](/windows/security/identity-protection/credential-guard/considerations-known-issues).

### Issues specific to NT LAN Manager (NTLM)

This section lists some of the consistent authentication causes related to NTLM.

- NTLM Peer Login: When communicating between computers that are either in workstations or in domains that don't trust each other, you can set up identical accounts on both machines and use NTLM peer authentication. Logins only work if both the user account and the password match on both machines. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

- Loopback protection: Loopback protect is designed to prohibit applications from calling other services on the same machine. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

- Always-On Listener loopback protection: When connecting to the Always-On Listener from the Pprimary node, the connection will be NTLM. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

- Double hop scenarios on multiple computers: For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

- LANMAN compatibility level: Refers to a security policy setting. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

### Issues related to Active Directory and Domain Controller

This section lists various causes related to access to directory services and servers and their possible solutions:

- An account is disabled: You might experience this scenario if the user account was disabled by an administrator or by a user. In such a case, you can't login with this account or start a service with it.

- An account isn't in the group: You can access the database using groups rather than individually. Check the SQL logins to enumerate allowed groups and make sure the user belongs to one of them.    |

- No permissions for cross-domain groups: Users from the [remote domain should belong to a group](../../../windows-server/windows-security/trust-between-windows-ad-domain-not-work-correctly.md) in the SQL Server domain. If the domains lack proper trust, adding the users in a group in the remote domain might prevent the SQL Server from enumerating the group's membership.

- Firewall blocks the DC: Make sure the DC is accessible from the client or the SQL Server using the `nltest /SC_QUERY:CONTOSO` command.

- Domain Controller is offline: Use NLTEST to force the computer to switch to another DC. See [Active Directory replication Event ID 2087: DNS lookup failure caused replication to fail](../../../windows-server/identity/active-directory-replication-event-id-2087.md).

- Selective authentication is disabled: Is a feature of domain trusts that allows the domain administrator to limit which users have access to resources in the remote domain. If selective authentication isn't enabled, all users in the trusted domain can get access to the remote domain. To resolve this issue, make sure the users aren't allowed to authenticate in the remote domain by enabling selective authentication.

- Account migration failed: If old user accounts can't connect to the SQL Server, but newly created accounts can, this could happen if account migration isn't correct. This issue is related to AD.  For more information, see [Transfer logins and passwords between instances of SQL Server](../security/transfer-logins-passwords-between-instances.md).

- Login is from untrusted domain: This issue is related to the trust level between domains. You might see the following error message "Login failed. The login is from an untrusted domain and cannot be used with Windows authentication. (18452)."

 Error 18452 indicates that the login uses Windows Authentication but the login is an unrecognized Windows principal. An unrecognized Windows principal indicates that the login can't be verified by Windows. This could be because the Windows login is from an untrusted domain. The trust level between domains might cause failures in account authentication or the visibility of Service Provider Name (SPN)s. To resolve this error, follow these steps:

 1. List SPNs for the service account using the `- setspn -l` command.
 1. [Register the SPNs](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc731241(v=ws.11)) if required using the `- setspn -s` link.
 1. Test authentication with the `- runas /user:<Username> "cmd"` command.

## Issues related to Kerberos authentication

The following table contains information about causes related to Kerberos authentication:

|Possible causes |More information  |
|---------|---------|
|Missing SPN | For more information, see [Fix the error with Kerberos Configuration Manager (Recommended)](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).  |
|SPN on wrong account  | For more information, see [Fix the error with Kerberos Configuration Manager (Recommended)](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).   |
|Duplicate SPN  | For more information, see [Fix the error with Kerberos Configuration Manager (Recommended)](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).    |
|Sensitive account  | For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).   |
|Not trusted for delegation | In a double-hop scenario, the service account of the mid-tier service must be trusted for Delegation in Active Directory. If you're an administrator, enable the **Trusted for delegation** option. |
|SPN on wrong account|You might receive this error message if your SPN is configured on the wrong account in Active Directory. To resolve this error, follow these steps: <br/> 1. Use `SETSPN -Q spnName` to locate the SPN and its current account.<br/> 2. Use `SETSPN -D` to delete the existing SPNs.<br/> 3. Use the `SETSPN -S` to migrate it to the correct account.|
|An incorrect DNS suffix is appended to the NetBIOS name | This can happen when you just use the NetBIOS name, example SQLPROD01, rather than the fully qualified domain (FQDN) name, example SQLPROD01.CONTOSO.COM, the wrong DNS suffix might be appended. Check the network settings for the default suffixes and make sure they're correct or use the FQDN to avoid issues.|
|User belongs to many groups  | If you use Kerberos over UDP, the entire security token must fit within a single packet. Users that belong to many groups have a larger security token than users who belong to fewer groups. If you use Kerberos over TCP, you can increase the [`MaxTokenSize`] setting. For more information, see [MaxTokenSize and Kerberos Token Bloat](/archive/blogs/shanecothran/maxtokensize-and-kerberos-token-bloat).  |
|Clock skew   | Refers to a consistent authentication issue when clocks on more than one device on a network aren't synchronized. For Kerberos server to work, the clocks between machines can't be turned off for more than five minutes.   |
|Not a constrained target | If constrained delegation is enabled for a particular service account, Kerberos will fail if the target server's SPN is not on the list of targets of constrained delegation. |
|NETBIOS name | Use of the NETBIOS name, example SQLPROD01, rather than the fully qualified domain name, example SQLPROD01.CONTOSO.COM, might result in the wrong DNS suffix being appended. Check the network settings for the default suffixes and make sure they are correct or use the fully qualified name to avoid issues. |
|Disjoint DNS namespace| Refers to a consistent authentication issue that might arise when the DNS suffix doesn't match between the domain member and DNS. You might experience authentication issues if you use a disjoint namespace. If the organizational hierarchy in Active Directory (AD) and in DNS don't match, the wrong Service Provider Name (SPN) might be generated if you use the NETBIOS name in the database application connection string. The SPN won't be found and NTLM credentials are used instead of Kerberos credentials. Use the fully qualified domain name (FQDN) of the server or specify the SPN name in the connection string to mitigate problems. For information on FQDN, see [Computer Naming](/windows-server/identity/ad-ds/plan/computer-naming).|
|NTLM and constrained delegation | If the target is a file share, the delegation type of the mid-tier service account must be **Constrained-Any** and not **Constrained-Kerberos**. If the delegation type is set to **Constrained-Kerberos**, the mid-tier account can only allocate to specific services whereas the other option allows the service account to delegate to any service. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).     |
|Issue with per-service security identifier (SID) permissions  | Per-service-SID is a security feature of SQL Server that limits local connections to use New Technology LAN Manager (NTLM) and not Kerberos as the authentication method. The service can make a single hop to another server using NTLM credentials, but it can't be delegated further without using the constrained delegation. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).  |
|Legacy providers and named pipes  | The legacy OLE DB Provider (SQLOLEDB) and ODBC Driver {SQL Server} that come with Windows don't support Kerberos over Named Pipes, only NTLM. Use a TCP connection to allow Kerberos.      |
|Kernel-mode authentication | The SPN on the App Pool account is normally required for web servers; however, when using Kernel-mode authentication, the computer's HOST SPN is used for authentication, which takes place in the kernel. This setting might be used if the server hosts many different websites using the same host header URL, different App Pool accounts, and [Windows Authentication](/iis/configuration/system.webserver/security/authentication/).  |
|Delegating credentials to Access or Excel   | The Joint Engine Technology (JET) and Access Connectivity Engine (ACE) providers are similar to any of the file systems. You must use constrained delegation to allow SQL Server to read files located on another machine. In general, the ACE provider shouldn't be used in a linked server as this is explicitly not supported. The JET provider is deprecated and is available on 32-bit machines only. |
|Web site host header  | If the website has a host header name, the HOSTS SPN can't be used. An explicit HTTP SPN must be used. If the web site doesn't have a host header name, NTLM is used and it can't be delegated to a backend SQL Server or other service.   |
|HOSTS file   | The Hosts file overrides DNS lookups and might generate an unexpected SPN name. This  causes NTLM credentials to be used. If an unexpected IP address is in the Hosts file, the SPN generated might not match the backend pointed to.        |
|Delegating to a file share   | Make sure to use constrained delegation.       |
|HTTP Ports   | Normally, HTTP SPNs don't use port numbers, example `http/web01.contoso.com`, but you can enable this through the policy on the clients. The SPN would then have to be in the `http/web01.contoso.com:88` format, to enable Kerberos to function correctly. Otherwise, NTLM credentials are used, which aren't recommended because it would be difficult to diagnose the issue and it might be an excessive administrative overhead.   |
|SQL Alias|A SQL Server alias may cause an unexpected SPN to be generated. This results in NTLM credentials if the SPN isn't found, or an SSPI failure, if it inadvertently matches the SPN of another server. |

## Issues related to other aspects

The following table contains the possible cause and related information about various other issues:

|Possible cause  |More information  |
|---------|---------|
|Integrated authentication isn't enabled     | This might be related to the integrated authentication issues. To resolve this type of error, make sure that the **Integrated Windows Authentication** is enabled in the **Internet Options**.     |
|Wrong Internet zone   | This might happen if you try to access a web site that isn't in the correct Internet zone in IE. The credentials won't work if the web site is in the Local Intranet zone.      |
|IIS Authentication is not allowed   | Configure the web site to allow Windows Authentication and set the `<identity impersonate="true"/>` value in the *web.config* file.        |
|Service account not trusted for delegation |  If a delegation scenario isn't enabled, check the SQL Server *secpol.msc* to see if the SQL Server service account is listed under **Local Policies -> User Rights Assignment -> Impersonate a client after authentication** security policy settings. For more information, see [How to Configure the Server to be Trusted for Delegation - Microsoft Desktop Optimization Pack](/microsoft-desktop-optimization-pack/appv-v4/how-to-configure-the-server-to-be-trusted-for-delegation). |
