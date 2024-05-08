---
title: Overview of consistent authentication issues in SQL Server
description: This article discusses consistent authentication issues in SQL Server, related error messages, and solutions to troubleshoot various issues.
ms.date: 05/08/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes v-jayaramanp
ms.custom: sap:Connection issues
---

# Consistent SQL Server authentication issues

_Applies to:_ &nbsp; SQL Server

> [!NOTE]
> The commands that are provided in this article apply to Windows systems only.

A consistent authentication issue that occurs in Microsoft SQL Server typically refers to issues that are related to authentication and authorization of users or applications that try to access the SQL Server database. These issues can be authentication failures, access denied errors, or other security-related problems.

Before you start to troubleshoot errors, it's important to understand what each error message means and also the error type. Some errors might appear in more than one authentication issue. You can use the troubleshooting information that's mentioned in the [Types of errors](#types-of-errors) section to resolve the error.

## Prerequisites

Before you start troubleshooting, work through the [prerequisites](../connect/resolve-connectivity-errors-checklist.md) checklist and make sure you have the following information ready:

- Make sure that you install the [WireShark](https://www.wireshark.org/download.html) and [Problem Steps Recorder (PSR.exe)](/office/troubleshoot/settings/how-to-use-problem-steps-recorder) tools. For more information, see *Methods of collecting data for troubleshooting various types of errors*.

- Collect the Service Provider Name (SPN) information that's based on the service accounts. To do this, use the `SETSPN -L` command.

## Types of errors

This section describes error types and related information.

- Directory services errors: If the SQL Server error log file contains either or both of the following messages, then this error is related to Active Directory (AD). This error might also occur if Windows on the SQL Server-based computer fails to contact the Domain Controller (DC) or if the Local Security Authority Subsystem Service (LSASS) experiences an issue.

  ```output
   Error -2146893039 (0x80090311): No authority could be contacted for authentication.
   Error -2146893052 (0x80090304): The Local Security Authority cannot be contacted.
  ```

- Login failed errors: When you troubleshoot the "Login Failed" error message, the SQL Server error log provides additional insights on the error code 18456 with a specific state value that offers more context about the error. For more information, see the SQL Server error log file in [SQL state value](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#additional-error-information). You can try to fix the issue according to the description of the state value.

  The following table lists some specific "Login Failed" error messages and their possible causes and solutions.

  |Error message  |More information  |
  |---------|---------|
  |"A transport-level error has occurred when sending the request to the server."|Check if the [linked server account mapping](linked-server-account-mapping-error.md) is correct. For more information, see [sp_addlinkedsrvlogin](/sql/relational-databases/system-stored-procedures/sp-addlinkedsrvlogin-transact-sql).|
  |"Cannot generate SSPI context" | <ul><li>The explicit SPN account might be [wrong](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended), missing, or misplaced.</li><li>Check if the [SPN is on the wrong account](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).</li></ul> |
  |"Cannot open database \<test\> requested by the login. The login failed."|The database might be offline, or the permissions might not be sufficient. For more information, see [Database offline in MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).<br/> Also, check if the database name in the connection string is correct.|
  |"Login failed for user \<username\>." | This error can occur if the [proxy account](../../integration-services/ssis-package-doesnt-run-when-called-job-step.md) isn't properly authenticated.    |
  |"Login Failed for user: 'NT AUTHORITY\ANONYMOUS LOGON'"|This error might occur if the [SPN is missing, SPN is duplicated, or the SPN is on the wrong account](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).|
  |"Login failed for user \<username\>." </br> "Login failed for user '\<database\username\>"</br>    | Check if there's a [bad server name in connection string](bad-server-name-connection-string-error.md). Also, check if the user doesn't belong to a local group used to grant access to the server. For more causes, see [NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).    |
  |"Login failed for user '\<username\>'. Reason: Password did not match that for the login provided."|This error might occur if an incorrect password is used. For more information, see [Login failed for user '\<username\>' or login failed for user '\<domain>\<username>'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).|
  |"SQL Server does not exist or access denied."  | [Named Pipes connections](named-pipes-connection-fail-no-windows-permission.md) fail because the user doesn't have permission to log into Windows.     |
  |"The login is from an untrusted domain and cannot be used with Windows authentication."|This error might be related to the [Local Security Subsystem](local-security-subsystem-errors.md) issues.|
  |"The user account is not allowed the Network Login type"|You might not be able to [log in to the network](network-login-disallowed.md).|

## Types of consistent authentication issues

Understanding the underlying reasons behind consistent authentication issues is essential to effectively resolve them. Below are several typical causes of such problems along with their respective solutions. Select each of the tabs to see the relevant issues, causes, and solution:

### [Connection string](#tab/connectionstring)

This section lists the issues related to configuration settings used by applications to connect to a database.

- **Explicit SPN is missing** - This issue occurs if the SPN isn't configured or registered correctly. For more information, see ["Cannot generate SSPI context" error when using Windows authentication to connect SQL Server](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

- **Explicit misplaced SPN** - Refers to an SPN that has been incorrectly associated with a particular service or account. For more information, [Explicit misplaced SPN](explicit-spn-is-misplaced.md).

- **Explicit SPN is duplicated** - This issue occurs if an SPN is duplicated because it's registered more than one time. For more information, see ["Cannot generate SSPI context" error when using Windows authentication to connect SQL Server](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

- **Incorrect server name in connection string** - This issue occurs when the specified server name is incorrect or can't be found. To resolve this issue, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-username-or-login-failed-for-user-domainusername).

- **Wrong database name in connection string** - This issue occurs if the database name that's provided for authentication is incorrect. Check whether the name is spelled correctly. For more information, see [MSSQLSERVER_4064](/sql/relational-databases/errors-events/mssqlserver-4064-database-engine-error#fix-the-issue).

- **Wrong explicit SPN account** - This issue might occur if the SPN is associated with the wrong account in AD. To resolve this issue, see [Cannot generate SSPI context error](cannot-generate-sspi-context-error.md).

### [Database](#tab/database)

This section lists the issues specific to various aspects of SQL Server:

  - **Database is offline** - Refers to a scenario in which a SQL Server database tries to reconnect to a SQL Server instance that's configured for Windows Authentication mode. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-username-or-login-failed-for-user-domainusername).
  
  - **Database permissions** - Refers to enabling or restricting access to SQL Server database. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-username-or-login-failed-for-user-domainusername).
  
  - **Linked server connectivity errors in SQL Server** - You experience an authentication process issue that affects linked servers in the context of SQL Server. For more information, see [Linked server connectivity errors in SQL Server](linked-server-account-mapping-error.md).

  - **Metadata of the linked server is inconsistent** - Refers to an issue in which metadata of the linked server is inconsistent or doesn't match the expected metadata.

    A view or stored procedure queries the tables or views in the linked server but receives login failures although a distributed `SELECT` statement that's copied from the procedure doesn't.
    
    This issue might occur if the view was created and then the linked server was re-created, or a remote table was modified without rebuilding the View.

    To resolve this issue, refresh the metadata of the linked server by running the `sp_refreshview` stored procedure.

  - **Proxy account doesn't have permissions** - An SQL Server Integration Service (SSIS) job that's run by SQL Agent might need permissions other than those that the SQL Agent service account can provide. For more information, see [SSIS package does not run when called from a SQL Server Agent job step.](../../integration-services/ssis-package-doesnt-run-when-called-job-step.md).

  - **Unable to log in to SQL Server database** - The inability to log in can cause failures in authentication. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-username-or-login-failed-for-user-domainusername).

### [Directory services](#tab/dirservices)

This section lists various issues related to directory services and servers.

- **An account is disabled** - You might experience this scenario if the user account was disabled by an administrator or by a user. In such a case, you can't log in by using this account or you can't use this account to start a service. This might cause consistent authentication issues because it can prevent you from accessing resources or performing actions that require authentication.

- **An account isn't in the group** - This issue might occur if a user is trying to access a resource that's restricted to a specific group. Check the SQL logins to enumerate allowed groups and make sure that the user belongs to one of the groups.

- **Account migration failed** - If old user accounts can't connect to the server but newly created accounts can, account migration might not be correct. This issue is related to AD. For more information, see [Transfer logins and passwords between instances of SQL Server](../security/transfer-logins-passwords-between-instances.md).

- **Domain Controller is offline** - Use the `nltest` command to force the computer to switch to another DC. For more information, see [Active Directory replication Event ID 2087: DNS lookup failure caused replication to fail](../../../windows-server/identity/active-directory-replication-event-id-2087.md).

- **Firewall blocks the Domain Controller** - You might experience issues when you manage the user's access to resources. Make sure that the domain controller is accessible from the client or the server. To do this, use the `nltest /SC_QUERY:CONTOSO` command.

- **Login is from an untrusted domain** - This issue is related to the trust level between domains. You might see the following error message: "Login failed. The login is from an untrusted domain and cannot be used with Windows authentication. (18452)."

  [Error 18452](/sql/relational-databases/errors-events/mssqlserver-18452-database-engine-error) indicates that the login uses Windows Authentication but the login is an unrecognized Windows principal. An unrecognized Windows principal indicates that the login can't be verified by Windows. This might occur because the Windows login is from an untrusted domain. The trust level between domains might cause failures in account authentication or the visibility of Service Provider Name (SPN)s.

- **No permissions for cross-domain groups** - Users from the [remote domain should belong to a group](../../../windows-server/windows-security/trust-between-windows-ad-domain-not-work-correctly.md) in the SQL Server domain. There might be a problem if you try to use a domain local group to connect to a SQL Server instance from another domain. If the domains lack proper trust, adding the users in a group in the remote domain might prevent the server from enumerating the group's membership.

- **Selective authentication is disabled** - Refers to a feature of domain trusts that allows the domain administrator to limit which users have access to resources in the remote domain. If selective authentication isn't enabled, all users in the trusted domain can get access to the remote domain. To resolve this issue, make sure that the users aren't allowed to authenticate in the remote domain by enabling selective authentication.

### [Kerberos authentication](#tab/kerberos)

This section lists the issues related to the Kerberos authentication:

- **An incorrect DNS suffix is appended to the NetBIOS name** - This can occur when you use only the NetBIOS name (for example, SQLPROD01) instead of the fully qualified domain name (FQDN) (for example, SQLPROD01.CONTOSO.COM). When this occurs, the wrong DNS suffix might be appended. Check the network settings for the default suffixes to make sure that they're correct, or use the FQDN to avoid issues.

- **Clock skew is too high** - This is a issue in which clocks on more than one device on a network aren't synchronized. For the Kerberos authentication to work, the clocks between devices can't be turned off for more than five minutes. If they aren't turned off, it might lead to consistent authentication failures.

- **Delegating sensitive accounts to other services** - Some accounts may be marked as Sensitive in AD. These accounts can't be delegated to another service in a double-hop scenario. Sensitive accounts are critical to providing security but can affect authentication. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

- **Delegating to a file share** - Refers to a situation in which a user or application delegates its credentials to access a file share. Without proper constraints, delegating credentials to a file share might create security risks. To resolve this kind of issue, make sure that you use constrained delegation.

- **Disjoint DNS namespace** - Refers to a consistent authentication issue that might occur if the DNS suffix doesn't match between the domain member and DNS. You might experience authentication issues if you use a disjoint namespace. If the organizational hierarchy in AD and in DNS don't match, the wrong SPN might be generated if you use the NETBIOS name in the database application connection string. In this situation, the SPN isn't found, and NTLM credentials are used instead of Kerberos credentials. To mitigate the issue, use the FQDN of the server or specify the SPN name in the connection string. For information about FQDN, see [Computer Naming](/windows-server/identity/ad-ds/plan/computer-naming).

- **Duplicate SPN** - Refers to a situation in which two or more SPNs are identical within a domain. SPNs are used to uniquely identify services running on servers in a Windows domain. There can be authentication issues when duplicates occur. For more information, see [Fix the error with Kerberos Configuration Manager (Recommended)](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

- **Enable HTTP ports on SPNs** - Typically, HTTP SPNs don't use port numbers (for example, `http/web01.contoso.com`). However, you can enable this usage through the policy on the clients. The SPN would then have to be in the `http/web01.contoso.com:88` format in order to enable Kerberos to function correctly. Otherwise, NTLM credentials are used. These aren't recommended because it would be difficult to diagnose the issue and this situation might generate excessive administrative overhead.

- **Expired tickets** - Refers to Kerberos tickets. Using expired Kerberos tickets can cause issues in authentication. For more information, see [Expired tickets](expired-tickets-issue.md).

- **HOSTS file is incorrect** - The HOSTS file can disrupt DNS lookups and might generate an unexpected SPN name. This situation causes NTLM credentials to be used. If an unexpected IP address is in the HOSTS file, the SPN that's generated might not match the back-end server that's pointed to.

- **Issue with per-service security identifier (SID) permissions** - Per-service-SID is a security feature of SQL Server that limits local connections to use New Technology LAN Manager (NTLM) and not Kerberos as the authentication method. The service can make a single hop to another server by using NTLM credentials, but it can't be delegated further without using the constrained delegation. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

- **Kernel-mode authentication** - The SPN on the App Pool account is typically required for web servers. However, when Kernel-mode authentication is used, the computer's HOST SPN is used for authentication. This action takes place in the kernel. This setting might be used if the server hosts many different websites that use the same host header URL, different App Pool accounts, and [Windows Authentication](/iis/configuration/system.webserver/security/authentication/).

- **Limit delegation rights to Access or Excel** - The Joint Engine Technology (JET) and Access Connectivity Engine (ACE) providers are similar to any of the file systems. You must use constrained delegation to enable SQL Server to read files that are located on another computer. In general, the ACE provider shouldn't be used in a linked server because this is explicitly not supported. The JET provider is deprecated and is available on 32-bit computers only.

- **Missing SPN** - This scenario might occur when an SPN that's related to a SQL Sever instance is absent. For more information, see [Fix the error with Kerberos Configuration Manager (Recommended)](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

- **Not a constrained target** - If constrained delegation is enabled for a particular service account, Kerberos will fail if the target server's SPN isn't on the list of targets of constrained delegation.

- **NTLM and constrained delegation** - If the target is a file share, the delegation type of the mid-tier service account must be **Constrained-Any** and not **Constrained-Kerberos**. If the delegation type is set to **Constrained-Kerberos**, the mid-tier account can allocate only to specific services, but **Constrained-Any** allows the service account to delegate to any service. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

- **Service account cannot be trusted for delegation in AD** - In a double-hop scenario, the service account of the mid-tier service must be trusted for delegation in AD. If the service account isn't trusted for delegation, Kerberos authentication can fail. If you're an administrator, enable the **Trusted for delegation** option.

- **Some legacy providers don't support Kerberos over Named Pipes** - The legacy OLE DB Provider (SQLOLEDB) and ODBC Driver (SQL Server) bundled with Windows don't offer support for Kerberos authentication over Named Pipes. Instead, they only support NTLM authentication. Use a TCP connection to allow Kerberos.

- **SPN is associated with a wrong account** - This issue might occur if an SPN is associated with the wrong account in AD. For more information, see [Fix the error with Kerberos Configuration Manager (Recommended)](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

   You might receive an error message if your SPN is configured on the wrong account in AD. To resolve the error, follow these steps:

    1. Use `SETSPN -Q spnName` to locate the SPN and its current account.
    1. Use `SETSPN -D` to delete the existing SPNs.
    1. Use the `SETSPN -S` to migrate it to the correct account.

- **SQL Alias might not function correctly** - A SQL Server alias might cause an unexpected SPN to be generated. This results in NTLM credentials failure if the SPN isn't found, or an SSPI failure, if it inadvertently matches the SPN of another server.

- **User belongs to many groups** - If a user belongs to multiple groups, this situation can cause authentication issues in Kerberos. If you use Kerberos over UDP, the entire security token must fit within a single packet. Users who belong to many groups have a larger security token than users who belong to fewer groups. If you use Kerberos over TCP, you can increase the [`MaxTokenSize`] setting. For more information, see [MaxTokenSize and Kerberos Token Bloat](/archive/blogs/shanecothran/maxtokensize-and-kerberos-token-bloat).

- **Use website host header** - If the website has a host header name, the HOSTS SPN can't be used. An explicit HTTP SPN must be used. If the website doesn't have a host header name, NTLM is used and it can't be delegated to a back-end SQL Server instance or other service.

### [NT LAN Manager (NTLM)](#tab/ntlm)

This section lists issues specific to NTLM (NT LAN Manager):

- **Access is denied for NTLM peer logins** - When communicating between computers that are either in workstations or in domains that don't trust one another, you can set up identical accounts on both computers and use NTLM peer authentication. Logins work only if both the user account and the password match on both computers. NTLM authentication might be disabled or not supported on either the client or server side, leading to authentication failures. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

- **Double hop scenarios on multiple computers** - A double-hop process will fail if NTLM credentials are used. Kerberos credentials are required. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

- **Loopback protection isn't set correctly** - Loopback protect is designed to prohibit applications from calling other services on the same computer. If loopback protect isn't configured correctly or if there's any malfunction, this situation can indirectly cause authentication issues. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

- **Loopback protection fails when you connect to the Always-on listener** - This issue is related to loopback protection. When connecting to the Always-On Listener from the primary node, the connection uses NTLM authentication. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

- **Issue that affects LANMAN compatibility level** - The LAN Manager (LANMAN) authentication issue usually occurs if there is a mismatch in the authentication protocols that are used by older (pre Windows 2008) and newer computers. When you set the compatibility level to 5, NTLMv2 isn't allowed. Switching to Kerberos avoids this issue because Kerberos is more secure. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

### [SQL Login](#tab/sqllogin)

This section lists issues related to authentication credentials:

- **Bad password** - Refers to a login-related issue. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-username-or-login-failed-for-user-domainusername).
  
- **Invalid username** - Refers to a login-related issue. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-username-or-login-failed-for-user-domainusername).
  
- **SQL Server logins are not enabled** - Refers to a scenario in which you try to connect to a Microsoft SQL Server instance by using SQL Server authentication, but the login that's associated with the account is disabled. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).
  
- **Named Pipes connections fail because the user doesn't have permission to log in to Windows** - Refers to a permissions issue in Windows. For more information, see [Named Pipes connections issue in SQL Server](named-pipes-connection-fail-no-windows-permission.md).

### [Windows permissions](#tab/windowspermissions)

This section lists issues specific to Windows permissions or Policy settings:

- **Access is granted through local groups** - If the user doesn't belong to a local group that's used to grant access to the server, the provider displays the "Login failed for user 'contoso/user1'" error message. The database administrator can check this situation by examining the **Security** > **Logins** folder in SQL Server Management Studio (SSMS). If the database is a contained database, check under `databasename`. For more information, see [Login failed for user '\<username\>' or login failed for user '\<domain\>\\<username\>'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

- **Credential guard is enabled** - This scenario indicates that the Credential Guard feature is enabled on a Windows system and is used to create a secure environment to store sensitive information. However, in certain situations, this feature might cause authentication issues. For more information, see [Considerations and known issues when using Credential Guard](/windows/security/identity-protection/credential-guard/considerations-known-issues).

- **Local security subsystem errors** - When you experience local security subsystem errors, particularly those linked to LSASS becoming unresponsive, it might indicate underlying issues with authentication. For more information, see [Local security subsystem errors in SQL Server](local-security-subsystem-errors.md).

- **Network login disallowed** - This scenario occurs when you try to log in to a network but your login request is denied for certain reasons. For more information, see [Troubleshooting the network login](network-login-disallowed.md) issue.

- **Only administrators can log in** - This issue occurs if the security log on a computer is full and doesn't have sufficient space to fill events. The security feature **[CrashOnAuditFail](/previous-versions/windows/it-pro/windows-2000-server/cc963220(v=technet.10))** is used by system administrators to check all security events. The valid values for `CrashOnAuditFail` are *0*, *1*, and *2*. If the key for `CrashOnAuditFail` is set to *2*, this means that the security log is full and the "Only Admins can login" error message is shown.

   To resolve this issue, follow these steps:

   1. Start Registry editor.
   1. Locate and check the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa!crashonauditfail` subkey to see whether the value is set to *2*. This value indicates that the security log requires manual clearing.
   1. Set the value to *0*, and then restart the server. You might also want to change the security log to enable events to roll over. For more information about how the setting affects all services such as SQL, IIS, file share, and login, see [Users cannot access Web sites when the security event log is full](../../../developer/webapps/iis/general/users-cannot-access-web-sites-when-log-full.md).

    > [!NOTE]
    > This issue affects only integrated logins. A Named Pipes connection will also be affected with a SQL Server Login because Named Pipes first logs in to Windows Admin Pipe before it connects to SQL Server.

- **Service account is not trusted for delegation** - This kind of issue usually occurs if a service account isn't allowed to assign credentials to other servers. This issue can affect services that require delegation. If a delegation scenario isn't enabled, check the SQL Server *secpol.msc* to determine whether the SQL Server service account is listed under the **Local Policies > User Rights Assignment > Impersonate a client after authentication** security policy settings. For more information, see [Enable computer and user accounts to be trusted for delegation](/windows/security/threat-protection/security-policy-settings/enable-computer-and-user-accounts-to-be-trusted-for-delegation).

- **Windows user profile can't be loaded in SQL Server** - Refers to the Windows user profile issue. For more information about how to troubleshoot corrupted user profiles, see the [Windows user profile can't be loaded in SQL Server](corrupt-user-profile.md).

### [Other aspects](#tab/otheraspects)

This section lists issues related to the authentication and access control within a web environment:

- **Integrated authentication isn't enabled** - Refers to a configuration issue where Integrated Windows Authentication (IWA) is not configured correctly. To resolve this issue, make sure that the **Integrated Windows Authentication** option is enabled in **Internet Options** settings.

- **IIS Authentication isn't allowed** - This issue occurs due to misconfigurations in the IIS. The authentication settings defined in the web.config file of the web application may conflict with the settings configured in IIS, leading to authentication issues. To resolve this issue, configure the website to enable Windows Authentication and set the `<identity impersonate="true"/>` value in the *Web.config* file.

- **Wrong Internet zone** - This might occur if you try to access a website that isn't in the correct Internet zone in Internet Explorer. The credentials won't work if the website is in the local Intranet zone.

[!INCLUDE [third-party-disclaimer](../../../includes/third-party-disclaimer.md)]