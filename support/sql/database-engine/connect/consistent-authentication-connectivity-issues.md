---
title: Introduction to consistent authentication issues
description: This article introduces to consistent authentication issues, the types of error messages, and workarounds to troubleshoot various issues.
ms.date: 01/19/2024
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

Before you start to troubleshoot errors, it's important to understand what each error means and also what is the type of error. Some errors might appear in more than one category. You can use the troubleshooting information mentioned in the [Errors](#errors) section to resolve the error. If you still encounter issues, check the possible causes and solutions or workarounds in the other sections such as [Issues specific to various aspects of SQL Server](#issues-specific-to-various-aspects-of-sql-server), [Issues related to Connection String](#issues-related-to-connection-string), [Issues related to Windows permissions or Policy settings](#issues-related-to-active-directory-and-domain-controller), [Issues related to Active Directory and Domain Controller](#issues-related-to-kerberos-authentication), and [Issues related to other aspects](#issues-related-to-other-aspects).

## Prerequisites

Before you start troubleshooting, check the [prerequisites](../connect/resolve-connectivity-errors-checklist.md) and go through the checklist.

- Make sure to install the WIRESHARK and Problem Steps Recorder (PSR.EXE) utilities. For more information, see *Methods of collecting data for troubleshooting various types of errors*.

- Collect the Service Provider Name (SPN) information based on the service accounts by using the `SETSPN -L` command.

## Errors

This section describes the types of errors and its related information.

### Directory services specific errors

Refers to the Active Directory (AD) errors. If the SQL Server error log file contains both or either of the following messages, then this error is related to Active Directory (AD). This error might occur if the domain controller (DC) can't be contacted by Windows on the SQL Server computer or the local security service (LSASS) is having an issue.

  ```output
   Error -2146893039 (0x80090311): No authority could be contacted for authentication.
   Error -2146893052 (0x80090304): The Local Security Authority cannot be contacted.
  ```

### Login failed specific errors

