---
title: Introduction to consistent authentication issues
description: This article introduces to consistent authentication issues, the types of error messages, and workarounds to troubleshoot various issues.
ms.date: 12/07/2023
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes v-jayaramanp
ms.custom: sap:Connection issues
---

# Troubleshoot consistent authentication issues

_Applies to:_ &nbsp; SQL Server

> [!NOTE]
> Before you start troubleshooting, check the [prerequisites](../connect/resolve-connectivity-errors-checklist.md) and go through the checklist.

> [!NOTE]
> The commands provided in this article are for Windows systems only.

A consistent authentication issue in SQL Server typically refers to problems related to authentication and authorization of users or applications trying to access the SQL Server database. These issues can lead to authentication failures, access denied errors, or other security-related problems.

Before you start to troubleshoot errors, it's important to understand what each error means and also what is the type of error. Some errors might appear in more than one category.

It's also important to understand the category of the error because the troubleshooting steps also vary. This section provides various categories of consistent authentication errors.

## Directory services specific issues

Refers to the Active Directory errors. If the SQL Server error log file contains both or either of the following messages, then this is an Active Directory (AD) issue. This might happen if the domain controller (DC) can't be contacted by Windows on the SQL Server computer or the local security service (LSASS) is having a problem.

   > Error -2146893039 (0x80090311): No authority could be contacted for authentication.
   > Error -2146893052 (0x80090304): The Local Security Authority cannot be contacted.

