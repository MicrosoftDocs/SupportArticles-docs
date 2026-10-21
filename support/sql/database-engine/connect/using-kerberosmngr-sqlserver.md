---
title: Use Kerberos Configuration Manager Tool for SQL Server Issues
description: Learn how to use Kerberos Configuration Manager for SQL Server to find and fix SPN, delegation and connectivity errors.
ms.reviewer: jopilov
ms.date: 10/20/2026
ms.custom: sap:Database Connectivity and Authentication
ai-usage: ai-assisted
---

# Use Kerberos Configuration Manager to diagnose Kerberos issues in SQL Server

_Applies to:_&nbsp;SQL Server

_Original KB number:_ 2985455

## Summary

Use Kerberos Configuration Manager for SQL Server to diagnose and fix Kerberos configuration problems that cause SQL Server connection failures. The tool scans SQL Server, SQL Server Reporting Services (SSRS), and SQL Server Analysis Services (SSAS) instances, and reports missing or duplicate Service Principal Names (SPNs) and delegation issues. It can also generate a script or apply the fix for you. This article explains how to download the tool, which permissions it needs, and how to interpret its output.

> [!NOTE]
> Kerberos Configuration Manager is provided as-is, and no technical support or updates are offered for it. It wasn't updated to use the SQL Server 2022 and later versions of the Windows Management Instrumentation (WMI) provider. To troubleshoot and diagnose Kerberos configuration issues for these versions, use [SQLCheck](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK).

## What Kerberos Configuration Manager does

Kerberos Configuration Manager can do the following tasks:

- Collect information about the operating system, SQL Server instances, and Always On availability group listeners that are installed on a server.
- Report all SPN and delegation configurations on the server.
- Identify potential problems in SPNs and delegations.
- Fix potential SPN problems.

## Errors that Kerberos Configuration Manager helps troubleshoot

Use this tool to troubleshoot the following errors:

- HTTP 401 errors, SSRS errors, and other similar errors
- Cannot generate SSPI context. For more information, see [Fix "Cannot generate SSPI context" error in SQL Server](cannot-generate-sspi-context-error.md).
- Login failed for user 'NT AUTHORITY\ANONYMOUS LOGON'
- Login failed for user '(null)'
- Login failed for user (empty)

Before you start troubleshooting, review the [prerequisites and checklist for resolving connectivity errors](resolve-connectivity-errors-checklist.md).

If you have administrator access to the SQL Server computer, you can also run [SQLCheck](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK) (the SQL Connectivity Settings Check tool) on that computer. Review its output to check the SPN configuration of your SQL Server instance.

## Download Kerberos Configuration Manager

Download the tool from the Microsoft Download Center:

[Microsoft Kerberos Configuration Manager for SQL Server](https://www.microsoft.com/download/details.aspx?id=39046).

You can download and install the tool on any computer in your domain that can connect to the SQL Server computer. Make sure to review the supported versions and system requirements in the Download Center page.

## Permissions required to run Kerberos Configuration Manager

To troubleshoot connectivity issues that affect SQL Server, SSRS, and SSAS, connect to the destination computer (the computer that hosts the service) by using a domain user account that has administrative permissions on that computer.

**Optional**: If you want to use the tool to fix SPN issues that it identifies, the domain account must have the **Validated write to service principal name** permission.

## Start Kerberos Configuration Manager and connect to a server

After the installation finishes, start the *KerberosConfigMgr.exe* binary from the installation folder. By default, the location is *C:\Program Files\Microsoft\Kerberos Configuration Manager for SQL Server*.

For information about how to start an app as an administrator or a different user, see [Use Run to start an app as an admin](../../../windows-server/shell-experience/use-run-as-start-app-admin.md).

Use one of the following options to connect:

- **Connect to a remote SQL Server computer**: Enter the appropriate values for **Server Name**, **Domain User Name**, and **Password**.

  > [!NOTE]
  > The tool uses a Windows API to query and display Kerberos configuration information for the SQL Server computer. Always enter the name of the computer that hosts the SQL Server instance, even if you're troubleshooting Kerberos-related issues for a named instance.

- **Connect to a local server**: Select **Connect** to analyze your Kerberos configuration. You don't have to specify the server name, domain user name, or password.

  > [!NOTE]
  > The account that starts the tool must be a local administrator account. For information about how to start an app as an administrator or a different user, see [Use Run to start an app as an admin](../../../windows-server/shell-experience/use-run-as-start-app-admin.md).

## Tabs and commands in Kerberos Configuration Manager

After the connection succeeds, the tool shows all the related SPNs, as shown in the following screenshot.

:::image type="content" source="media/using-kerberos-config-mngr/basic-system-information.png" alt-text="Screenshot of a view of all three tabs in Kerberos Configuration Manager.":::

The tool has the following tabs:

- **System**: Displays the user information and machine information.
- **SPN**: Displays the SPN information about each SQL Server instance that the tool finds on the target server. It also provides details such as the required SPN and its status. Each row has **Generate** and **Fix** buttons.
- **Delegation**: Identifies issues that affect the service account's configuration for delegation.

### Generate an SPN generation script

Use **Generate** on the **SPN** tab to find missing SPNs and create a script that you can run at a command prompt:

1. On the **SPN** tab, in the **SPN Script** column, select **Generate** for the SPN that you want to script.
1. In the dialog box that opens, provide a name (in this example, *generateSPNss*), set **Save as type** to *Kerberos Config Mgr (.cmd)*, and then select **Save**.

   :::image type="content" source="media/using-kerberos-config-mngr/create-the-spn-generation-script.png" alt-text="Screenshot of the dialog box to provide a name for the CMD file.":::

The tool creates the *generateSPNss.cmd* file. The content of the file resembles the following example:

```output
:: This script is generated by the Microsoft&reg; SQL Server&reg; Kerberos Configuration Manager tool.

:: The script may update the system information, SPN settings and Delegation configurations of a given server.

:: SPN and Delegation configuration updates require Windows Domain Administrator permission to execute.

:: A Domain Admin should review the configurations recommended by this tool and take appropriate actions to enable Kerberos authentication.

:: Please contact Microsoft Support if Kerberos connection problem persists.

:: The file is intended to be run in domain `<DomainName>.com`"

:: Corrections for MSSQLSvc/`<HostName>.<DomainName>.com` **SetSPN -s MSSQLSvc/`<HostName>`. `<DomainName>`.com UserName**
```

Use **SetSPN** to create an SPN under the service account for SQL Server.

### Fix SPN issues

On the **SPN** tab, use **Fix** to fix issues and add SPNs. You can add an SPN only if you have the required permissions. When you select **Fix**, the tool displays the following tooltip:

:::image type="content" source="media/using-kerberos-config-mngr/fix-option-add-spn.png" alt-text="Screenshot of the Fix option to add SPN.":::

> [!NOTE]
> The tool provides the **Fix** and **Generate** commands only for default instances and named instances that have static ports. For named instances that use dynamic ports, we recommend that you switch from dynamic to static ports, or provide the service account with the permissions to register and unregister the SPN every time that the SQL Server service starts. Otherwise, you have to manually unregister and re-register the corresponding SPNs whenever the service starts. For more information, see [Register a Service Principal Name for Kerberos connections](/sql/database-engine/configure-windows/register-a-service-principal-name-for-kerberos-connections).

### Check delegation settings

Use **Delegation** to identify issues that affect the service account's configuration for delegation. This option is especially useful for troubleshooting linked server issues. For example, if the SPN check passes but linked server queries still fail, the service account might not be configured to delegate credentials. For more information, see [Linked servers (Database Engine)](/sql/relational-databases/linked-servers/linked-servers-database-engine) and [Connectivity issues with linked servers in SQL Server authentication](linked-server-account-mapping-error.md).

:::image type="content" source="media/using-kerberos-config-mngr/delegation-tab.png" alt-text="Screenshot of the Delegation tab.":::

## Interpret and act on the Kerberos Configuration Manager diagnosis

Review the diagnosis from the tool by checking the **Status** column. Based on the status, follow the appropriate steps to resolve the issue. The following sections describe each status.

### Status: Good

**More information**: The checked item is configured correctly. Go to the next item in the output.

**Action**: No action is required.

### Status: Required SPN is missing

**More information**: This status appears if the SPN that's listed in the **Required SPN** column is missing for the SQL Server startup account in Active Directory.

**Action**: Follow these steps to add the missing SPN and verify that the issue is resolved:

1. Select **Fix** to review the information in the **Warning** dialog box.
1. Select **Yes** to add the missing SPN to Active Directory.
   - If your domain account has the necessary permissions to update Active Directory, the tool adds the required SPN to Active Directory.
   - If your domain account doesn't have the necessary permissions to update Active Directory, use **Generate** or **Generate All** to generate a script that helps the Active Directory administrator add the missing SPNs.
1. After the SPNs are added, run Kerberos Configuration Manager again to verify that the SPN issues are resolved.

### Status: TCP must be enabled to use Kerberos configuration

**More information**: This status appears if TCP isn't enabled on the client computer.

**Action**: Follow these steps to enable the TCP/IP protocol for the SQL Server instance:

1. In **SQL Server Configuration Manager - Console**, expand **SQL Server Network Configuration**.
1. In **Console**, select **Protocols** for `<instance name>`.
1. In **Details**, select **TCP/IP**, and then select **Enable**.
1. In **Console**, select **SQL Server Services**.
1. In **Details**, select **SQL Server** for `<instance name>`.
1. Select **Restart** to stop and restart the SQL Server service. For more information, see the "Enable or disable a server network protocol" section in [Enable or disable a server network protocol](/sql/database-engine/configure-windows/enable-or-disable-a-server-network-protocol).

### Status: Dynamic Port

**More information**: This status appears for named instances that use dynamic ports (the default configuration). In environments where you need Kerberos to connect to SQL Server, set your named instance to use a static port, and use that port when you register the SPN. Otherwise, the SPN that's registered in Active Directory becomes invalid the next time the named instance starts listening on a different port.

> [!NOTE]
> This recommendation applies only to environments that depend on manual SPN registration.

**Action**: Follow these steps to configure the SQL Server instance to use a static port:

1. In **SQL Server Configuration Manager - Console**, expand **SQL Server Network Configuration**, expand **Protocols** for `<instance name>`, and then double-click **TCP/IP**.
1. In **TCP/IP Properties**, select **Listen All** in the **Protocol** tab.
1. If **Listen All** is set to **Yes**, switch to **IP Addresses**, and scroll to the bottom of the window to find the **IPAll** setting.
1. Delete the current value in **TCP Dynamic Ports**, and enter a port number in **TCP Port**.
1. Select **OK**, and then restart the SQL Server instance. For more information, see [Configure a server to listen on a specific TCP port](/sql/database-engine/configure-windows/configure-a-server-to-listen-on-a-specific-tcp-port).
1. If **Listen All** is set to **No**, switch to **IP Addresses**, and check every IP address that appears in the IP1 and IP2 nodes. For addresses that are set to **Enabled**, remove the current value in **TCP Dynamic Ports**, and then set a value in **TCP Port**.
1. Select **OK**, and then restart the SQL Server instance for the settings to take effect. For more information, see [Configure a server to listen on a specific TCP port](/sql/database-engine/configure-windows/configure-a-server-to-listen-on-a-specific-tcp-port).

### Status: Duplicate SPN

**More information**: This status appears if the same SPN is registered under different accounts in Active Directory.

**Action**: Follow these steps to remove the duplicate SPN from Active Directory:

1. Select **Fix**.
1. Check the information in the **Warning** dialog box.
1. Select **Yes** to remove the incorrect SPN from Active Directory.
   - If your domain account has the necessary permissions to update Active Directory, the tool deletes the incorrect SPN.
   - If your domain account doesn't have the necessary permissions to update Active Directory, use **Generate** or **Generate All** to generate a script that you can give to your Active Directory administrator to remove the duplicate SPNs.
1. After the SPNs are removed, run Kerberos Configuration Manager again to verify that the SPN issues are resolved.

> [!NOTE]
> When an instance of the SQL Server Database Engine starts, SQL Server tries to register the SPN for the SQL Server service. When the instance stops, SQL Server tries to unregister the SPN. For this process to occur, the SQL Server service account requires the appropriate permissions in Active Directory. If the service account doesn't have these rights, automatic SPN registration doesn't occur. In that case, work with your Active Directory administrator to register the SPNs so that the SQL Server instances can use Kerberos authentication. For more information, see [Register a Service Principal Name for Kerberos connections](/sql/database-engine/configure-windows/register-a-service-principal-name-for-kerberos-connections).

> [!NOTE]
> In environments where SQL Server is clustered, automatic registration of SPNs isn't recommended. It can take more time to unregister and re-register the SPN in Active Directory than it takes for SQL Server to come online. If the SPN registration doesn't occur in time, SQL Server might not come online because the cluster administrator can't connect to the SQL Server instance.

## Additional options in Kerberos Configuration Manager

### Generate the SPN list from the command line

1. Open a command prompt. To troubleshoot connectivity issues that affect SSRS, open an administrative Command Prompt window.
1. Switch to the folder that contains *KerberosConfigMgr.exe*.
1. Enter `KerberosConfigMgr.exe -q -l`.
1. For more command-line options, enter `KerberosConfigMgr.exe -h`.

### Save a server's Kerberos configuration

1. Connect to the target Windows server.
1. Select **Save**.
1. Specify where to save the file. Choose a local drive or a network share. The tool saves the file in *.xml* format.

### View a saved Kerberos configuration

1. Select **Load**.
1. Open the XML file that Kerberos Configuration Manager generated.

### View the tool's log files

By default, the tool generates a new log file each time you run the application. You can find the log files in your application data folder: *%APPDATA%\Microsoft\KerberosConfigMgr*.

### Get help

Use any of the following methods:

- Hover the mouse pointer over a command to display a tooltip.
- Run `KerberosConfigMgr.exe -h` at the command prompt.
- Select the **Help** button on the toolbar.

## Related content

- [Determine the authentication type](determine-the-authentication-type.md)
- [Explicit misplaced SPN error in SQL Server](explicit-spn-is-misplaced.md)
- [Resolve KRB_AP_ERR_TKT_EXPIRED errors](expired-tickets-issue.md)
- [Windows prevents unconstrained delegation](windows-prevents-unconstrained-delegation.md)
- [Kerberos constrained delegation overview](/windows-server/security/kerberos/kerberos-constrained-delegation-overview)