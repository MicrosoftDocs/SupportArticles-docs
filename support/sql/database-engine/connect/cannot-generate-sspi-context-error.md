---
title: Cannot generate SSPI context when connecting to SQL Server
description: Troubleshoots the cannot generate SSPI context error when you connect to SQL Server. Provides frequently asked questions and steps to fix the error.
ms.date: 12/20/2023
ms.custom: sap:Connection issues
author: HaiyingYu
ms.author: haiyingyu
---

# "Cannot generate SSPI context" error when using Windows authentication to connect SQL Server

_Applies to:_ &nbsp; SQL Server  
_Original KB number:_ 811889

> [!NOTE]
> Before you start troubleshooting, we recommend that you check the [prerequisites](../connect/resolve-connectivity-errors-checklist.md) and go through the checklist.

When you use Windows authentication to connect a SQL Server instance remotely, you receive the following error message:

> The target principal name is incorrect. Cannot generate SSPI context.

## Frequently asked questions

### What is SSPI?

[Security Support Provider Interface (SSPI)](/windows/win32/rpc/security-support-provider-interface-sspi-) is a set of Windows APIs that allows delegation and mutual authentication over any generic data transport layer, such as TCP/IP sockets. One or more software modules provide the actual authentication capabilities. Each module is called a Security Support Provider (SSP) and is implemented as a Dynamic Link Library (DLL).

### What is Kerberos?

Kerberos v5 protocol is an industry-standard security package and is one of the three security packages in Windows operating systems. For more information, see [Security Support Providers (SSPs)](/windows/win32/rpc/security-support-providers-ssps-).

### What does the "Cannot generate SSPI context" error mean?

This error means that SSPI tries but can't use Kerberos authentication to delegate client credentials through TCP/IP or Named Pipes to SQL Server. In most cases, a misconfigured Service Principal Name (SPN) causes this error.

### What is SPN?

A [Service Principal Names (SPN)](/windows/win32/ad/service-principal-names) is a unique identifier of a service instance. SPNs are used by [Kerberos authentication](/windows/win32/ad/mutual-authentication-using-kerberos) to associate a service instance with a service logon account. This association process allows a client application to request the service to authenticate an account even if the client doesn't have an account name.

For example, a typical SPN for a server that is running an instance of SQL Server is as follows:

`MSSQLSvc/SQLSERVER1.northamerica.corp.mycompany.com:1433`

The format of an SPN for a default instance is the same as an SPN for a named instance. The port number is what ties the SPN to a particular instance. For more information about registering SQL Server Service SPNs, see [Register a Service Principal Name for Kerberos Connections](/sql/database-engine/configure-windows/register-a-service-principal-name-for-kerberos-connections).

### Why does SSPI use NTLM or Kerberos authentication?

Windows authentication is the preferred method for users to authenticate to SQL Server. Clients that use Windows authentication are authenticated by using [NTLM](/windows-server/security/kerberos/ntlm-overview) or Kerberos.

When a SQL Server client uses integrated security over TCP/IP sockets to a remote server that's running SQL Server, the SQL Server client network library uses the SSPI API to perform security delegation. The SQL Server network client makes a call to the [AcquireCredentialsHandle](/windows/win32/secauthn/acquirecredentialshandle--schannel) function and passes in "negotiate" for the `pszPackage` parameter. This process notifies the underlying security provider to negotiate delegation. In this context, "negotiate" means to try Kerberos or NTLM authentication on Windows-based computers. In other words, Windows uses Kerberos delegation if the destination computer running SQL Server has an associated and correctly configured SPN. Otherwise, Windows uses NTLM delegation. If the SQL Server client is connecting locally on the same machine where SQL Server resides, NTLM is always used.

### Why doesn't the connection fail over to NTLM after running into issues with Kerberos?

