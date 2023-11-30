---
title: Introduction to consistent authentication issues
description: This article introduces to consistent authentication issues, the types of error messages, and workarounds to troubleshoot various problems.
ms.date: 11/27/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Troubleshoot consistent authentication issues

_Applies to:_ &nbsp; SQL Server 

> [!NOTE]
> Before you start troubleshooting, check the [prerequisites](../connect/resolve-connectivity-errors-checklist.md) and go through the checklist.

> [!NOTE]
> The commands provided in this article are for Windows systems only.

A consistent authentication issue in SQL Server typically refers to problems related to authentication and authorization of users or applications trying to access the SQL Server database. These issues can lead to authentication failures, access denied errors, or other security-related problems.

Before you start to troubleshoot errors, it's important to understand what each error means and also what is the type of error.

It's also important to understand the category of the error because the troubleshooting steps also vary. This section provides various types of consistent authentication errors.

## Directory services specific issues

Refers to the Active Directory errors. If the SQL Server ErrorLog file contains both or either of the following messages, then this is an Active Directory issue. This might happen if the domain controller (DC) can't be contacted by Windows on the SQL Server computer, or the local security service (LSASS) is having a problem.

   `Error -2146893039 (0x80090311): No authority could be contacted for authentication.`
   `Error -2146893052 (0x80090304): The Local Security Authority cannot be contacted.`