## Login failed error codes

 If you are troubleshooting a "Login Failed" error message, the SQL Server error log file can provide more information in the SQL State value with error 18456 (Login Failed). For more information, see [Login failed error codes](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#additional-error-information).

## Login failed specific issues

This section lists the possible error messages and their possible causes.

|Error message  |Possible causes  |
|---------|---------|
|`Login failed for user 'userx'. Reason: Password did not match that for the login provided.`|This error might occur if a bad password is used. For more information, see [Login failed for user '\<username\>' or login failed for user '\<domain>\<username>'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).|
|Invalid username|For more information, see [Login failed for user '\<username\>' or login failed for user '\<domain>\<username\>'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).|
|`SQL Server does not exist or access denied.`  | [Named Pipes connections](named-pipes-connection-fail-no-windows-permission.md) fail because the user doesn't have permission to log into Windows.     |
|`Cannot open database "test" requested by the login. The login failed.`|The database might be offline, or the permissions might not be sufficient. For more information, see [Database offline in MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).|
|`A transport-level error has occurred when sending the request to the server.`|Check if the [linked server account mapping](linked-server-account-mapping-error.md) is correct. For more information, see [sp_addlinkedsrvlogin](/sql/relational-databases/system-stored-procedures/sp-addlinkedsrvlogin-transact-sql).|
|`SSPI (Security Support Provider Interface) Context.`|Check if the [SPN is on the wrong account](cannot-generate-sspi-context-error.md).|
|`Login failed for user 'username'.` | This can happen if the [proxy account](../../integration-services/ssis-package-doesnt-run-when-called-job-step.md) isn't properly authenticated.    |
|`Login Failed for user: 'NT AUTHORITY\ANONYMOUS LOGON'`|This error might occur if the [SPN is missing, SPN is duplicated, or the SPN is on the wrong account](cannot-generate-sspi-context-error.md).|
|`Login failed for user 'username'.` </br> `Login failed for user '\<database\username\>'`</br>    | Check if there is a [bad server name in connection string](bad-server-name-connection-string-error.md). Also, check if the [user doesn't belong to a local group](access-through-group-windows-permissions.md) that's used to grant access to the server. For more causes, see [NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).    |
|`"Cannot open database "northwind" requested by the login. The login failed."`|Check if the database name in the connection string is correct.|
|SSPI Context errors|The explicit SPN account might be [wrong](wrong-explicit-spn-account-connection-string.md), missing, or misplaced. |
|`"The user account is not allowed the Network Login type"`|You might not be able to [log in to the network](network-login-disallowed.md).|
|Service account not trusted for delegation |Check if the service account isn't trusted for delegation. For more information, see [How to Configure the Server to be Trusted for Delegation - Microsoft Desktop Optimization Pack](/microsoft-desktop-optimization-pack/appv-v4/how-to-configure-the-server-to-be-trusted-for-delegation). If a delegation scenario isn't enabled, check the SQL Server *secpol.msc* to see if the SQL Server service account is listed under **Local Policies -> User Rights Assignment -> Impersonate a client after authentication** security policy settings. |
|"The login is from an untrusted domain and cannot be used with Windows authentication."|This error might be related to the [Local Security Subsystem](local-security-subsystem-issues.md) issues.|

For detailed information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

## Issues specific to various aspects of SQL Server

The following table lists some scenarios that are related to aspects as database, logon account permissions, and linked servers.

|Possible cause  |More information  |
|---------|---------|
|Database is offline   | In many cases, this error is logged right after the server has restarted  or after a cluster has failed over. The error doesn't affect as the server starts accepting logins before all databases are online. If the issue persists, and you can't bring the database online in SQL Server Management Studio, then you can contact the SQL Core team to perform further troubleshooting. For detailed information regarding the error, see [Login failed for user '\<username\>' or login failed for user '\<domain>\<username>'.](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).     |
|Linked Server Account Mapping|This scenario is related to [linked servers](linked-server-account-mapping-error.md).|
|Database permissions     | For detailed information regarding the error, see [Login failed for user '\<username\>' or login failed for user '\<domain>\<username\>'.](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).    |
|Proxy account     |  An SSIS job run by SQL Agent might need permissions other than the SQL Agent service account can provide. For more information, see [SSIS package does not run when called from a SQL Server Agent job step.](../../integration-services/ssis-package-doesnt-run-when-called-job-step.md)  |
|Bad metadata     | A view or stored procedure receives login failures on a linked server whereas a distributed `SELECT` statement copied from them doesn't. This is likely if the View was created and then the linked server was recreated, or a remote table was altered without rebuilding the View.  |

## Issues related to Connection String

The following table lists the possible cause and further information related to connection string issues.

|Possible cause  |More information  |
|---------|---------|
|Bad server name in connection string     | This scenario might occur if the specified server name is incorrect or can't be found. For more information, see [bad server name in connection string](bad-server-name-connection-string-error.md).  |
|Wrong database name in connection string     | This scenario might occur if the [database name is incorrect](wrong-database-name-in-connection-string.md). Check if it spelled correctly.   |
|[Wrong explicit SPN account](wrong-explicit-spn-account-connection-string.md), explicit SPN is missing        | For more information on these scenarios, see [Cannot generate SSPI context error](cannot-generate-sspi-context-error.md).      |
|Explicit misplaced SPN     | If the SPN you specify in the connection string exists on a service account that's not used by SQL Server, you will get an SSPI Context error message.        |
|Explicit SPN is duplicated     | If you recently changed the SQL Server service account from LocalSystem to a domain account, it is easy to forget to remove the SPN from the computer and just create a new SPN on the new service account. This will generate an SSPI Context error. <br/> **Note**: Use `-QF` to search the entire forest.        |

## Windows permissions or Policy settings related issues

The following table provides further information for each of the AD and DC issues:

|Possible cause  |More information  |
|---------|---------|
|Access via group     | If the user doesn't belong to a local group used to grant access to the server, the provider should display the "Login failed for user 'database name/username'" error message. The DBA can double-check the access by looking at the Security\Logins in SSMS. If it's a contained database, the DBA checks under database name. <br/>When you run the `xp_logininfo 'contoso/user1'` stored procedure, the following might happen:<br/><ul><li>If you receive an error, SQL can't resolve the username at all. It might be likely that a name isn't present in the AD or there might be issues connecting to the DC. Try with another name to check if the issue is related to a specific account.</li><br/><li>If you are connecting to cross-domain, the group must be in the SQL Server domain, and not the user domain so that its membership can be resolved.</li><br/><li>If no rows are returned, then there's no group that provides access to the server. If one or more rows are returned, then the user belongs to a group that provides access. </li><br/>|
|Network login disallowed     | This scenario might occur if the Netlogon service is disabled. You can correct this by using the Local security policy manager. For more information, see [Network login disallowed](network-login-disallowed.md).    |
|Service account not trusted for delegation    | If a delegation scenario isn't enabled, check the SQL Server *secpol.msc* to see if the SQL Server service account is listed under **Local Policies -> User Rights Assignment -> Impersonate a client after authentication** security policy settings.         |
|Only Admins can log in      |This scenario might occur if you aren't logged in as an Administrator. For more information, see [Only Admins can log in](only-admins-can-login.md).         |
|Local security subsystem issues     | This scenario is related to Active Directory. For detailed information, see [Local security subsystem issues](local-security-subsystem-issues.md).    |
|Corrupt user profile     | This scenario is related to a [profile issue](corrupt-user-profile.md).         |
|Credential guard is enabled     | In Windows 10 Enterprise, there's a new feature called Credential Guard. If the client is Windows 10 Enterprise Edition and the Credential Guard feature is turned ON, then you won't be able to use full delegation (Trust this user for delegation to any service). You can only use constrained delegation.<br/>When the Credentials Guard is enabled, certain authentication features are blocked. Applications will break if they require the following features:<br/><ul><li>Kerberos DES encryption support.<br/></li><li>Kerberos unconstrained delegation.</li><li>Extracting the Kerberos TGT.<li>NTLMv1</li></ul>  |

> [!NOTE]
> For issues related to NT LAN Manager, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON.](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)

## Active Directory and Domain Controller issues

The following table provides some solutions to the AD and DC issues:

|Possible causes  |Workarounds  |
|---------|---------|
|An account is disabled.  | You might experience this error if the user account has been disabled by an administrator or by a user. In such a case, you can't login with this account or start a service with it. |
|An account is not in the group. | You can access the database using groups rather than individually. Check the SQL logins to enumerate allowed groups and make sure the user belongs to one of them.    |
|Cross-Domain groups    | Users from the [remote domain should belong to a group](../../../windows-server/windows-security/trust-between-windows-ad-domain-not-work-correctly.md) in the SQL Server domain. If the domains lack proper trust, adding the users in a group in the remote domain might prevent the SQL Server from enumerating the group's membership.  |
|Firewall blocks the DC   | Make sure the DC is accessible from the client or the SQL Server using the `nltest /SC_QUERY:CONTOSO` command.  |
|Domain Controller is offline   |This error might occur if there are incorrect Domain Naming Service (DNS) records for DC. NLTEST can be used to force the computer to switch to another DC. See [Active Directory replication Event ID 2087: DNS lookup failure caused replication to fail](../../../windows-server/identity/active-directory-replication-event-id-2087.md).   |
|Selective authentication  | Make sure the user isn't allowed to authenticate in the remote domain.      |
|Account migration   | If old user accounts can't connect to the SQL Server, but newly created accounts can, this could be due to account migration. This is an AD issue.        |

## Kerberos authentication issues

The following table contains information about issues related to Kerberos authentication:

|Possible causes |More information  |
|---------|---------|
|Not trusted for delegation and Not a constrained target |These are Active Directory (AD) issues. If you are an Administrator, enable the **Trusted for delegation** setting. |
|Sensitive account   | Some accounts may be marked as Sensitive in AD. These accounts can't be delegated to another service in a double-hop scenario. |
|User belongs to many groups  | This can happen when a user is a member of many groups in AD. If you use Kerberos over UDP, the entire security token must fit within a single packet. Users that belong to many groups will have a larger security token than those that belong to fewer groups. If you use Kerberos over TCP, you can increase the [`MaxTokenSize`] setting. For more information, see [MaxTokenSize and Kerberos Token Bloat](/archive/blogs/shanecothran/maxtokensize-and-kerberos-token-bloat).  |
|Clock skew   | This error can occur when clocks on more than one device on a network aren't synchronized. For Kerberos server to work, the clocks between machines can't be turned off for more than five minutes.   |
| NTLM and Constrained Delegation | If the target is a file share, the delegation type of the mid-tier service account must be **Constrained-Any** and not **Constrained-Kerberos**. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).     |
|Per-Service-SID     | Is a security feature of SQL Server that limits local connections to use New Technology LAN Manager (NTLM) and not Kerberos as the authentication method. The service can make a single hop to another server using NTLM credentials, but it can't be delegated further without using the constrained delegation.         |
|Legacy Providers and Named Pipes  | The legacy OLE DB Provider (SQLOLEDB) and ODBC Driver {SQL Server} that come with Windows don't support Kerberos over Named Pipes, only NTLM. Use a TCP connection to allow Kerberos.        |
|Kernel Mode Authentication   | Normally, the SPN must be on the App Pool account for web servers, but when you use Kernel Mode Authentication, authentication is performed in the kernel and the computer's HOST SPN is used. This setting might be used if the server hosts a number of different websites using the same host header URL, different App Pool accounts, and [Windows Authentication](/iis/configuration/system.webserver/security/authentication/).     |
|Delegating Credentials to Access or Excel   | The Joint Engine Technology (JET) and Access Connectivity Engine (ACE) providers are similar to any of the file systems. You must use constrained delegation to allow SQL Server to read files located on another machine. In general, the ACE provider shouldn't be used in a linked server as this is explicitly not supported. The JET provider is deprecated and is available on 32-bit machines only.     |
|Web site host header     | If the web site has a host header name, the HOSTS SPN can't be used. An explicit HTTP SPN must be used. If the web site doesn't have a host header name, NTLM is used and it can't be delegated to a backend SQL Server or other service.         |
|Hosts file   | The Hosts file overrides DNS lookups and might generate an unexpected SPN name. This will cause NTLM credentials to be used. If an unexpected IP address is in the Hosts file, the SPN generated might not match the backend pointed to.        |
|Delegating to a file share   | Make sure to use constrained delegation in this scenario.       |
|HTTP Ports   | Normally, HTTP SPNs don't use port numbers, example `http/web01.contoso.com`, but you can enable this through the policy on the clients. The SPN would then have to be in the `http/web01.contoso.com:88` format, to enable Kerberos to function correctly. Otherwise, NTLM credentials are used, which aren't recommended because it would be difficult to diagnose the issue and it might be an excessive administrative overhead.   | 

## Other issues

The following table contains the possible cause and related information about scenarios related to Internet access:

|Possible cause  |More information  |
|---------|---------|
|Integrated authentication is not enabled     | This might be related to the integrated authentication issues. To resolve this type of error, in the **Internet Options**, make sure that the **Integrated Windows Authentication** is enabled.     |
|Wrong Internet zone   | This might happen if you try to access a web site that is not in the correct Internet zone in IE. The credentials will not work if the web site is not in the Local Intranet zone.      |
|IIS Authentication     | Configure the web site to allow Windows authentication and the *web.config* file needs to have the `<identity impersonate="true"/>` set.         |
