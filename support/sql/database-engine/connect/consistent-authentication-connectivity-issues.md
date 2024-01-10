---
title: Introduction to consistent authentication issues
description: This article introduces to consistent authentication issues, the types of error messages, and workarounds to troubleshoot various issues.
ms.date: 12/15/2023
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

- Collect the SPN information based on the service accounts by using the `SETSPN -L` command.

## Errors

This section describes the types of errors and its related information.

### Directory services specific errors

Refers to the Active Directory (AD) errors. If the SQL Server error log file contains both or either of the following messages, then this error is related to Active Directory (AD). This error might occur if the domain controller (DC) can't be contacted by Windows on the SQL Server computer or the local security service (LSASS) is having an issue.

  ```output
   Error -2146893039 (0x80090311): No authority could be contacted for authentication.
   Error -2146893052 (0x80090304): The Local Security Authority cannot be contacted.
  ```

### Login failed specific errors

When you are troubleshooting "Login Failed" error message, the SQL Server error log file can provide more information in the SQL State value with error 18456 (Login Failed). For more information, see [Login failed error codes](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#additional-error-information).

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

The following sections provides various scenarios related to connection string issues.

|Possible cause  |More information  |
|---------|---------|
|Bad server name in connection string     |This scenario might occur if the specified server name is incorrect or can't be found. For more information, see [bad server name in connection string](bad-server-name-connection-string-error.md).         |
|Invalid username     |For more information, see [Login failed for user '\<username\>' or login failed for user '\<domain>\<username\>'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).         |
|Wrong database name in connection string     | This scenario might occur if the [database name is incorrect](wrong-database-name-in-connection-string.md). Check if it is spelled correctly.        |
|Wrong explicit SPN account     |For more information on these scenarios, see [Cannot generate SSPI context error](cannot-generate-sspi-context-error.md).         |
|Explicit misplaced SPN     |If the SPN you specify in the connection string exists on a service account that's not used by SQL Server, you'll get an SSPI Context error message.         |
|Explicit SPN is duplicated     |If you recently changed the SQL Server service account from LocalSystem to a domain account, it's easy to forget to remove the SPN from the computer and just create a new SPN on the new service account. This generates an SSPI Context error.<br/> [!NOTE] Use `-QF` to search the entire forest.         |

## Issues related to Windows permissions or Policy settings

The following table provides further information for each of the AD and DC issues:

|Possible cause  |More information  |
|---------|---------|

|Service account not trusted for delegation    | If a delegation scenario isn't enabled, check the SQL Server *secpol.msc* to see if the SQL Server service account is listed under **Local Policies -> User Rights Assignment -> Impersonate a client after authentication** security policy settings.         |


> [!NOTE]
> For issues related to NT LAN Manager, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON.](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)

## Issues related to Active Directory and Domain Controller

The following table provides some solutions to the AD and DC issues:

|Possible causes  |Workarounds  |
|---------|---------|
|An account is disabled | You might experience this scenario if the user account was disabled by an administrator or by a user. In such a case, you can't login with this account or start a service with it. |
|An account isn't in the group. | You can access the database using groups rather than individually. Check the SQL logins to enumerate allowed groups and make sure the user belongs to one of them.    |
|Cross-Domain groups    | Users from the [remote domain should belong to a group](../../../windows-server/windows-security/trust-between-windows-ad-domain-not-work-correctly.md) in the SQL Server domain. If the domains lack proper trust, adding the users in a group in the remote domain might prevent the SQL Server from enumerating the group's membership.  |
|Firewall blocks the DC   | Make sure the DC is accessible from the client or the SQL Server using the `nltest /SC_QUERY:CONTOSO` command.  |
|Domain Controller is offline   | Use NLTEST to force the computer to switch to another DC. See [Active Directory replication Event ID 2087: DNS lookup failure caused replication to fail](../../../windows-server/identity/active-directory-replication-event-id-2087.md).   |
|Selective authentication  | Make sure the user isn't allowed to authenticate in the remote domain.      |
|Account migration   | If old user accounts can't connect to the SQL Server, but newly created accounts can, this could be due to account migration. This issue is related to AD.    |
|Domain Trust | This issue is related to the trust level between domains.|

## Issues related to Kerberos authentication

The following table contains information about causes related to Kerberos authentication:

|Possible causes |More information  |
|---------|---------|
|Not trusted for delegation and Not a constrained target |These issues are related to AD. If you're an administrator, enable the **Trusted for delegation** setting. |
|NetBIOS name | When you use just the NetBIOS name, example SQLPROD01, rather than the fully qualified domain (FQDN) name, example SQLPROD01.CONTOSO.COM, the wrong DNS suffix might be appended. Check the network settings for the default suffixes and make sure they're correct or use the FQDN to avoid issues.|
|Sensitive account   | Some accounts may be marked as Sensitive in AD. These accounts can't be delegated to another service in a double-hop scenario. |
|User belongs to many groups  | This can happen when a user is a member of many groups in AD. If you use Kerberos over UDP, the entire security token must fit within a single packet. Users that belong to many groups have a larger security token than users who belong to fewer groups. If you use Kerberos over TCP, you can increase the [`MaxTokenSize`] setting. For more information, see [MaxTokenSize and Kerberos Token Bloat](/archive/blogs/shanecothran/maxtokensize-and-kerberos-token-bloat).  |
|Clock skew   | This error can occur when clocks on more than one device on a network aren't synchronized. For Kerberos server to work, the clocks between machines can't be turned off for more than five minutes.   |
| NTLM and Constrained Delegation | If the target is a file share, the delegation type of the mid-tier service account must be **Constrained-Any** and not **Constrained-Kerberos**. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).     |
|Per-Service-SID     | Refers to a security feature of SQL Server that limits local connections to use New Technology LAN Manager (NTLM) and not Kerberos as the authentication method. The service can make a single hop to another server using NTLM credentials, but it can't be delegated further without using the constrained delegation.         |
|Legacy Providers and Named Pipes  | The legacy OLE DB Provider (SQLOLEDB) and ODBC Driver {SQL Server} that come with Windows don't support Kerberos over Named Pipes, only NTLM. Use a TCP connection to allow Kerberos.        |
|Kernel Mode Authentication   | The SPN on the App Pool account is normally required for web servers; however, when using Kernel Mode Authentication, the computer's HOST SPN is used for authentication, which takes place in the kernel. This setting might be used if the server hosts many different websites using the same host header URL, different App Pool accounts, and [Windows Authentication](/iis/configuration/system.webserver/security/authentication/).     |
|Delegating Credentials to Access or Excel   | The Joint Engine Technology (JET) and Access Connectivity Engine (ACE) providers are similar to any of the file systems. You must use constrained delegation to allow SQL Server to read files located on another machine. In general, the ACE provider shouldn't be used in a linked server as this is explicitly not supported. The JET provider is deprecated and is available on 32-bit machines only.     |
|Web site host header     | If the web site has a host header name, the HOSTS SPN can't be used. An explicit HTTP SPN must be used. If the web site doesn't have a host header name, NTLM is used and it can't be delegated to a backend SQL Server or other service.         |
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