The SQL Server driver code on the client uses the WinSock network API to resolve the fully qualified DNS of the server when the driver uses Windows authentication to connect to SQL Server. To perform this operation, the driver code calls the `gethostbyname` and `gethostbyaddr` WinSock APIs. If integrated security is used, the driver will try to resolve the server's fully qualified DNS even if an IP address or a host name is passed as the name of the server.

When the SQL Server driver on the client resolves the fully qualified DNS of the server, the corresponding DNS is used to form the SPN for the server. Therefore, issues resolving the IP address or the host name to a fully qualified DNS by WinSock may cause the SQL Server driver to create an invalid SPN for the server.

For example, the client-side SQL Server driver can be used as a fully qualified DNS to resolve invalid SPNs as follows:

- `MSSQLSvc/SQLSERVER1:1433`
- `MSSQLSvc/123.123.123.123:1433`
- `MSSQLSvc/SQLSERVER1.antartica.corp.mycompany.com:1433`
- `MSSQLSvc/SQLSERVER1.dns.northamerica.corp.mycompany.com:1433`

When the SQL Server driver forms an invalid SPN, authentication still works because the SSPI interface tries to look up the SPN in the Active Directory service. If the SSPI interface doesn't find the SPN, Kerberos authentication isn't performed. At that point, the SSPI layer switches to NTLM authentication mode, and the logon uses NTLM authentication and typically succeeds. If the SQL Server driver forms a valid SPN that isn't assigned to the appropriate container, the driver tries the SPN but can't use it. In this case, an error "Cannot generate SSPI context" may occur. If the SQL Server startup account is a local system account, the appropriate container is the computer name. For any other account, the appropriate container is the SQL Server startup account. Authentication uses the first SPN that it finds, so make sure that no SPNs are assigned to incorrect containers. In other words, each SPN must only be assigned to one container.

### How can I verify the authentication method of the connection?

To determine the authentication method of a connection, run the following query:

```sql
SELECT net_transport, auth_scheme   
FROM sys.dm_exec_connections   
WHERE session_id = @@SPID;  
```

For more information, see [Determine If I Am Connected to SQL Server using Kerberos Authentication](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Determine-If-I-Am-Connected-to-SQL-Server-using-Kerberos-Authentication).

### How to create SPNs for SQL Server?

When an instance of the SQL Server Database Engine starts, SQL Server tries to automatically register the SPN for the SQL Server service by using the [DsWriteAccountSpn](/windows/win32/api/ntdsapi/nf-ntdsapi-dswriteaccountspna) API. This call succeeds if the SQL Server service account has Read `servicePrincipalName` and Write `servicePrincipalName` rights in Active Directory. Otherwise, you'll need your Active Directory administrator to manually register the correct SPN by using Microsoft Kerberos Manager for SQL Server or the built-in [Setspn](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc731241(v=ws.11)) tool. For more information about managing SPNs for SQL Server, see [Register a Service Principal Name for Kerberos Connections](/sql/database-engine/configure-windows/register-a-service-principal-name-for-kerberos-connections#Permissions).

## Fix the error with Kerberos Configuration Manager (Recommended)

> [!NOTE]
> This procedure applies only to situations where you receive these error messages all the time, not intermittently.

There are various reasons why Kerberos connections fail, like misconfigured SPNs, name resolution issues, or insufficient rights for SQL Server service startup accounts. Microsoft Kerberos Configuration Manager (KCM) is a tool that can help check the causes of the error. KCM also provides options to fix any identified issues in the process.

Follow these steps to fix the error using KCM.

