---
title: Implement a shared SUSDB for Configuration Manager SUPs
description: "Learn how to deploy and validate a shared WSUS SUSDB for Configuration Manager software update points, troubleshoot common issues, and optimize performance."
ms.reviewer: kaushika, payur
ms.date: 07/21/2026
ai-usage: ai-assisted
ms.custom: sap:Software Update Management (SUM)\Software Update Point
---

# Implement a shared SUSDB for Configuration Manager software update points

## Summary

In a Configuration Manager site with multiple software update points (SUPs), each SUP uses a WSUS database (SUSDB) to store update metadata. By default, each SUP maintains its own SUSDB, which means clients perform a full metadata scan - potentially transferring more than 1 GB of data - every time they switch between SUPs.

A shared SUSDB lets multiple SUPs in the same site point to a single database. When clients switch between SUPs that share a SUSDB, they perform delta scans instead of full scans, which significantly reduces network overhead and speeds up compliance reporting.

This article explains how to:

- Prepare a shared content location and install the WSUS role for shared SUSDB use
- Run post-installation tasks and verify the configuration
- Install and configure the Configuration Manager SUP role
- Troubleshoot common issues, including content directory access failures and synchronization errors

For more information, see [Use a shared WSUS database for software update points](/intune/configmgr/sum/plan-design/software-updates-best-practices#bkmk_shared-susdb) and [Capacity limits](windows-server-update-services-best-practices.md#capacity-limits).

## Install and configure WSUS for a shared SUSDB

### Requirements

For architecture and planning guidance, see [Best practices for software updates in Configuration Manager](/intune/configmgr/sum/plan-design/software-updates-best-practices) and [Plan for software updates in Configuration Manager](/intune/configmgr/sum/plan-design/plan-for-software-updates).

All front-end WSUS servers that share a SUSDB should have:

1. The same WSUS version.
1. The same Windows Server version and patch level.
1. The same access requirements configuration for synchronization with Microsoft Update.
1. A maximum of four SUPs sharing the same SUSDB.

For example, if you plan to have seven SUPs in your primary site, four can share one SUSDB. The remaining three can share a different SUSDB or use separate databases.

Also verify SQL requirements in [Size and scale numbers for Configuration Manager](/intune/configmgr/core/plan-design/configs/size-and-scale-numbers#software-update-point).

> [!IMPORTANT]
>
> - WID (Windows Internal Database) isn't supported for this shared SUSDB design.
> - Use a shared WSUS content path (UNC share or DFS path), and grant each front-end WSUS computer account Change permissions.
> - SUPs that share a SUSDB must belong to the same site. Cross-site sharing isn't supported: for example, between a CAS and a primary site, or between a primary site and a secondary site.

### Prepare a shared content location

Create one shared content location for all WSUS front-end servers that use the same SUSDB.

1. Create a file location for WSUS content that all clients can access. Use either of the following options:

   - A standard SMB share backed by resilient storage (for example, RAID).
   - A DFS namespace or path.

1. Grant permissions at both the share and NTFS levels:

   - Grant **Change** permissions to each WSUS front-end server computer account (`WSUSServer$`) that uses the shared content location. If the share is local to the WSUS server, use the **Network Service** account.
   - Grant **Change** permissions to the administrator account that runs `WsusUtil.exe postinstall`.

1. Use a single UNC path for all nodes, and keep it consistent in setup and post-install commands. Example:

   ```text
   \\FileServer\WSUS
   ```

1. Validate access from every WSUS front-end server before installing the role:

   - Browse the UNC path from each server.
   - Create and delete a temporary test file or folder.

### Install the WSUS role

You can install WSUS from Server Manager or PowerShell. For more information, see [Getting started with WSUS](/windows-server/administration/windows-server-update-services/get-started/windows-server-update-services-wsus).

1. Open Server Manager, select **Manage**, and then select **Add roles and features**.

   :::image type="content" source="./media/wsus-configure-shared-database/add-roles-and-features-wizard.png" alt-text="Screenshot of the Add Roles and Features option in Server Manager.":::

1. In **Server Roles**, select **Windows Server Update Services**.

   :::image type="content" source="./media/wsus-configure-shared-database/select-wsus-server-role.png" alt-text="Screenshot of selecting the Windows Server Update Services (WSUS) role in the Add Roles and Features Wizard.":::

1. Accept the required features and continue to **Role Services**.

   :::image type="content" source="./media/wsus-configure-shared-database/add-required-features.png" alt-text="Screenshot of the prompt to add required features for Windows Server Update Services during WSUS role installation.":::

1. Clear **WID Database** and select **SQL Server Connectivity**.

   :::image type="content" source="./media/wsus-configure-shared-database/select-database-role-service.png" alt-text="Screenshot of the Role Services step showing WID Database cleared and SQL Server Connectivity selected for shared SUSDB configuration.":::

1. Specify the shared content path: `\\FileServer\WSUS` (or your UNC path) and select **Next**.

   :::image type="content" source="./media/wsus-configure-shared-database/specify-wsus-content-share.png" alt-text="Screenshot of specifying the shared WSUS content UNC path during role installation in the Add Roles and Features Wizard.":::

1. Specify the SQL Server (and instance if applicable), and then select **Check connection**.

   :::image type="content" source="./media/wsus-configure-shared-database/check-sql-connectivity.png" alt-text="Screenshot of specifying the SQL Server instance and selecting Check connection during WSUS shared SUSDB setup.":::

1. Select **Next**, proceed to the **Install** screen, and complete the installation.

### Run post-installation tasks

You can run the post-installation tasks in the following ways:

- **Option 1:** WSUS console

    :::image type="content" source="./media/wsus-configure-shared-database/wsus-post-install-via-console.png" alt-text="Screenshot of the Complete WSUS Installation dialog launched from the WSUS console for post-installation configuration.":::

- **Option 2:** Server Manager notification

    :::image type="content" source="./media/wsus-configure-shared-database/wsus-post-install-from-server-manager.png" alt-text="Screenshot of the WSUS post-installation configuration notification displayed in Windows Server Manager.":::

- **Option 3 (recommended):** `WsusUtil.exe` command line. Open PowerShell as an administrator and run:

    ```powershell
    cd "C:\Program Files\Update Services\Tools"
    .\WsusUtil.exe postinstall SQL_INSTANCE_NAME="SQLServer\Instance" CONTENT_DIR="\\FileServer\WSUS"
    ```
    
    :::image type="content" source="./media/wsus-configure-shared-database/wsusutil-postinstall-command.png" alt-text="Screenshot of the WsusUtil.exe postinstall command output in PowerShell for shared SUSDB configuration.":::
    
    > [!NOTE]
    >
    > - Keep `.\` in front of `WsusUtil.exe` when running it in PowerShell.
    > - For a default SQL instance, use the server name only.

### Repeat on other nodes and configure SSL if needed

Repeat this WSUS setup on each additional front-end WSUS server for the same site.

For SSL, see [Configure a software update point to use TLS/SSL with a PKI certificate](/intune/configmgr/sum/get-started/software-update-point-ssl). SSL isn't required, but if you use it, configure it consistently on all WSUS servers.

### Verify the WSUS installation

1. Open **Windows Server Update Services (WSUS)** from the Start menu. The **Configuration Wizard** opens the first time. Cancel it, and then confirm that you can browse nodes without errors.

   :::image type="content" source="./media/wsus-configure-shared-database/open-wsus-console.png" alt-text="Screenshot of opening the WSUS console from the Start menu.":::

1. In IIS, right-click the **Content** virtual directory, select **Manage Virtual Directory**, and then select **Advanced Settings**.

   :::image type="content" source="./media/wsus-configure-shared-database/iis-content-virtual-directory-settings.png" alt-text="Screenshot of the Advanced Settings dialog for the Content virtual directory in IIS used to verify the shared WSUS content path.":::

1. Validate the physical path format. Confirm that the UNC path starts with `\\`.

   Incorrect example:

   :::image type="content" source="./media/wsus-configure-shared-database/incorrect-content-path-format.png" alt-text="Screenshot showing an incorrect WSUS content path format in IIS Advanced Settings, missing the required UNC path prefix.":::

   Correct example:

   :::image type="content" source="./media/wsus-configure-shared-database/correct-content-path-format.png" alt-text="Screenshot showing a correct UNC content path format for the shared WSUS content directory in IIS Advanced Settings.":::

1. Validate the registry values under `HKLM\Software\Microsoft\Update Services\Server\Setup`.

   :::image type="content" source="./media/wsus-configure-shared-database/wsus-setup-registry-values.png" alt-text="Screenshot of the WSUS setup registry values under HKLM\Software\Microsoft\Update Services\Server\Setup in Registry Editor.":::

   Check these values:

   | Value | Requirement |
   | --- | --- |
   | `ContentDir` | Same content path used during the post-install task. |
   | `IISTargetWebsiteIndex` | IIS site ID, used in default IIS log naming. |
   | `PortNumber` | Usually `8530` (HTTP) or `8531` (HTTPS). |
   | `SQLDatabaseName` | Always `SUSDB`. |
   | `SQLServerName` | SQL server and instance if used. |
   | `UsingSSL` | `0` for HTTP, `1` for HTTPS. |

> [!WARNING]
> The `ContentDir` registry value doesn't include the trailing `WSUSContent\` directory. SQL `LocalContentCacheLocation` and the IIS Content virtual directory **Physical path** do include it.

1. Optionally, verify the content path from SQL:

   ```sql
   select LocalContentCacheLocation from tbConfigurationB
   ```

   :::image type="content" source="./media/wsus-configure-shared-database/sql-verification-of-content-path.png" alt-text="Screenshot of the SQL query that verifies the content path.":::

## Install the Configuration Manager software update point role

Install SUP roles by using [Install and configure a software update point](/intune/configmgr/sum/get-started/install-a-software-update-point).

1. Choose which SUP to install first.
1. Add the SUP role. Create a new site system server, or add the role to an existing site system server.

   :::image type="content" source="./media/wsus-configure-shared-database/create-site-system-server.png" alt-text="Screenshot of the Create Site System Server wizard in Configuration Manager for adding a software update point.":::

   Configure the proxy and credentials if needed:

   :::image type="content" source="./media/wsus-configure-shared-database/sup-proxy-settings.png" alt-text="Screenshot of the proxy and account settings page for the site system server in Configuration Manager.":::

   Select **Software Update Point**:

   :::image type="content" source="./media/wsus-configure-shared-database/select-sup-role.png" alt-text="Screenshot of selecting the Software Update Point role in the Configuration Manager site system server wizard.":::

   Set ports to match WSUS settings. Select **Require SSL communication to the WSUS server** if WSUS is configured for SSL. You can adjust other options after the initial setup.

   :::image type="content" source="./media/wsus-configure-shared-database/configure-wsus-ports-for-sup.png" alt-text="Screenshot of configuring WSUS port settings and SSL option for the software update point in Configuration Manager.":::

   Complete the wizard with the additional proxy settings, if necessary.

1. Monitor `SUPSetup.log` on the SUP server for the installation result.

    ```output
    ====================================================================
    SMSWSUS Setup Started....
    Parameters: E:\ConfigMgr\bin\x64\rolesetup.exe /install /siteserver:SiteServer.contoso.com SMSWSUS 0
    INFO: Checking MSODBC version on ServerName SUPServer
    INFO: MSODBC version is 18.4.1.1
    INFO: Microsoft ODBC 18 Driver for SQL Server had been installed already.
    Installing Pre Reqs for SMSWSUS
            ======== Installing Pre Reqs for Role SMSWSUS ========
    Found 0 Pre Reqs for Role SMSWSUS
            ======== Completed Installation of Pre Reqs for Role SMSWSUS ========
    Installing the SMSWSUS
    Checking for supported version of WSUS (min WSUS 4.0)
    Checking runtime v4.0.30319...
    Found supported assembly Microsoft.UpdateServices.Administration version 4.0.0.0, file version 6.2.20348.1
    Found supported assembly Microsoft.UpdateServices.BaseApi version 4.0.0.0, file version 6.2.20348.143
    Supported WSUS version found
    Supported WSUS Server version (6.2.20348.143) is installed.
    CTool::RegisterManagedBinary: run command line: "C:\Windows\Microsoft.NET\Framework64\v2.0.50727\RegAsm.exe" "E:\ConfigMgr\bin\x64\wsusmsp.dll"
    CTool::RegisterManagedBinary: Failed to register E:\ConfigMgr\bin\x64\wsusmsp.dll with .Net Fx 2.0
    CTool::RegisterManagedBinary: run command line: "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\RegAsm.exe" "E:\ConfigMgr\bin\x64\wsusmsp.dll"
    CTool::RegisterManagedBinary: Registered E:\ConfigMgr\bin\x64\wsusmsp.dll successfully
    Registered DLL E:\ConfigMgr\bin\x64\wsusmsp.dll
    Installation was successful.
    ~RoleSetup().
     ```

1. Monitor `WCM.log` for the configuration refresh. If needed, restart the `SMS_WSUS_CONFIGURATION_MANAGER` component by using Configuration Manager Service Manager.

   ```output
   Populating config from SCF
   Setting new configuration state to 1 (WSUS_CONFIG_PENDING)~
   Changes in active SUP list detected. New active SUP List is:~
       SUP0: SUPServer1.contoso.com, group = SUPServer1, nlb = ~
       SUP1: SUPServer2.contoso.com, group = SUPServer1, nlb = ~
   Updating active SUP groups...~
   ```

1. Start synchronization, or wait for the scheduled synchronization cycle. Monitor `WsyncMgr.log` for completion.

   ```output
   Starting Sync
   Performing sync on local request
   Read SUPs from SCF for SUPServer1.contoso.com
   Found 2 SUPs
   Found active SUP SUPServer1.contoso.com from SCF File.~
   Found active SUP SUPServer2.contoso.com from SCF File.~
   ...
   There are additional SUPs sharing the database with the default SUP SUPServer1.contoso.com, sync operations may use shared db SUPs.
   ```

Add additional SUPs for the same site. During initial setup, the source might temporarily show Microsoft Update until upstream synchronization finishes.

## Troubleshoot common issues with shared SUSDB

### Issue 1: WSUS front-end server can't access the shared content directory

In Configuration Manager environments, update binaries typically aren't served from the WSUS `Content` virtual directory in IIS, but End User License Agreement (EULA) files are. These files are small text files that clients download during the update scan process. There's no requirement to deploy an update that has EULA content to initiate this download.

A key indicator is a Configuration Manager client that reports a `SucceededWithErrors` scan result code (`0x80240033`) during a [software update scan](track-software-update-compliance-assessment.md#software-update-scan-on-clients). You can usually see this result in the built-in reports under the "Software Updates – D Scan" category, such as "Scan 1 – Last scan states by collection".

In Configuration Manager's `WUAHandler.log` on client devices, you see:

```output
Received 'SucceededWithErrors' code from WUA during search. Check WindowsUpdate.log in Windows directory.
WU Agent reported the following 1 warning messages:
HResult: 0x80240033 Context: uecGeneral Msg: The license terms of one or more updates are unavailable..
```

`WindowsUpdate.log` also reports the same error code:

```output
*FAILED* [80240033] ISusInternal:: GetEulaText
```

> [!TIP]
> Use `WsusUtil.exe checkhealth` to validate the health of the WSUS server and its configuration. If accessing the shared content directory fails, the command produces an error event with ID 12072 in the `Application` event log similar to:
>
> ```output
> The permissions on directory \\FileServer\WSUS\WsusContent are incorrect.
> ```
>
> or
>
> ```output
> The WSUS content directory is not accessible.
> ```

You can find more details in `WindowsUpdate.log` on the client and in IIS logs on the WSUS front-end server. The following scenarios are common:

#### Scenario 1: The `Content` virtual directory is misconfigured

In this case, `WindowsUpdate.log` on the client shows:

```output
WARNING: Fail to download eula file http://SUPServer.contoso.com:8530/Content/AE/<file>.txt with error 0x80244019
```

This error code (`WU_E_PT_HTTP_STATUS_NOT_FOUND`) is also reflected in the IIS log for the WSUS Administration website as HTTP 404 error for the same file:

```output
10.10.10.5 HEAD /Content/AE/<file>.txt 8530 - 10.10.10.221 Windows-Update-Agent - 404 0 5 281
```

**Fix:**

Validate the `Content` virtual directory configuration for affected WSUS servers as described in [Verify the WSUS installation](#verify-the-wsus-installation). A common mismatch is a local drive path on one server and the shared UNC path on others. To resolve this mismatch:

1. Run `WsusUtil.exe postinstall` again with the correct `CONTENT_DIR` pointing to the shared UNC path. For example:

   ```output
   PS C:\Windows\system32> cd "C:\Program Files\Update Services\Tools"
   PS C:\Program Files\Update Services\Tools> .\WsusUtil.exe postinstall SQL_INSTANCE_NAME="SQLServer" CONTENT_DIR="\\FileServer\WSUS"
   Log file is located at C:\Users\admin\AppData\Local\Temp\WSUS_PostInstall_20260702T082349.log
   Post install is starting
   Post install has successfully completed
   ```

1. Revalidate IIS, registry, and SQL path values as described in [Verify the WSUS installation](#verify-the-wsus-installation).

1. Run `WsusUtil.exe reset` to verify and redownload missing EULA content. It's sufficient to run this command on one of the WSUS servers sharing the same SUSDB.

   ```output
   PS C:\Program Files\Update Services\Tools> .\WsusUtil.exe reset
   ```

1. Confirm activity in `SoftwareDistribution.log` under `C:\Program Files\Update Services\LogFiles` resembling the following:

   ```output
   TriggerEvent called for NotificationEventName: StateMachineReset, EventInfo:
   DispatchManager Worker Thread Processing NotificationEvent: StateMachineReset
   State Machine Reset Agent Starting
   ...
   State Machine Reset Agent Finished
   ```

#### Scenario 2: Misconfigured ACLs on the shared content directory

In this case, `WindowsUpdate.log` fails with a different error code:

```output
WARNING: WinHttp: SendRequestUsingProxy failed for http://SUPServer.contoso.com:8530/Content/AE/<file>.txt error 0x800710dd
```

IIS logs on the affected WSUS front-end server show HTTP 401.3 for the same file:

```output
10.10.10.5 HEAD /Content/AE/<file>.txt 8530 - 10.10.10.221 Windows-Update-Agent - 401 3 5 281
```

These symptoms indicate authentication or permission issues when the `Content` virtual directory tries to access the shared content location.

**Fix:**

Verify the ACLs on the shared content location and specifically on the `\\FileServer\WSUS\WSUSContent` folder. Each WSUS front-end server computer account must have **Full Control** permissions to the latter path at both the share and NTFS levels.

After verifying permissions, re-run `WsusUtil.exe checkhealth` command on affected WSUS servers to validate the content directory access.

### Issue 2: Synchronization fails with generic network-related errors or errors accessing Microsoft Update endpoints

When at least two SUPs share a SUSDB, you might see errors in `WsyncMgr.log` similar to the following:

```output
Sync failed: UssCommunicationError: WebException: The remote name could not be resolved: 'sws.update.microsoft.com'~~at System.Net.HttpWebRequest.GetRequestStream(TransportContext& context). Source: Microsoft.SystemsManagementServer.SoftwareUpdatesManagement.WsusSyncAction.WSyncAction.SyncWSUS
```

```output
WebException: Unable to connect to the remote server ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond (IP of Microsoft or Akamai)
```

This issue can occur when the master WSUS server changes and the new master doesn't meet the same network access requirements for synchronization with Microsoft Update.

Configuration Manager assumes that the master is always the first SUP role installed in the hierarchy, and it must match the output of the following WSUS command:

```console
Wsusutil.exe listfrontendservers
```

```output
C:\Program Files\Update Services\Tools>WsusUtil.exe listfrontendservers
Server: SUPServer1.contoso.com, IsActive:True, IsMaster:True,
LastContactedTime:7/2/2026 10:06:31 AM.
Server: SUPServer2.contoso.com, IsActive:True, IsMaster:False,
LastContactedTime:7/2/2026 10:06:35 AM.
```

**Fix:**

Verify and configure network access requirements for synchronization with Microsoft Update on all WSUS servers. For the complete list, see [Internet endpoints for Configuration Manager](/intune/configmgr/core/plan-design/network/internet-endpoints#software-updates).

As a temporary workaround (for example, if you can't immediately fix network configuration), complete these steps to switch back to the original master WSUS/SUP server:

   1. Stop the WSUS service on all WSUS servers that don't meet internet access requirements while they share the same SUSDB.
   1. Trigger WSUS synchronization on the server that you want as the master front-end server. Verify the change by running `Wsusutil.exe listfrontendservers` again.
   1. After the sync starts, start the WSUS service on all other WSUS servers sharing the same SUSDB.

## Related references

- [Best practices for software updates in Configuration Manager](/intune/configmgr/sum/plan-design/software-updates-best-practices)
- [Plan for software updates in Configuration Manager](/intune/configmgr/sum/plan-design/plan-for-software-updates)
- [Install and configure a software update point](/intune/configmgr/sum/get-started/install-a-software-update-point)
- [Configure a software update point to use TLS/SSL with a PKI certificate](/intune/configmgr/sum/get-started/software-update-point-ssl)
- [Windows Server Update Services (WSUS) maintenance guide for Configuration Manager](/troubleshoot/mem/configmgr/update-management/wsus-maintenance-guide)