## Login failed error codes

 If you are troubleshooting a "Login Failed" error message, the SQL Server ErrorLog file can provide more information in the SQL State value with error 18456 (Login Failed). For more information, see [Login failed error codes](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?view=sql-server-ver16&preserve-view=true#additional-error-information).

## Login failed specific issues

Refers to some of the common login failures. For detailed information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?view=sql-server-ver16&preserve-view=true).

  - [Login failed for user '(null)'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?view=sql-server-ver16&preserve-view=true#login-failed-for-user-(null))
  - [Login failed for user ''](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [Login failed for user 'NT AUTHORITY\ANONYMOUS LOGON'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [Login failed for user 'username'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [Login failed for user 'DOMAIN\username'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - Login failed. The login is from an untrusted domain and cannot be used with Windows authentication.
  - [SQL Server does not exist or access denied](network-related-or-instance-specific-error-occurred-while-establishing-connection.md) - This can also be a network error.
- [SSPI context messages](/troubleshoot/sql/database-engine/connect/cannot-generate-sspi-context-error?branch=main)

The scenarios explained in this article are broadly classified based on the causes and the category.

Before you start with troubleshooting, it is important to understand the nature of an error and the category that it belongs to. This section provides error messages grouped based on a category. Some errors might appear in more than one category. Each of these error scenarios has the symptoms and the solutions as well. Following are the error categories.

## Kerberos issues

The following table contains information about issues related to Kerberos authentication:

|Possible causes |More information  |
|---------|---------|
|Not trusted for delegation and Not a constrained target |These are Active Directory (AD) issues. If you are an Administrator, enable the Trusted for delegation setting. |
|Sensitive account   | Some accounts may be marked as Sensitive in AD. These accounts can't be delegated to another service in a double-hop scenario. |
|User belongs to many groups  |This can happen when a user is a member of many groups in AD. If you use Kerberos over UDP, the entire security token must fit within a single packet. Users that belong to many groups will have a larger security token than those that belong to fewer groups. If you use Kerberos over TCP, you can increase the `MaxTokenSize` setting. For more information, see 
[MaxTokenSize and Kerberos Token Bloat](/archive/blogs/shanecothran/maxtokensize-and-kerberos-token-bloat).  |
|Clock skew error   | This error can occur when clocks on more than one device on a network are not synchronized. For Kerberos server to work, the clocks between machines can't be off for more than five minutes.   |
| NTLM and Constrained Delegation error | If the target is a file share, the delegation type of the mid-tier service account must be **Constrained-Any** and not **Constrained-Kerberos**. See Login failed for user NT AUTHORITY\ANONYMOUS LOGON for more information.     |
|Per-Service-SID     | Is a security feature of SQL Server that limits local connections to use New Technology LAN Manager (NTLM) and not Kerberos as the authentication method. The service can make a single hop to another server using NTLM credentials, but it can't be delegated further without using the constrained delegation.         |
|Legacy Providers and Named Pipes  | This error might occur when there is a problem with the connection between the client and server. The legacy OLE DB Provider (SQLOLEDB) and ODBC Driver {SQL Server} that come with Windows don't support Kerberos over Named Pipes, only NTLM. Use a TCP connection to allow Kerberos.        |
|Kernel mode authentication   |This error can occur when you try to open a web site from a remote machine. Normally, the SPN must be on the App Pool account for web servers, but when you use Kernel Mode Authentication, authentication is performed in the kernel and the computer's HOST SPN is used. This setting may be used if the server hosts a number of different web sites using the same host header URL, different App Pool accounts, and [Windows Authentication](/iis/configuration/system.webserver/security/authentication/).     |
|Delegating Credentials to Access or Excel   | Refers to a process where a user grants permissions to another user. The Joint Engine Technology (JET) and Access Connectivity Engine (ACE) providers are similar to any of the file systems. You must use constrained delegation to allow SQL Server to read files located on another machine. In general, the ACE provider shouldn't be used in a linked server as this is explicitly not supported. The JET provider is deprecated and is available on 32-bit machines only.     |
|SQL alias   | A SQL [Server alias](network-related-or-instance-specific-error-occurred-while-establishing-connection.md) may cause an unexpected SPN to be generated. This will result in NTLM credentials if the SPN isn't found, or an SSPI failure, if it inadvertently matches the SPN of another server.    |
|Website host header     | If the website has a host header name, the HOSTS SPN can't be used. An explicit HTTP SPN must be used. If the website doesn't have a host header name, NTLM is used and it can't be delegated to a backend SQL Server or other service.         |
|HOSTS file   | The hosts file overrides DNS lookups and might generate an unexpected SPN name. This will cause NTLM credentials to be used. If an unexpected IP address is in the hosts file, the SPN generated might not match the backend pointed to.        |


## Other issues

The following table contains scenarios related to Internet access related issues:

|Possible cause  |More information  |
|---------|---------|
|Integrated authentication is not enabled     | This might be related to the integrated authentication issues. To resolve this type of error, in the **Internet Options**, make sure that the **Integrated Windows Authentication** is enabled.     |
|Wrong Internet zone     | This might happen if you try to access a website that is not in the correct Internet zone in IE. The credentials will not work if the web site is not in the Local Intranet zone.        |
|IIS Authentication     | Configure the website to allow Windows Authentication and the *web.config* file needs to have the `<identity impersonate="true"/>` set.         |

- Following are the errors specific to failed login:
  - [Bad password](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [Invalid username](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [SQL logins are not enabled](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [Named Pipes connections fail because the user doesn't have permission to log into Windows](named-pipes-connection-fail-no-windows-permission.md).

- Following are the errors specific to the different aspects of SQL Server:
  - [Database offline](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [Database permissions](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [No Login](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [Linked Server Account Mapping](linked-server-account-mapping-error.md)
  - [Proxy Account](proxy-account-error.md)
  - [Bad metadata](bad-metadata-error.md)

- Following are the errors specific to Connection String:
  - [Bad server name in Connection String](bad-server-name-connection-string-error.md)
  - [Wrong database name in Connection String](wrong-database-name-in-connection-string.md)
  - [Wrong explicit SPN account](wrong-explicit-spn-account-connection-string.md)
  - [Explicit SPN is missing](cannot-generate-sspi-context-error.md)
  - [Explicit Misplaced SPN](cannot-generate-sspi-context-error.md)
  - [Explicit SPN is duplicated](cannot-generate-sspi-context-error.md)

- Following are the errors specific to the local Windows permissions or Policy settings.
  - [Access via Group](access-through-group-windows-permissions.md)
  - [Network login disallowed](network-login-disallowed.md)
  - [Service account not trusted for delegation](service-account-not-trusted-for-delegation.md)
  - [Only admins can login](only-admins-can-login.md)
  - [Local Security Subsystem Issues](local-security-subsystem-issues.md)
  - [Corrupt user profile](corrupt-user-profile.md)
  - [Credential Guard is enabled](/windows/security/identity-protection/credential-guard/considerations-known-issues)

- Following are the errors specific to NTLM:
  - [NTLM Peer Login](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?view=sql-server-ver16)
  - [Loopback Protection](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?view=sql-server-ver16)
  - [Always-On Listener Loopback Protection](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?view=sql-server-ver16)
  - [Double Hop](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?view=sql-server-ver16)
  - [LANMAN Compatibility Level](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?view=sql-server-ver16)

- Issues specific to Active Directory and Domain Controller:
  - [Account disabled](account-disabled-error.md)
  - [Cross-domain groups](cross-domain-groups.md)
  - [Firewall blocks the DC](firewall-blocks-the-dc.md)
  - [Domain trust](domain-trust-error.md)
  - [Selective authentication](selective-authentication.md)
  - [Account migration](account-migration-error.md)
  - [Directory Services specific error messages](directory-services-specific-error-messages.md)

- Issues specific to Kerberos:
  - Missing SPN - 
- Miscellaneous issues - To be added.