1. On the computer where you have the connectivity issues, download and install [Kerberos Configuration Manager](https://www.microsoft.com/download/details.aspx?id=39046).
1. Start _KerberosConfigMgr.exe_ from the _%SystemDrive%:\Program Files\Microsoft\Kerberos Configuration Manager_ folder. Then, use a domain account that has permissions to connect to the SQL Server computer you're unable to connect to.
1. Select **Connect**, leaving the server name and other details as applicable to your scenario blank if you're running KCM on the SQL Server computer. Select **Connect** to perform the analysis. After KCM finishes retrieving the necessary information, it automatically switches to the **SPN** tab and by default shows information for SQL Server, SQL Server Reporting Services, Analysis Services, and AG Listeners. To troubleshoot this error, uncheck everything except SQL Server.
1. Review the diagnosis from the tool by using the **Status** column and follow relevant steps to resolve the issue:

    |Status  |More information  |Action  |
    |---------|---------|---------|
    |Good     |   The checked item is configured properly. You can proceed to next item in the output.      |   No action necessary      |
    |Required SPN is missing     |   This status is reported when the SPN identified in the **Required SPN** column is missing for the SQL Server startup account in the Active Directory.      | 1. Select **Fix** to review the information in the **Warning** dialog box.<br/>2. Select **Yes** to add the missing SPN to Active Directory.<br/>3. If your domain account has the necessary permissions to update Active Directory, the required SPN will be added to Active Directory.<br/>4. If your domain account doesn't have necessary permissions to update Active Directory, use  **Generate** or **Generate All** to generate the script that will help the Active Directory administrator add the missing SPNs.<br/>5. After the SPNs are added, run Kerberos Configuration Manager again to verify that the SPN issues are resolved.<br/> 6. Additionally, you can use the following commands:<br/> - Use `SETSPN -Q spnName` to locate the SPN and its current accounts. <br/> - Use `SETSPN -D` to remove the SPN from the incorrect account.|
    |TCP must be enabled to use Kerberos configuration     | This occurs when TCP isn't enabled on the client computer.   | To enable TCP/IP protocol for the SQL Server instance, follow these steps:<br/>1. In SQL Server Configuration Manager, in the **console** pane, expand **SQL Server Network Configuration**.<br/>2. In the **console** pane, select **Protocols** for \<instance name\>.<br/>3. In the **details** pane, right-click **TCP/IP**, and then select **Enable**.<br/>4. In the **console** pane, select **SQL Server Services**.<br/>5. In the **details** pane, right-click SQL Server (\<instance name\>), and then select **Restart** to stop and restart the SQL Server service.<br/>For more information, see [Enable or Disable a Server Network Protocol](/sql/database-engine/configure-windows/enable-or-disable-a-server-network-protocol).        |
    |Dynamic Port     | This message shows up for named instances that use dynamic ports (default configuration). In environments where you need to use Kerberos to connect to SQL Server, you should set your named instance to a static port and use that port when registering SPN.         | To configure your SQL Server instance to use a static port, follow these steps:<br/>1. In SQL Server Configuration Manager, in the **console** pane, expand **SQL Server Network Configuration**, expand Protocols for \<instance name\>, and then double-click **TCP/IP**.<br/>2. In the **TCP/IP Properties** dialog box, review the **Listen All** setting on the **Protocol** tab.<br/>3. If the **Listen All** setting is set to **Yes**, switch to the **IP Addresses** tab and scroll to the bottom of the Windows to find the **IPAll** setting.  Delete the current value that is contained in the **TCP Dynamic Ports** and set the desired value in the **TCP Port** field. Select **OK** and restart the SQL Server instance for the settings to take effect.<br/>4. If the **Listen All** setting is set to **No**, switch to the **IP Addresses** tab and check each of the IP addresses that appear in the IP1, IP2. For enabled IP addresses, remove the current value contained in the **TCP Dynamic Ports** field and set the desired value in the **TCP Port** field. Select **OK** and restart the SQL Server instance for the settings to take effect.<br/>For more information, see [Configure a Server to Listen on a Specific TCP Port](/sql/database-engine/configure-windows/configure-a-server-to-listen-on-a-specific-tcp-port).    |
    |Duplicate SPN     |You can encounter the situation when the same SPN is registered under different accounts in Active Directory.        | 1. Select the **Fix** button, view the information in the **Warning** dialog box, and select **Yes** if you can add the missing SPN to Active Directory.<br/>2. If your domain account has the necessary permissions to update Active Directory, the incorrect SPN will be deleted.<br/>3. If your domain account doesn't have necessary permissions to update Active Directory, use the **Generate** or **Generate All** button to generate the necessary script that you can hand over to your Active Directory administrator to remove the duplicate SPNs. Once the SPNs are removed, rerun the KCM to verify that the SPN issues are resolved.|

    > [!NOTE]
    > If the domain account that starts KCM doesn't have privileges to manipulate SPNs in Active Directory, you can use the corresponding **Generate** or **Generate All** button under the **SPN script** column to generate the required commands and work with your Active Directory administrator to fix the issues that are identified by KCM.

1. After fixing all the issues identified in the KCM, rerun the tool. Ensure that no other issues are reported and then retry the connection. If the tool still reports issues, repeat the previous procedure.

## Fix the error without Kerberos Configuration Manager

If you can't use KCM, follow these steps:

### Step 1: Check name resolution with the ping command

The key factor that makes Kerberos authentication successful is the valid DNS functionality on the network. You can verify this functionality on the client and the server by using the `Ping` command prompt utility. On the client computer, run the following command to obtain the IP address of the server that is running SQL Server (where the name of the computer is `SQLServer1`):

`ping sqlserver1`

To see whether the Ping utility resolves the fully qualified DNS of `SQLServer1`, run the following command:

`ping -a <IPAddress>`

For example:

```output
C:\>ping SQLSERVER1

Pinging SQLSERVER1 [123.123.123.123] with 32 bytes of data:

Reply from 123.123.123.123: bytes=32 time<10ms TTL=128
Reply from 123.123.123.123: bytes=32 time<10ms TTL=128
Reply from 123.123.123.123: bytes=32 time<10ms TTL=128
Reply from 123.123.123.123: bytes=32 time<10ms TTL=128

Ping statistics for 123.123.123.123:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum =  0ms, Average =  0ms 
C:\>ping -a 123.123.123.123

Pinging SQLSERVER1.northamerica.corp.mycompany.com [123.123.123.123] with 32 bytes of data:

Reply from 123.123.123.123: bytes=32 time<10ms TTL=128
Reply from 123.123.123.123: bytes=32 time<10ms TTL=128
Reply from 123.123.123.123: bytes=32 time<10ms TTL=128
Reply from 123.123.123.123: bytes=32 time<10ms TTL=128
Ping statistics for 123.123.123.123:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum =  0ms, Average =  0ms

C:\> 
```

When the command `ping -a <IPAddress>` resolves to the correct fully qualified DNS of the computer that is running SQL Server, the client-side resolution is also successful.

For detailed diagnostics, use either [Test-NetConnection](/previous-versions/windows/powershell-scripting/dn372891(v=wps.630)) or [Test-Connection](/powershell/module/microsoft.powershell.management/test-connection) cmdlet to test TCP connectivity according to the PowerShell version that's installed on the computer. For more information on PowerShell cmdlet, see [Cmdlet Overview](/powershell/scripting/developer/cmdlet/cmdlet-overview).

> [!NOTE]
> Name resolution methods may include DNS, WINS, Hosts files, and Lmhosts files. For more information about name resolution problems and troubleshooting, review the following links:
>
> - [Troubleshooting TCP/IP](/previous-versions/tn-archive/bb727023(v=technet.10))
> - [Advanced troubleshooting for TCP/IP issues](/windows/client-management/troubleshoot-tcpip)

Check whether any aliases for the destination SQL Server exist in SQL Server Configuration Manager and in the SQL Server Client Network utility. If such an alias exists, ensure it's configured correctly by checking server names, network protocol, port number, and so on. A SQL [Server alias](network-related-or-instance-specific-error-occurred-while-establishing-connection.md) might cause an unexpected SPN to be generated. This will result in NTLM credentials if the SPN isn't found, or an SSPI failure, if it inadvertently matches the SPN of another server.

### Step 2: Verify communication between domains

Verify that the domain you sign in to can communicate with the domain of the server that's running SQL Server. There must also be correct name resolution in the domain.

1. Ensure you can sign in to Windows by using the same domain account and password as the SQL Server service startup account. For example, the SSPI error may occur in one of the following situations:

    - The domain account is locked out.
    - You didn't restart the SQL Server service after the password of the account was changed.

1. If your logon domain differs from the domain of the server that is running SQL Server, check the trust relationship between the domains.
1. Check whether the domain that the server belongs to and the domain account that you use to connect are in the same forest. This step is required for SSPI to work.

### Step 3: Verify SQL Server SPNs using SQLCHECK and Setspn tools

If you can sign in locally to the SQL Server computer and have administrator access, use [SQLCHECK](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK). SQLCheck provides most of the information required for troubleshooting in one file. For more information on how to use the tool and what information it gathers, review the tool's home page. You can also check the recommended [prerequisites](resolve-connectivity-errors-checklist.md) and checklist page. Once you generate the output file, review SPN configuration for your SQL Server instance under the **SQL Server Information** section of the output file.

Example output:

```output
Suggested SPN                                               Exists  Status              

----------------------------------------------------------  ------  ------------------- 

MSSQLSvc/testsqlsvr.corp.com:2000                           True    Okay                

MSSQLSvc/testsqlsvr.corp.com                                True    Okay                

MSSQLSvc/testsqlsvr:2000                                    False   SPN does not exist. 

MSSQLSvc/testsqlsvr                                         False   SPN does not exist. 
```

Use the output above to determine the next steps (see examples below) and use [Setspn tool](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc731241(v=ws.11)) to take necessary remedial actions to fix SPN issues.

|Scenario |Suggested action|
|-|-|
|SPN doesn't exist |Add the required SPN(s) for your SQL Server service account. |
|Duplicate SPNs |Delete the SPN that is registered for your SQL Service under the incorrect account. |
|SPN under incorrect account |Delete the registered SPN for your SQL Service under the incorrect account, and then register the SPN under the correct service account. |
  
> [!NOTE]
>
> - You can review the **SQL Server Information** section of SQLCHECK tool's output file to find the service account of your SQL Server instance.
>
> - Setspn is a built-in tool in newer versions of Windows that helps you read, add, modify, or delete SPNs in Active Directory. You can use this tool to verify that SQL Server SPNs are configured as per [Register a Service Principal Name for Kerberos Connections](/sql/database-engine/configure-windows/register-a-service-principal-name-for-kerberos-connections). For more information, see [Setspn tool](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc731241(v=ws.11)) and examples on how to use it.
>
> - For more information on scenarios where SQL Server automatically registers SPNs and where manual SPN registration is required, see [Register a Service Principal Name for Kerberos Connections](/sql/database-engine/configure-windows/register-a-service-principal-name-for-kerberos-connections).

### Step 4: Check account permission for SQL Server startup account on linked server

If you use **Impersonate** as the authentication option on the **Security** page of your linked server, SQL Server is required to pass incoming credentials to remote SQL Server. The SQL Server startup account where the linked server is defined should have the **Account is trusted for Delegation** right assigned to it in Active Directory. For more information, see [Enable computer and user accounts to be trusted for delegation](/windows/security/threat-protection/security-policy-settings/enable-computer-and-user-accounts-to-be-trusted-for-delegation).

> [!NOTE]
> This step is required only when you troubleshoot issues related to linked server queries.

## See also

- [Troubleshoot connectivity issues in SQL Server](resolve-connectivity-errors-overview.md)
- [Troubleshoot consistent authentication issues](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0400-Consistent-Authentication-Issue)
- [SSPI client tool](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SSPICLIENT)
- [Enable Kerberos event logging](../../../windows-server/identity/enable-kerberos-event-logging.md)
- [How to force Kerberos to use TCP instead of UDP in Windows](../../../windows-server/windows-security/force-kerberos-use-tcp-instead-udp.md)