When you are troubleshooting the "Login Failed" error message, the SQL Server error log file can provide more information in the SQL state value with error 18456 (Login Failed). For more information, see [Login failed error codes](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#additional-error-information).

This section lists the possible error messages and their possible causes.

|Error message  |More information  |
|---------|---------|
|"Login failed for user '\<username\>'. Reason: Password did not match that for the login provided."|This error might occur if a bad password is used. For more information, see [Login failed for user '\<username\>' or login failed for user '\<domain>\<username>'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).|
|"SQL Server does not exist or access denied."  | [Named Pipes connections](named-pipes-connection-fail-no-windows-permission.md) fail because the user doesn't have permission to log into Windows.     |
|"Cannot open database "test" requested by the login. The login failed."|The database might be offline, or the permissions might not be sufficient. For more information, see [Database offline in MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).|
|"A transport-level error has occurred when sending the request to the server."|Check if the [linked server account mapping](linked-server-account-mapping-error.md) is correct. For more information, see [sp_addlinkedsrvlogin](/sql/relational-databases/system-stored-procedures/sp-addlinkedsrvlogin-transact-sql).|
|"SSPI (Security Support Provider Interface) Context."|Check if the [SPN is on the wrong account](cannot-generate-sspi-context-error.md).|
|"Login failed for user 'username'." | This error can occur if the [proxy account](../../integration-services/ssis-package-doesnt-run-when-called-job-step.md) isn't properly authenticated.    |
|"Login Failed for user: 'NT AUTHORITY\ANONYMOUS LOGON'"|This error might occur if the [SPN is missing, SPN is duplicated, or the SPN is on the wrong account](cannot-generate-sspi-context-error.md).|
|"Login failed for user 'username'." </br> "Login failed for user '\<database\username\>"</br>    | Check if there's a [bad server name in connection string](bad-server-name-connection-string-error.md). Also, check if the user doesn't belong to a local group used to grant access to the server. For more causes, see [NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).    |
|"Cannot open database "\<database name\>" requested by the login. The login failed."|Check if the database name in the connection string is correct.|
|"Cannot generate SSPI context"|The explicit SPN account might be [wrong](wrong-explicit-spn-account-connection-string.md), missing, or misplaced. |
|"The user account is not allowed the Network Login type"|You might not be able to [log in to the network](network-login-disallowed.md).|
|"The login is from an untrusted domain and cannot be used with Windows authentication."|This error might be related to the [Local Security Subsystem](local-security-subsystem-issues.md) issues.|

For detailed information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

## Issues specific to various aspects of SQL Server

The following table lists some scenarios that are related to aspects such as database, logon account permissions, and linked servers.

|Possible cause  |More information  |
|---------|---------|
|Database is offline   | For detailed information regarding the error, see [Login failed specific errors](#login-failed-specific-errors).           |
|Linked Server Account Mapping|This scenario is related to [linked servers](linked-server-account-mapping-error.md).|
|Database permissions     | In this case, the database won't appear offline in the SQL Server Management Studio, and other users, for example, the DBA will be able to connect to it. For detailed information, see [Login failed for user '\<username\>' or login failed for user '\<domain>\<username\>'.](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).    |
|Proxy account     |  An SSIS job run by SQL Agent might need permissions other than the SQL Agent service account can provide. For more information, see [SSIS package does not run when called from a SQL Server Agent job step.](../../integration-services/ssis-package-doesnt-run-when-called-job-step.md)  |
|Bad metadata     | A view or stored procedure receives login failures on a linked server whereas a distributed `SELECT` statement copied from them doesn't. This situation can happen if the View was created and then the linked server was recreated, or a remote table was modified without rebuilding the View.  |

## Issues related to connection string

The following sections provide various issues related to connection string.

|Possible cause  |More information  |
|---------|---------|
|Bad server name in connection string     |This scenario might occur if the specified server name is incorrect or can't be found. For more information, see [bad server name in connection string](bad-server-name-connection-string-error.md).         |
|Invalid username     |For more information, see [Login failed for user '\<username\>' or login failed for user '\<domain>\<username\>'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).         |
|Wrong database name in connection string     | This scenario might occur if the [database name is incorrect](wrong-database-name-in-connection-string.md). Check if it is spelled correctly.        |
|Wrong explicit SPN account     |For more information on these scenarios, see [Cannot generate SSPI context error](cannot-generate-sspi-context-error.md).         |
|Explicit SPN is duplicated     |If you recently changed the SQL Server service account from LocalSystem to a domain account, it's easy to forget to remove the SPN from the computer and just create a new SPN on the new service account. This generates an SSPI Context error.<br/> [!NOTE] Use `-QF` to search the entire forest.         |

## Issues related to Windows permissions or Policy settings

The following table provides further information for each of the AD and DC issues:

|Possible cause  |More information  |
|---------|---------|
|Only admins can log in   |This issue occurs if the security log on a computer if full and doesn't have space to fill events. The security feature **[CrashOnAuditFail](/previous-versions/windows/it-pro/windows-2000-server/cc963220(v=technet.10))** is used by system administrators to check all security events. The valid values for `CrashOnAuditFail` are *0*, *1*, and *2*. If the key is set to *2*, it means that the security event log is full and the "Only Admins can login" error message is shown. To resolve this issue, follow these steps: <br/>1. Start the Registry editor.<br/>2. Locate the following key, and then check whether the value of the key `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa!crashonauditfail` is set to *2*. <br/>This indicates that the security event log requires manual clearing.<br/>3. Set the value to *0* and then reboot the server. <br/>You might also want to change the security event log to allow events to roll over. For more information about how the setting affects all services such as SQL, IIS, file share, and login, see [Users cannot access Web sites when the security event log is full](../../../developer/webapps/iis/general/users-cannot-access-web-sites-when-log-full.md).<br/>**Note:** This only affects integrated logins. A Named Pipe connection will also be affected with a SQL Login because Named Pipes first logs into Windows' Admin pipe before connecting to SQL Server.|
|Service account isn't trusted for delegation   | This type of issue usually occurs when a service account is not allowed to assign credentials to other servers. This can affect services that require delegation. If a delegation scenario isn't enabled, check the SQL Server *secpol.msc* to see if the SQL Server service account is listed under **Local Policies -> User Rights Assignment -> Impersonate a client after authentication** security policy settings. For more information, see [Enable computer and user accounts to be trusted for delegation](/windows/security/threat-protection/security-policy-settings/enable-computer-and-user-accounts-to-be-trusted-for-delegation). |

> [!NOTE]
> For issues related to NT LAN Manager, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON.](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)

## Issues related to Active Directory and Domain Controller

The following table provides some solutions to the AD and DC issues:

|Possible causes  |Workarounds  |
|---------|---------|
|An account is disabled. | You might experience this scenario if the user account was disabled by an administrator or by a user. In such a case, you can't login with this account or start a service with it. |
|An account isn't in the group. | You can access the database using groups rather than individually. Check the SQL logins to enumerate allowed groups and make sure the user belongs to one of them.    |
|Cross-Domain groups    | Users from the [remote domain should belong to a group](../../../windows-server/windows-security/trust-between-windows-ad-domain-not-work-correctly.md) in the SQL Server domain. If the domains lack proper trust, adding the users in a group in the remote domain might prevent the SQL Server from enumerating the group's membership.  |
|Firewall blocks the DC   | Make sure the DC is accessible from the client or the SQL Server using the `nltest /SC_QUERY:CONTOSO` command.  |
|Domain Controller is offline   | Use NLTEST to force the computer to switch to another DC. See [Active Directory replication Event ID 2087: DNS lookup failure caused replication to fail](../../../windows-server/identity/active-directory-replication-event-id-2087.md).   |
|Selective authentication issue | Selective authentication is a feature of domain trusts that allows the domain administrator to limit which users have access to resources in the remote domain. If selective authentication isn't enabled, all users in the trusted domain can get access to the remote domain. To resolve this issue, make sure the users aren't allowed to authenticate in the remote domain by enabling selective authentication.  |
|Account migration issue  | If old user accounts can't connect to the SQL Server, but newly created accounts can, this could happen if account migration isn't correct. This issue is related to AD.  For more information, see [Transfer logins and passwords between instances of SQL Server](../security/transfer-logins-passwords-between-instances.md). |
|Domain Trust issue | This issue is related to the trust level between domains. The trust level between domains might cause failures in account authentication or the visibility of SPNs. To troubleshoot such issues, follow these steps:<br/>1. List SPNs for the service account using the `- setspn -l` command.<br/>2. [Register the SPNs](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc731241(v=ws.11)) if required using the `- setspn -s` link.<br/> 3. Test authentication with the `- runas /user:<Username> "cmd"` command.|

## Issues related to Kerberos authentication

The following table contains information about causes related to Kerberos authentication:

|Possible causes |More information  |
|---------|---------|
|Not trusted for delegation | In a double-hop scenario, the service account of the mid-tier service must be trusted for Delegation in Active Directory. If you're an administrator, enable the **Trusted for delegation** option. |
|SPN on wrong account|You might receive this error message if your SPN is configured on the wrong account in Active Directory. To resolve this error, follow these steps: <br/> 1. Use `SETSPN -Q spnName` to locate the SPN and its current account.<br/> 2. Use `SETSPN -D` to delete the existing SPNs.<br/> 3. Use the `SETSPN -S` to migrate it to the correct account.|
|An incorrect DNS suffix is appended to the NetBIOS name | This can happen when you just use the NetBIOS name, example SQLPROD01, rather than the fully qualified domain (FQDN) name, example SQLPROD01.CONTOSO.COM, the wrong DNS suffix might be appended. Check the network settings for the default suffixes and make sure they're correct or use the FQDN to avoid issues.|
|Sensitive account issue  | Some accounts may be marked as sensitive in AD. These accounts can't be delegated to another service in a double-hop scenario. |
|User belongs to many groups  | If you use Kerberos over UDP, the entire security token must fit within a single packet. Users that belong to many groups have a larger security token than users who belong to fewer groups. If you use Kerberos over TCP, you can increase the [`MaxTokenSize`] setting. For more information, see [MaxTokenSize and Kerberos Token Bloat](/archive/blogs/shanecothran/maxtokensize-and-kerberos-token-bloat).  |
|Clock skew   | This scenario can occur when clocks on more than one device on a network aren't synchronized. For Kerberos server to work, the clocks between machines can't be turned off for more than five minutes.   |
| NTLM and Constrained Delegation | If the target is a file share, the delegation type of the mid-tier service account must be **Constrained-Any** and not **Constrained-Kerberos**. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).     |
|Per-Service-SID     | Refers to a security feature of SQL Server that limits local connections to use New Technology LAN Manager (NTLM) and not Kerberos as the authentication method. The service can make a single hop to another server using NTLM credentials, but it can't be delegated further without using the constrained delegation.         |
|Legacy Providers and Named Pipes  | The legacy OLE DB Provider (SQLOLEDB) and ODBC Driver {SQL Server} that come with Windows don't support Kerberos over Named Pipes, only NTLM. Use a TCP connection to allow Kerberos.        |
|Kernel mode authentication   | The SPN on the App Pool account is normally required for web servers; however, when using Kernel Mode Authentication, the computer's HOST SPN is used for authentication, which takes place in the kernel. This setting might be used if the server hosts many different websites using the same host header URL, different App Pool accounts, and [Windows Authentication](/iis/configuration/system.webserver/security/authentication/).     |
|Delegating credentials to Access or Excel   | The Joint Engine Technology (JET) and Access Connectivity Engine (ACE) providers are similar to any of the file systems. You must use constrained delegation to allow SQL Server to read files located on another machine. In general, the ACE provider shouldn't be used in a linked server as this is explicitly not supported. The JET provider is deprecated and is available on 32-bit machines only.     |
|Web site host header     | If the website has a host header name, the HOSTS SPN can't be used. An explicit HTTP SPN must be used. If the web site doesn't have a host header name, NTLM is used and it can't be delegated to a backend SQL Server or other service.         |
|Hosts file   | The Hosts file overrides DNS lookups and might generate an unexpected SPN name. This  causes NTLM credentials to be used. If an unexpected IP address is in the Hosts file, the SPN generated might not match the backend pointed to.        |
|Delegating to a file share   | Make sure to use constrained delegation in this scenario.       |
|HTTP Ports   | Normally, HTTP SPNs don't use port numbers, example `http/web01.contoso.com`, but you can enable this through the policy on the clients. The SPN would then have to be in the `http/web01.contoso.com:88` format, to enable Kerberos to function correctly. Otherwise, NTLM credentials are used, which aren't recommended because it would be difficult to diagnose the issue and it might be an excessive administrative overhead.   |
|Expired tickets|Refers to [Kerberos tickets](expired-tickets-error.md).|
|Disjoint DNS Namespace |Refers to the [DNS namespace](disjoint-dns-namespace-error.md) issue. |
|SQL Alias|A SQL Server alias may cause an unexpected SPN to be generated. This results in NTLM credentials if the SPN isn't found, or an SSPI failure, if it inadvertently matches the SPN of another server. |

## Issues related to other aspects

The following table contains the possible cause and related information about various other issues:

|Possible cause  |More information  |
|---------|---------|
|Integrated authentication isn't enabled     | This might be related to the integrated authentication issues. To resolve this type of error, make sure that the **Integrated Windows Authentication** is enabled in the **Internet Options**.     |
|Wrong Internet zone   | This might happen if you try to access a web site that isn't in the correct Internet zone in IE. The credentials won't work if the web site is in the Local Intranet zone.      |
|IIS Authentication     | Configure the web site to allow Windows Authentication and set the `<identity impersonate="true"/>` value in the *web.config* file needs to have set.         |
|Service account not trusted for delegation |Check if the service account isn't trusted for delegation. For more information, see [How to Configure the Server to be Trusted for Delegation - Microsoft Desktop Optimization Pack](/microsoft-desktop-optimization-pack/appv-v4/how-to-configure-the-server-to-be-trusted-for-delegation). If a delegation scenario isn't enabled, check the SQL Server *secpol.msc* to see if the SQL Server service account is listed under **Local Policies -> User Rights Assignment -> Impersonate a client after authentication** security policy settings. |
