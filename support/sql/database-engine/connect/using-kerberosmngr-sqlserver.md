---
title: Using Kerberos Configuration Manager for SQL Server
description: Microsoft Kerberos Configuration Manager for SQL Server is a diagnostic tool that's used with SQL Server to troubleshoot Kerberos-related connectivity issues. 
ms.reviewer: v-jayaramanp
ms.date: 06/16/2022
ms.custom: sap:Connection Issues 
---

# Overview of the Kerberos Configuration Manager for SQL Server

_Applies to:_&nbsp;SQL Server

_Original KB number:_ 2985455

An incorrect Kerberos configuration in your network can cause various connectivity errors in Microsoft SQL Server. Kerberos Configuration Manager for SQL Server is a diagnostic tool that helps you troubleshoot Kerberos-related connectivity issues that affect SQL Server, SQL Server Reporting Services (SSRS), and SQL Server Analysis Services (SSAS). This article provides information about how to use the Kerberos Configuration Manager tool and how to interpret the output from the tool to fix Kerberos issues that affect SQL Server.

## Functions of the Kerberos Configuration Manager

Kerberos Configuration Manager can do the following tasks:

- Collect information about the OS, Microsoft SQL Server instances, and Always On Availability Group Listeners that are installed on a server.
- Report all Service Principal Name (SPN) and delegation configurations on the server.
- Identify potential problems in SPNs and delegations.
- Fix potential SPN problems.

## Usage scenarios

This tool helps you troubleshoot the following exceptions:

- 401
    > **Note:** This error message is for HTTP errors, SSRS errors, and other similar errors.
- Cannot generate SSPI Context
- Login failed for user 'NTAUTHORITY\ANONYMOUS LOGON'
- Login failed for user '(null)'
- Login failed for user (empty)

> [!NOTE]
> Before you start troubleshooting issues, we recommend that you review the prerequisites, and then go through the general checklist to troubleshoot connectivity-related errors.

> [!NOTE]
> If you have administrator access to your SQL Server-based computer, you can also run the SQL Connectivity Settings Check tool on that computer, and then review the output to check the SPN configuration of your SQL server instance.

## Downloading the tool

This tool is available for download from the Microsoft Download Center:

[Microsoft Kerberos Configuration Manager for SQL Server](https://www.microsoft.com/download/details.aspx?id=39046)

> [!NOTE]
> You can download and install the tool on any computer in your domain that can connect to the SQL Server-based computer.

## Permissions

To troubleshoot connectivity issues that affect SQL, SSRS, and SSAS, connect to the destination computer (that's hosting the service) by using a domain user account that has administrative permissions to that computer.

**Optional**: If you want to use the tool to fix any SPN issues that are identified by the tool, the domain account should have the **Validated write to service principle name** permission.

## Using the tool

After the installation is finished, start the *KerberosConfigMgr.exe* binary by navigating to the installation folder. By default, the location is *C:\Program Files\Microsoft\Kerberos Configuration Manager for SQL Server*.

For information about how to start an app as an administrator or a different user, see [Use Run to start an app as an admin](../../../windows-server/shell-experience/use-run-as-start-app-admin.md).

Use one of the following options to start troubleshooting:

- To connect to a remote SQL Server-based computer, enter the appropriate values for **Server Name**, **Domain User Name**, and **Password**.

  > [!NOTE]
  > The Kerberos Configuration Manager tool uses a Windows API to query and display information about Kerberos configuration for the SQL Server computer. Therefore, always enter the name of the computer that hosts the SQL Server instance, even if you are troubleshooting Kerberos-related issues for a named instance.

- To connect to a local server, select **Connect** to analyze your Kerberos configuration. In this case, you don't have to specify the server name, domain username, or password.

  > [!NOTE]
  > The account that starts the tool should be a local administrator account. For information about how to start an app as an administrator or a different user, see [Use Run to start an app as an admin](../../../windows-server/shell-experience/use-run-as-start-app-admin.md).

After the connection succeeds, all the related SPNs are shown in the following screenshot.

:::image type="content" source="media/using-kerberos-config-mngr/basic-system-information.png" alt-text="Screenshot of a view of all three tabs in Kerberos Configuration Manager.":::

In this screenshot, the UI has the following tabs:

- **System**: Displays the user information and machine information.

- **SPN**: Displays the Service Principal Name (SPN) information about each of the SQL Server instances that are found on the target server, and provides details such as the required SPN and its status.

- **Generate**: Helps you find missing and configured SPNs. It also helps you to generate the SPN Generation script.

  1. Select **Generate**.
  1. In the dialog box that opens, provide a name (in this case, "generateSPNss"), set **Save As type** as the *Kerberos Config Mgr(.cmd)* file, and then select **Save**.

    :::image type="content" source="media/using-kerberos-config-mngr/create-the-spn-generation-script.png" alt-text="Dialog box to provide a name for the CMD file.":::

The *generateSPNss.cmd* file is created, and you can run this file at a command prompt. The content of the *generateSPNss.cmd* file will resemble the following example:

  ```output
  :: This script is generated by the Microsoft&reg; SQL Server&reg; Kerberos Configuration Manager tool.

  :: The script may update the system information, SPN settings and Delegation configurations of a given server.

  :: SPN and Delegation configuration updates require Windows Domain Administrator permission to execute.

  :: A Domain Admin should review the configurations recommended by this tool and take appropriate actions to enable Kerberos authentication.

  :: Please contact Microsoft Support if Kerberos connection problem persists.

  :: The file is intended to be run in domain `<DomainName>.com`"

  :: Corrections for MSSQLSvc/`<HostName>.<DomainName>.com` **SetSPN -s MSSQLSvc/`<HostName>`. `<DomainName>`.com UserName** 
  ```

- Use **SetSPN** to create an SPN under the service account for SQL Server.

- Use **Fix** to fix issues and add SPNs. You can add an SPN only if you have the required permissions. When you select **Fix**, the following tool tip is displayed:

  :::image type="content" source="media/using-kerberos-config-mngr/fix-option-add-spn.png" alt-text="Screenshot of the Fix option to add SPN.":::

   > [!NOTE]
   > The tool provides the **Fix** and **Generate** commands only for default instances and named instances that have static ports. For named instances that use dynamic ports, we recommend that you switch from dynamic to static ports or provide necessary permissions for the service account to register and unregister the SPN every time that the SQL service is started. Otherwise, you have to manually unregister and re-register the corresponding SPNs whenever the service is started. For more information, see [Register a Service Principal Name for Kerberos Connections](/sql/database-engine/configure-windows/register-a-service-principal-name-for-kerberos-connections?view=sql-server-ver15&preserve-view=true).

- **Delegation**: Use **Delegation** to identify any issues that affect the service account's configuration for delegation. This is especially useful in troubleshooting linked server issues. For example, if the SPN checkout is fine but you still experience issues that affect linked server queries, this might indicate that the service account is not configured to delegate credentials. For more information, see the Books online topic at [Configuring Linked Servers for Delegation](/previous-versions/sql/sql-server-2008-r2/ms189580(v=sql.105)).

  :::image type="content" source="media/using-kerberos-config-mngr/delegation-tab.png" alt-text="Screenshot of the Delegation tab.":::

### Interpreting and acting on the diagnosis from the Kerberos Configuration Manager

Review the diagnosis from the tool by referring the **Status** column. Based on the status, follow the appropriate steps to resolve the issue.

- **Status - Good**

  **More information**: The checked item is configured correctly. Go to the next item in the output.

  **Action**: No action is required.

- **Status - Required SPN is missing**

  **More information**: This status is reported if the Service Principal Name (SPN) that's mentioned in the **Required SPN** column is missing for the SQL Server startup account in Active Directory.

  **Action**: Follow these steps to check whether the SPN issues are resolved:

    1. Select **Fix** to review the information in the **Warning** dialog box.
    1. Select **Yes** to add the missing SPN to Active Directory.
    1. If your domain account has the necessary permissions to update Active Directory, the required SPN will be added to Active Directory.
    1. If your domain account does not have necessary permissions to update Active Directory, use **Generate** or **Generate All** to generate the script that will help the Active Directory administrator add the missing SPNs.
    1. After the SPNs are added, run Kerberos Configuration Manager again to verify that the SPN issues are resolved.

- **Status - TCP must be enabled to use Kerberos configuration.**

  **More information**: This status is shown if TCP is not enabled on the client computer.

  **Action**: Follow these steps to enable the TCP/IP protocol for the SQL Server instance:

    1. In **SQL Server Configuration Manager - Console**, expand **SQL Server Network Configuration**.
  
    1. In **Console**, select **Protocols** for `<instance name>`.

    1. In **Details**, select **TCP/IP** and then select **Enable**.

    1. In **Console**, select **SQL Server Services**.

    1. In **Details**, select **SQL Server** for `<instance name>`.

    1. Select **Restart** to stop and restart the SQL Server service. For additional information, see [Enable or Disable a Server Network Protocol section](/sql/database-engine/configure-windows/enable-or-disable-a-server-network-protocol?view=sql-server-ver15&preserve-view=true).

- **Status - Dynamic Port**

  **More information**: This status is displayed for named instances that use dynamic ports (default configuration). In environments where you need to use Kerberos to connect to SQL Server, you should set your named instance to use a static port, and use that port when you register the SPN. Otherwise, the SPN that's registered in Active Directory will become invalid the next time that a named instance starts listening on a new port other than the one that the SPN was registered under.
  > [!NOTE]
  > This recommendation applies only to environments that depend on manual SPN registration.

  **Action**: Follow these steps to configure the SQL Server instance to use a static port:

  1. In **SQL Server Configuration Manager - Console**, expand **SQL Server Network Configuration**, expand **Protocols** for `<instance name>`, and then double-click **TCP/IP**.
  1. In **TCP/IP Properties**, select **Listen All** in the **Protocol**.
  1. If **Listen All** is set to **Yes**, switch to **IP Addresses**, and scroll to the bottom of the window to find the **IPAll** setting.
  1. Delete the current value in **TCP Dynamic Ports**, and enter a port number in the **TCP Port**.
  1. Select **OK**, and then restart the SQL Server instance. For more information, see [Configure a Server to Listen on a Specific TCP Port](/sql/database-engine/configure-windows/configure-a-server-to-listen-on-a-specific-tcp-port?view=sql-server-ver15&preserve-view=true).
  1. If **Listen All** is set to **No**, switch to **IP Addresses**, and check every IP address that appears in the IP1 and IP2 nodes. For addresses that are set to **Enabled**, remove the current value in **TCP Dynamic Ports**, and then set a value in **TCP Port**.
  1. Select **OK**, and then restart the SQL Server instance for the settings to take effect. For more information, see [Configure a Server to Listen on a Specific TCP Port](/sql/database-engine/configure-windows/configure-a-server-to-listen-on-a-specific-tcp-port?view=sql-server-ver15&preserve-view=true).
  
- **Status - Duplicate SPN**

  **More information**: You might encounter this scenario if the same SPN is registered under different accounts in Active Directory.

  **Actions**: Follow these steps to add an SPN to Active Directory:

  1. Select **Fix**.
  1. Check the information in the **Warning** dialog box.
  1. Select **Yes** to add the missing SPN to Active Directory.

      - If your domain account has the necessary permissions to update Active Directory, the incorrect SPN will be deleted.

      - If your domain account does not have necessary permissions to update Active Directory, use **Generate** or **Generate All** to generate the necessary script that you can provide to your Active Directory administrator to remove the duplicate SPNs.

  1. After the SPNs are removed, re-run Kerberos Configuration Manager to verify that the SPN issues are resolved.

   > [!NOTE]
   > When an instance of the SQL Server Database Engine starts, SQL Server tries to register the SPN for the SQL Server service. When the instance is stopped, SQL Server tries to unregister the SPN. For this to occur, the SQL Server service account requires the appropriate permissions in Active Directory. But if the service account does not have these rights, the automatic SPN registration does not occur, and you must work with your Active Directory administrator to register these SPNs so that the SQL instances can enable Kerberos authentication. For more information, see [Register a Service Principal Name for Kerberos Connections](/sql/database-engine/configure-windows/register-a-service-principal-name-for-kerberos-connections?view=sql-server-ver15&preserve-view=true).

   > [!NOTE]
   > In environments where SQL is clustered, automatic registration of SPNs is not recommended because it may take more time to unregister the SPN and re-register the SPN in Active Directory than the time it takes for SQL Server to get online. If the SPN registration does not occur in time, this might prevent SQL Server from getting online because the cluster administrator can't connect to the SQL Server instance.

## Additional options

To generate the SPN List from the command line:

1. Go to the command line.

   > [!NOTE]
   > To troubleshoot connectivity issue that affect SSRS, open an administrative Command Prompt window.

1. Switch to the folder that contains *KerberosConfigMgr.exe*.
1. Enter `KerberosConfigMgr.exe -q -l`.
1. For more command-line options, type `KerberosConfigMgr.exe -h`.

To save a server's Kerberos configuration information:

 1. Connect to the target Windows server.
 1. Select **Save**.
 1. Specify the location that you want the file to be saved to. It can be on a local drive or a network share. The file will be saved in *.xml* format.

To view a server's Kerberos configuration information from the saved file:

1. Select **Load**.
1. Open the XML file that's generated by Kerberos Configuration Manager.

To view the log files for this tool:

By default, one log file is generated every time that the application is run in your application data folder: *%APPDATA%\Microsoft\KerberosConfigMgr*.

To get help, use any of the following methods:

 - Hover the mouse pointer over the command to generate a tooltip.
 - Run `KerberosConfigMgr.exe -h` at the command prompt.
 - Select the **Help** button on the toolbar.

## See also

- [SQL Server Kerberos and SPN Quick Reference](/archive/blogs/sqlupdates/sql-server-kerberos-and-spn-quick-reference)
- [Kerberos Technical Supplement for Windows](/previous-versions/msp-n-p/ff649429(v=pandp.10))
- [How to get up and running with Oracle and Linked Servers](/archive/blogs/psssql/how-to-get-up-and-running-with-oracle-and-linked-servers)
- [Kerberos Authentication Tools and Settings](/previous-versions/windows/it-pro/windows-server-2003/cc738673(v=ws.10))
- [Active Directory and Active Directory Domain Services Port Requirements](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd772723(v=ws.10))
