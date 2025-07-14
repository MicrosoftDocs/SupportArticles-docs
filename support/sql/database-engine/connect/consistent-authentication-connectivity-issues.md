---
title: Overview of consistent authentication issues in SQL Server
description: This article discusses consistent authentication issues in SQL Server, related error messages, and solutions to troubleshoot various issues.
ms.date: 04/08/2025
ms.reviewer: jopilov, aartigoyle, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Consistent authentication issues in SQL Server

_Applies to:_ &nbsp; SQL Server

> [!NOTE]
> The commands that are provided in this article apply to Windows systems only.

Consistent authentication issues that occur in Microsoft SQL Server are typically related to authentication and authorization of users or applications that try to access the SQL Server database. These issues can be authentication failures, access denied errors, or other security-related issues.

The key to effectively resolving consistent authentication issues is to understand the different error types and what each error message means. Some errors might appear in more than one authentication issue. You can use the troubleshooting information that's mentioned in the [Types of errors](#types-of-errors) section to resolve the error.

## Prerequisites

Before you start troubleshooting, work through the [prerequisites](../connect/resolve-connectivity-errors-checklist.md) checklist to have the following information ready:

- Install the [WireShark](https://www.wireshark.org/download.html) and [Problem Steps Recorder (PSR.exe)](/office/troubleshoot/settings/how-to-use-problem-steps-recorder) tools. For more information, see [Methods of collecting data for troubleshooting various types of errors](collect-data-to-troubleshoot-sql-connectivity-issues.md).

- Collect the Service Provider Name (SPN) information that's based on the service accounts. To do this, use the `SETSPN -L` command.

## Types of errors

This section describes error types and related information.

- **Directory services errors**: If the SQL Server error log file contains either or both of the following messages, then this error is related to Active Directory Domain Services (AD DS). This error might also occur if Windows on the SQL Server-based computer can't contact the Domain Controller (DC) or if the Local Security Authority Subsystem Service (LSASS) experiences an issue.

  ```output
   Error -2146893039 (0x80090311): No authority could be contacted for authentication.
   Error -2146893052 (0x80090304): The Local Security Authority cannot be contacted.
  ```

- **Login failed errors**: When you troubleshoot the "Login Failed" error, the SQL Server error log provides additional insights into error code 18456, including a specific state value that offers more context about the error. For more information, see the SQL Server error log file in [SQL state value](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#additional-error-information). You can try to fix the issue according to the description of the state value.

  The following table lists some specific "Login Failed" error messages and their possible causes and solutions.

  |Error message  |More information  |
  |---------|---------|
  |"A transport-level error has occurred when sending the request to the server."|Check whether the [linked server account mapping](linked-server-account-mapping-error.md) is correct. For more information, see [sp_addlinkedsrvlogin](/sql/relational-databases/system-stored-procedures/sp-addlinkedsrvlogin-transact-sql).|
  |"Cannot generate SSPI context" | <ul><li>The explicit SPN account might be [wrong](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended), missing, or misplaced.</li><li>Check whether the [SPN is on the wrong account](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).</li></ul> |
  |"Cannot open database \<test\> requested by the login. The login failed."|The database might be offline, or the permissions might not be sufficient. For more information, see [Database offline in MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).<br/> Also, check whether the database name in the connection string is correct.|
  |"Login failed for user \<username\>." | This error can occur if the [proxy account](../../integration-services/ssis-package-doesnt-run-when-called-job-step.md) isn't correctly authenticated.    |
  |"Login Failed for user: 'NT AUTHORITY\ANONYMOUS LOGON'"|This error might occur if the [SPN is missing, SPN is duplicated, or the SPN is on the wrong account](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).|
  |"Login failed for user \<username\>." </br> "Login failed for user '\<database\username\>"</br>    | Check whether an [the connection string contains an incorrect server name](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-username-or-login-failed-for-user-domainusername). Also, check whether the user belongs to a local group that's used to grant access to the server. For more causes, see [NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).    |
  |"Login failed for user '\<username\>'. Reason: Password did not match that for the login provided."|This error might occur if an incorrect password is used. For more information, see [Login failed for user '\<username\>' or login failed for user '\<domain>\<username>'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).|
  |"SQL Server does not exist or access denied."  | [Named Pipes connections](named-pipes-connection-fail-no-windows-permission.md) fail because the user doesn't have permission to log in to Windows.     |
  |"The login is from an untrusted domain and cannot be used with Windows authentication."|This error might be related to the [Local Security Subsystem](local-security-subsystem-errors.md) issues.|
  |"The user account is not allowed the Network Login type."|You might not be able to [log in to the network](network-login-disallowed.md).|

## Types of consistent authentication issues

This section describes typical causes of consistent authentication issues together with their respective solutions. Select the issue type to see the relevant issues, causes, and solutions.

<details>
<summary><b>Connection string</b></summary>

This section lists the issues that are related to configuration settings that are used by applications to connect to a database.

- **Explicit SPN is missing** - This issue occurs if the SPN isn't configured or registered correctly.

  **Solution:** To resolve this issue, see ["Cannot generate SSPI context" error when using Windows authentication to connect SQL Server](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

- **Explicit misplaced SPN** - Refers to an SPN that was incorrectly associated with a particular service or account.

  **Solution:** To resolve this issue, see [Explicit misplaced SPN](explicit-spn-is-misplaced.md).

- **Explicit SPN is duplicated** - This issue occurs if an SPN is duplicated because it's registered more than one time.

  **Solution:** To resolve this issue, see ["Cannot generate SSPI context" error when using Windows authentication to connect SQL Server](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

- **Incorrect server name in connection string** - This issue occurs if the specified server name is incorrect or can't be found.

  **Solution:** To resolve this issue, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-username-or-login-failed-for-user-domainusername).

- **Wrong database name in connection string** - This issue occurs if the database name that's provided for authentication is incorrect.

  **Solution:** Check whether the name is spelled correctly. For more information, see [MSSQLSERVER_4064](/sql/relational-databases/errors-events/mssqlserver-4064-database-engine-error#fix-the-issue).

- **Wrong explicit SPN account** - This issue might occur if the SPN is associated with the wrong account in AD DS.

  **Solution:** To resolve this issue, see [Cannot generate SSPI context error](cannot-generate-sspi-context-error.md).

</details>

<details>
<summary><b>Database</b></summary>

This section lists the issues that are specific to various aspects of SQL Server:

- **Database is offline** - Refers to a scenario in which a SQL Server database tries to reconnect to a SQL Server instance that's configured for Windows Authentication mode.

  **Solution:** For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-username-or-login-failed-for-user-domainusername).
  
- **Database permissions** - Refers to enabling or restricting access to a SQL Server database.

  **Solution:** For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-username-or-login-failed-for-user-domainusername).
  
- **Linked server connectivity errors in SQL Server** - You experience an authentication process issue that affects linked servers in the context of SQL Server.

  **Solution:** To resolve this issue, see [Linked server connectivity errors in SQL Server](linked-server-account-mapping-error.md).

- **Metadata of the linked server is inconsistent** - Refers to an issue in which metadata of the linked server is inconsistent or doesn't match the expected metadata.

  A view or stored procedure queries the tables or views in the linked server but receives login failures even though a distributed `SELECT` statement that's copied from the procedure doesn't.

  This issue might occur if the view was created and then the linked server was re-created, or a remote table was modified without rebuilding the View.

  **Solution**: Refresh the metadata of the linked server by running the `sp_refreshview` stored procedure.

- **Proxy account doesn't have permissions** - A SQL Server Integration Service (SSIS) job that's run by SQL Agent might require permissions other than those that the SQL Agent service account can provide.

  **Solution:** To resolve this issue, see [SSIS package does not run when called from a SQL Server Agent job step](../../integration-services/ssis-package-doesnt-run-when-called-job-step.md).

- **Unable to log in to SQL Server database** - The inability to log in can cause failures in authentication.

  **Solution:** To resolve this issue, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-username-or-login-failed-for-user-domainusername).
  
</details>

<details><summary><b>Directory services</b></summary>

This section lists the issues that are related to directory services and servers.

- **An account is disabled** - You might experience this scenario if the user account was disabled by an administrator or by a user. In this case, you can't log in by using this account or you can't use this account to start a service. This might cause consistent authentication issues because it can prevent you from accessing resources or performing actions that require authentication.

  **Solution:** A domain administrator can fix this by re-enabling the account. When an account is disabled, it's usually because either a user tried to log in with the wrong password too many times or because an application or service is trying to use an old password.

- **An account isn't in the group** - This issue might occur if a user is trying to access a resource that's restricted to a specific group.

  **Solution:** Check the SQL logins to enumerate allowed groups and make sure that the user belongs to one of the groups.

- **Account migration failed** - If old user accounts can't connect to the server but newly created accounts can, account migration might not be correct. This issue is related to AD DS.

  **Solution:** For more information, see [Transfer logins and passwords between instances of SQL Server](../security/transfer-logins-passwords-between-instances.md).

- **Domain Controller is offline** - Refers to an issue where the domain controller isn't accessible.

  **Solution:** Use the `nltest` command to force the computer to switch to another domain controller. For more information, see [Active Directory replication Event ID 2087: DNS lookup failure caused replication to fail](../../../windows-server/identity/active-directory-replication-event-id-2087.md).

- **Firewall blocks the Domain Controller** - You might experience issues when you manage the user's access to resources.

  **Solution:** Make sure that the domain controller is accessible from the client or the server. To do this, use the `nltest /SC_QUERY:CONTOSO` command.

- **Login is from an untrusted domain** - This issue is related to the trust level between domains. You might see the following error message: "Login failed. The login is from an untrusted domain and cannot be used with Windows authentication. (18452)."

  [Error 18452](/sql/relational-databases/errors-events/mssqlserver-18452-database-engine-error) indicates that the login uses Windows Authentication but the login is an unrecognized Windows principal. An unrecognized Windows principal indicates that the login can't be verified by Windows. This might occur because the Windows login is from an untrusted domain. The trust level between domains might cause failures in account authentication or the visibility of Service Provider Name (SPN)s.

  **Solution:** To resolve this issue, see [MSSQLSERVER_18452](/sql/relational-databases/errors-events/mssqlserver-18452-database-engine-error#user-action).

- **No permissions for cross-domain groups** - Users from the [remote domain should belong to a group](../../../windows-server/windows-security/trust-between-windows-ad-domain-not-work-correctly.md) in the SQL Server domain. There might be a problem if you try to use a domain local group to connect to a SQL Server instance from another domain.

  **Solution:** If the domains lack proper trust, adding the users in a group in the remote domain might prevent the server from enumerating the group's membership.

- **Selective authentication is disabled** - Refers to a feature of domain trusts that allows the domain administrator to limit which users have access to resources in the remote domain. If selective authentication isn't enabled, all users in the trusted domain can get access to the remote domain.

  **Solution:** To resolve this issue, enable selective authentication to make sure that the users aren't allowed to authenticate in the remote domain.

</details>

<details><summary><b>Kerberos authentication</b></summary>

This section lists the issues that are related to the Kerberos authentication:

- **An incorrect DNS suffix is appended to the NetBIOS name** - This issue might occur if you use only the NetBIOS name (for example, SQLPROD01) instead of the fully qualified domain name (FQDN) (for example, SQLPROD01.CONTOSO.COM). When this occurs, the wrong DNS suffix might be appended.

  **Solution:** Check the network settings for the default suffixes to make sure that they're correct, or use the FQDN to avoid issues.

- **Clock skew is too high** - This issue might occur if multiple devices on a network aren't synchronized. For the Kerberos authentication to work, the clocks between devices can't be turned off for more than five minutes or consistent authentication failures might occur.

  **Solution:** Set up the computers to regularly synchronize their clocks with a central time service.

- **Delegating sensitive accounts to other services** - Some accounts might be marked as `Sensitive` in AD DS. These accounts can't be delegated to another service in a double-hop scenario. Sensitive accounts are critical to providing security, but they can affect authentication.

  **Solution:** To resolve this issue, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

- **Delegating to a file share** - Refers to a situation in which a user or application delegates its credentials to access a file share. Without appropriate constraints, delegating credentials to a file share might create security risks.

  **Solution:** To resolve this kind of issue, make sure that you use [constrained delegation](https://techcommunity.microsoft.com/t5/sql-server-support-blog/bulk-insert-and-kerberos/ba-p/317304).

- **Disjoint DNS namespace** - Refers to a consistent authentication issue that might occur if the DNS suffix doesn't match between the domain member and DNS. You might experience authentication issues if you use a disjoint namespace. If the organizational hierarchy in AD DS and in DNS don't match, the wrong SPN might be generated if you use the NETBIOS name in the database application connection string. In this situation, the SPN isn't found, and New Technology LAN Manager (NTLM) credentials are used instead of Kerberos credentials.

  **Solution:** To mitigate the issue, use the FQDN of the server or specify the SPN name in the connection string. For information about FQDN, see [Computer Naming](/windows-server/identity/ad-ds/plan/computer-naming).

- **Duplicate SPN** - Refers to a situation in which two or more SPNs are identical within a domain. SPNs are used to uniquely identify services that are running on servers in a Windows domain. Duplicate SPNs can cause authentication issues.

  **Solution:** To resolve this issue, see [Fix the error with Kerberos Configuration Manager (Recommended)](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

- **Enable HTTP ports on SPNs** - Typically, HTTP SPNs don't use port numbers (for example, `http/web01.contoso.com`).

  **Solution:** To resolve this issue, you can enable this by using the policy on the clients. The SPN would then have to be in the `http/web01.contoso.com:88` format in order to enable Kerberos to function correctly. Otherwise, NTLM credentials are used.

  NTLM credentials aren't recommended because they might make it difficult to diagnose the issue. Also, this situation might generate excessive administrative overhead.

- **Expired tickets** - Refers to Kerberos tickets. Using expired Kerberos tickets can cause authentication issues.

  **Solution:** To resolve this issue, see [Expired tickets](expired-tickets-issue.md).

- **HOSTS file is incorrect** - The HOSTS file can disrupt DNS lookups and might generate an unexpected SPN name. This situation causes NTLM credentials to be used. If an unexpected IP address is in the HOSTS file, the SPN that's generated might not match the back-end server that's pointed to.

  **Solution:** Review the HOSTS file and remove the entries for your server. HOSTS file entries are shown in the SQLCHECK report.

- **Issue with per-service security identifier (SID) permissions** - Per-service-SID is a security feature of SQL Server that limits local connections to use NTLM and not Kerberos as the authentication method. The service can make a single hop to another server by using NTLM credentials, but it can't be delegated further without using the constrained delegation. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

  **Solution:** To resolve this issue, the domain administrator needs to set up constrained delegation.

- **Kernel-mode authentication** - The SPN on the App Pool account is typically required for web servers. However, when Kernel-mode authentication is used, the computer's HOST SPN is used for authentication. This action takes place in the kernel. This setting might be used if the server hosts many different websites that use the same host header URL, different App Pool accounts, and [Windows Authentication](/iis/configuration/system.webserver/security/authentication/).

  **Solution:** Remove the HTTP SPNs if Kernel-mode authentication is enabled.

- **Limit delegation rights to Access or Excel** - The Joint Engine Technology (JET) and Access Connectivity Engine (ACE) providers are similar to any of the file systems. You must use constrained delegation to enable SQL Server to read files that are located on another computer. In general, the ACE provider shouldn't be used in a linked server because this is explicitly not supported. The JET provider is deprecated and is available on 32-bit computers only.

  > [!NOTE]
  > When SQL Server 2014, the last version to support 32-bit installations, goes out of support, the JET scenario will no longer be supported.

- **Missing SPN** - This issue might occur if an SPN that's related to a SQL Sever instance is absent.

  **Solution:** For more information, see [Fix the error with Kerberos Configuration Manager (Recommended)](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

- **Not a constrained target** - If constrained delegation is enabled for a particular service account, Kerberos will fail if the target server's SPN isn't on the list of targets of constrained delegation.
  
  **Solution:** To resolve this issue, a domain administrator must add the target server's SPN to the target SPNs of the mid-tier service account.

- **NTLM and constrained delegation** - If the target is a file share, the delegation type of the mid-tier service account must be **Constrained-Any** and not **Constrained-Kerberos**. If the delegation type is set to **Constrained-Kerberos**, the mid-tier account can allocate only to specific services, but **Constrained-Any** allows the service account to delegate to any service.

  **Solution:** To resolve this issue, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

- **Service account cannot be trusted for delegation in AD** - In a double-hop scenario, the service account of the mid-tier service must be trusted for delegation in AD DS. If the service account isn't trusted for delegation, Kerberos authentication can fail.

  **Solution:** If you're an administrator, enable the **Trusted for delegation** option.

- **Some legacy providers don't support Kerberos over Named Pipes** - The legacy OLE DB provider (SQLOLEDB) and ODBC provider (SQL Server) that are bundled with Windows don't offer support for Kerberos authentication over Named Pipes. Instead, they support only NTLM authentication.

  **Solution:** Use a TCP connection to allow Kerberos authentication. You can also use a newer driver, example, MSOLEDBSQL or ODBC Driver 17. But TCP is still preferred over Named Pipes, regardless of version of the driver.

- **SPN is associated with a wrong account** - This issue might occur if an SPN is associated with the wrong account in AD DS. For more information, see [Fix the error with Kerberos Configuration Manager (Recommended)](cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

   You might receive an error message if your SPN is configured on the wrong account in AD DS.

   **Solution:** To resolve the error, follow these steps:

    1. Use `SETSPN -Q spnName` to locate the SPN and its current account.
    1. Use `SETSPN -D` to delete the existing SPNs.
    1. Use the `SETSPN -S` to migrate the SPN to the correct account.

- **SQL Alias might not function correctly** - A SQL Server alias might cause an unexpected SPN to be generated. This causes NTLM credentials to fail if the SPN isn't found, or an SSPI failure if it inadvertently matches the SPN of another server.

  **Solution:** SQL Aliases are shown in the SQLCHECK report. To resolve the issue, identify and correct any incorrect or misconfigured SQL aliases so that they point to the correct SQL Server.

- **User belongs to many groups** - If a user belongs to multiple groups, authentication issues might occur in Kerberos. If you use Kerberos over UDP, the entire security token must fit within a single packet. Users who belong to many groups have a larger security token than users who belong to fewer groups.

  **Solution:** If you use Kerberos over TCP, you can increase the [`MaxTokenSize`] setting. For more information, see [MaxTokenSize and Kerberos Token Bloat](/archive/blogs/shanecothran/maxtokensize-and-kerberos-token-bloat).

- **Use website host header** - The HTTP Host header plays a very important role in the HTTP protocol for accessing web pages.

  **Solution:** If the website has a host header name, the HOSTS SPN can't be used. An explicit HTTP SPN must be used. If the website doesn't have a host header name, NTLM is used. NTLM can't be delegated to a back-end SQL Server instance or other service.

</details>

<details><summary><b>NT LAN Manager (NTLM)</b></summary>

This section lists issues that are specific to NTLM (NT LAN Manager):

- **Access is denied for NTLM peer logins** - Refers to an issue that are related to NTLM peer logins.

  **Solution:** When communicating between computers that are in either workstations or domains that don't trust each other, you can set up identical accounts on both computers and use NTLM peer authentication.
  
  Logins work only if both the user account and the password match on both computers. NTLM authentication might be disabled or not supported on either the client or server side. This situation might cause authentication failures. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

- **Double hop scenarios on multiple computers** - A double-hop process will fail if NTLM credentials are used. Kerberos credentials are required.

  **Solution:** To resolve this issue, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

- **Loopback protection isn't set correctly** - Loopback protect is designed to prohibit applications from calling other services on the same computer. If loopback protect isn't configured correctly, or if there's any malfunction, this situation can indirectly cause authentication issues.

  **Solution:** To resolve this issue, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

- **Loopback protection fails when you connect to the Always-on listener** - This issue is related to loopback protection. When you connect to the Always-On Listener from the primary node, the connection uses NTLM authentication.

  **Solution:** For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

- **Issue that affects LANMAN compatibility level** - The LAN Manager (LANMAN) authentication issue usually occurs if a mismatch exists in the authentication protocols that are used by older (pre-Windows Server 2008) and newer computers. When you set the compatibility level to 5, NTLMv2 isn't allowed.

  **Solution:** Switching to Kerberos avoids this issue because Kerberos is more secure. For more information, see [Login failed for user NT AUTHORITY\ANONYMOUS LOGON](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

</details>

<details><summary><b>SQL Login</b></summary>

This section lists issues that are related to authentication credentials:

- **Bad password** - Refers to a login-related issue.

  **Solution:** To resolve this issue, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-username-or-login-failed-for-user-domainusername).
  
- **Invalid username** - Refers to a login-related issue.

  **Solution:** To resolve this issue, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-username-or-login-failed-for-user-domainusername).
  
- **SQL Server logins are not enabled** - Refers to a scenario in which you try to connect to a Microsoft SQL Server instance by using SQL Server authentication, but the login that's associated with the account is disabled.

  **Solution:** To resolve this issue, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).
  
- **Named Pipes connections fail because the user doesn't have permission to log in to Windows** - Refers to a permissions issue in Windows.

  **Solution:** To resolve this issue, see [Named Pipes connections issue in SQL Server](named-pipes-connection-fail-no-windows-permission.md).

</details>

<details><summary><b>Windows permissions</b></summary>

This section lists issues that are specific to Windows permissions or policy settings:

- **Access is granted through local groups** - If the user doesn't belong to a local group that's used to grant access to the server, the provider displays the "Login failed for user 'contoso/user1'" error message.

  **Solution:** The database administrator can check this situation by examining the **Security** > **Logins** folder in SQL Server Management Studio (SSMS). If the database is a contained database, check under `databasename`. For more information, see [Login failed for user '\<username\>' or login failed for user '\<domain\>\\<username\>'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error#login-failed-for-user-nt-authorityanonymous-logon).

- **Credential guard is enabled** - This scenario indicates that the Credential Guard feature is enabled on a Windows system and is used to create a secure environment to store sensitive information. However, in certain situations, this feature might cause authentication issues.

  **Solution:** To resolve this issue, ask a domain administrator to set up constrained delegation. For more information, see [Considerations and known issues when using Credential Guard](/windows/security/identity-protection/credential-guard/considerations-known-issues).

- **Local security subsystem errors** - When you experience local security subsystem errors, particularly those that are linked to LSASS becoming unresponsive, it might indicate underlying issues that affect authentication.

  **Solution:** To resolve these errors, see [Local security subsystem errors in SQL Server](local-security-subsystem-errors.md).

- **Network login disallowed** - This scenario occurs when you try to log in to a network but your login request is denied for certain reasons.

  **Solution:** To resolve this issue, see [User doesn't have permissions to log in to the network](network-login-disallowed.md).

- **Only administrators can log in** - This issue occurs if the security log on a computer is full and doesn't have sufficient space to fill events. The security feature, **[CrashOnAuditFail](/previous-versions/windows/it-pro/windows-2000-server/cc963220(v=technet.10))**, is used by system administrators to check all security events. The valid values for `CrashOnAuditFail` are *0*, *1*, and *2*. If the key for `CrashOnAuditFail` is set to *2*, this means that the security log is full and the "Only Admins can login" error message is shown.

   **Solution:** To resolve this issue, follow these steps:

   1. Start Registry editor.
   1. Locate and check the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa!crashonauditfail` subkey to see whether the value is set to *2*. This value indicates that the security log requires manual clearing.
   1. Set the value to *0*, and then restart the server. You might also want to change the security log to enable events to roll over. For more information about how the setting affects all services such as SQL, IIS, file share, and login, see [Users cannot access Web sites when the security event log is full](../../../developer/webapps/iis/general/users-cannot-access-web-sites-when-log-full.md).

    > [!NOTE]
    > This issue affects only integrated logins. A Named Pipes connection will also be affected in a SQL Server login because Named Pipes first logs in to Windows Admin Pipe before it connects to SQL Server.

- **Service account is not trusted for delegation** - This kind of issue usually occurs if a service account isn't allowed to assign credentials to other servers. This issue can affect services that require delegation.

  **Solution:** If a delegation scenario isn't enabled, check the SQL Server *secpol.msc* to determine whether the SQL Server service account is listed under the **Local Policies > User Rights Assignment > Impersonate a client after authentication** security policy settings. For more information, see [Enable computer and user accounts to be trusted for delegation](/windows/security/threat-protection/security-policy-settings/enable-computer-and-user-accounts-to-be-trusted-for-delegation).

- **Windows user profile can't be loaded in SQL Server** - Refers to the Windows user profile issue.

  **Solution:** For more information about how to troubleshoot corrupted user profiles, see [Windows user profile can't be loaded in SQL Server](corrupt-user-profile.md).

</details>

<details><summary><b>Other aspects</b></summary>

This section lists issues that are related to the authentication and access control within a web environment:

- **Integrated authentication isn't enabled** - Refers to a configuration issue in which Integrated Windows Authentication (IWA) is not configured correctly.

  **Solution:** To resolve this issue, make sure that the **Integrated Windows Authentication** option is enabled in **Internet Options** settings.

- **IIS Authentication isn't allowed** - This issue occurs because of misconfigurations in IIS. The authentication settings that are defined in the Web.config file of the web application might conflict with the settings that are configured in IIS. This situation can cause authentication issues.

  **Solution:** To resolve this issue, configure the website to enable Windows Authentication and set the `<identity impersonate="true"/>` value in the *Web.config* file.

- **Wrong Internet zone** - This issue might occur if you try to access a website that isn't in the correct Internet zone in Internet Explorer. The credentials won't work if the website is in the local Intranet zone.

  **Solution:** Add the web server to IE's local intranet zone.

</details>

[!INCLUDE [third-party-disclaimer](../../../includes/third-party-disclaimer.md)]

## More information

[Collect data to troubleshoot SQL Server connectivity issues](collect-data-to-troubleshoot-sql-connectivity-issues.md)