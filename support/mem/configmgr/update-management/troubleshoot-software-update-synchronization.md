---
title: Troubleshoot software update synchronization
description: Diagnose Configuration Manager software update synchronization failures involving WSUS, proxies, web services, and SSL.
ms.date: 11/11/2026
ms.topic: troubleshooting
ms.custom: sap:Software Update Management (SUM)\Software Update Synchronization
ai-usage: ai-assisted
ms.reviewer: andad, lawillow, vicopado 
---

# Troubleshoot software update synchronization in Configuration Manager

_Applies to:_ Configuration Manager (current branch)

## Summary

Software update synchronization in Configuration Manager uses Windows Server Update Services (WSUS) to synchronize updates from the configured update source. Configuration, connectivity, or service issues can cause synchronization to fail.

This article helps you diagnose and resolve these failures by verifying prerequisites, reviewing diagnostic logs, and matching error messages to troubleshooting steps. After you apply a fix, use the verification steps to confirm that synchronization succeeds.

For an overview of the synchronization process at top-level and child sites, including expected log entries and status messages, see [Track software update synchronization](track-software-update-synchronization.md). Use this troubleshooting article to diagnose failures and apply the appropriate remediation.

## Verify prerequisites

Before you troubleshoot synchronization, verify the following prerequisites:

- The **Update Services** and **World Wide Web Publishing Service** services are running on the WSUS server.

  ```powershell
  Get-Service -Name WsusService, w3svc
  ```

  ```output
  Status   Name               DisplayName                           
  ------   ----               -----------                           
  Running  w3svc              World Wide Web Publishing Service     
  Running  WsusService        WSUS Service                          
  ```

- The **WSUS Administration** or **Default Web Site** website is running on the WSUS server.

  ```cmd
  %windir%\System32\inetsrv\appcmd.exe list site
  ```

  ```output
  SITE "Default Web Site" (id:1,bindings:http/*:80:,https/:443:,state:Started)
  SITE "WSUS Administration" (id:1210761836,bindings:http/:8530:,https/:8531:,state:Started)
  ```

- The ports configured for the software update point match the WSUS website bindings. See properties of Software update point role for a site system in Configuration Manager console _\Administration\Site Configuration\Servers and Site System Roles'_. If SSL communication is required, fully configure the SSL port to accept secure client connections. For configuration instructions, see [Configure a software update point to use TLS/SSL with a PKI certificate](/intune/configmgr/sum/get-started/software-update-point-ssl).

  :::image type="content" source="./media/software-update-point-properties.png" alt-text="Screenshot of the Software update point Properties dialog showing WSUS port 8530 and SSL port 8531.":::

- If the software update point is on a remote site system server, install the WSUS Administration console on the site server.

  ```powershell
  Get-WindowsFeature -Name UpdateServices-UI
  ```

  ```Output
  Display Name                                            Name                       Install State
  ------------                                            ----                       -------------
            [X] User Interface Management Console       UpdateServices-UI              **Installed**
   ```

## Check the update source settings in WSUS

WSUS Configuration Manager (`WCM`) configures the WSUS update source based on the Software Update Point (SUP) settings. If the WSUS settings don't match the Configuration Manager settings, review `WCM.log`.

In the WSUS console, select **Options** > **Update Source and Proxy Server**, and verify these settings:

> [!NOTE]
> Don't configure the site server first software update point as a replica. Only downstream software update points can be replicas of the site server first software update point.

- **Synchronize from Microsoft Update**: Enable this option on the **top-level** site's first SUP unless the site uses another upstream WSUS server.

  :::image type="content" source="./media/wsus-synchronization-source-top-level-site.png" alt-text="Screenshot of the WSUS Update Source and Proxy Server dialog with Synchronize from Microsoft Update selected for a top-level site.":::

- **Synchronize from another Windows Server Update Services server**: Select this option only for **Child** SUPs synchronizing from upstream SUP.

  :::image type="content" source="./media/wsus-synchronization-source-child-site.png" alt-text="Screenshot of the WSUS Update Source and Proxy Server dialog configured to synchronize from an upstream WSUS server for a child site.":::

- **Server name**: Specify the fully qualified domain name (FQDN) of the upstream WSUS server.
- **Port number**: Specify the port used by the upstream WSUS website.
- **Use SSL when synchronizing update information**: Select this option when the software update point uses HTTPS.
- **This server is a replica of the upstream server**: Select this option only on a downstream software update point that is a replica of the site server software update point.

  :::image type="content" source="./media/wsus-synchronization-source-child-replica.png" alt-text="Screenshot of the WSUS Update Source and Proxy Server dialog configured as a replica of the upstream server for a child site.":::

## Collect diagnostic data

Collect and review the logs that correspond to the reported issue.

| Log | Location | Description |
| --- | --- | --- |
| `WSyncMgr.log` | Site server in `<ConfigMgr Installation Path>\Logs` | Records the software update synchronization process. |
| `WCM.log` | Site server in `<ConfigMgr Installation Path>\Logs` | Records software update point configuration and connections to SUP. |
| `WSUSCtrl.log` | Site server in `<ConfigMgr Installation Path>\Logs`<br>Remote software update point in `<Drive With most Free Space>:\SMS\Logs` | Records SUP configuration, database connectivity, and health. |
| `SoftwareDistribution.log` | SUP server in `%ProgramFiles%\Update Services\LogFiles` | Records updates synchronized from the configured update source to SUP. |
| IIS logs | SUP server in `%SystemDrive%\inetpub\logs\LogFiles` | Records web requests to the SUP Administration website. |

## Identify the error signature

### Errors found in WSyncMgr.log or WCM.Log

Use the following tables to identify the most relevant remediation.

| Errors | Issue | Remediation |
| --- | --- | --- |
| HTTP 401, 403, 407, or 502; connection refused | Authentication or proxy | [Resolve authentication and proxy issues](#resolve-authentication-and-proxy-issues) |
| HTTP 500 or 503 in IIS logs | Web service | [Resolve web service issues](#resolve-web-service-issues) |
| Could not establish trust relationship for the SSL/TLS secure channel | SSL | [Resolve SSL issues](#resolve-ssl-issues) |
| Microsoft Software License Terms aren't completely downloaded | EULA download | [Resolve EULA content issues](#resolve-eula-content-issues) |
| Connection attempt failed or error 0x80072EFE | Microsoft Update connectivity | [Resolve Microsoft Update communication issues](#resolve-microsoft-update-communication-issues) |
| Sync failed: WSUS server not configured | WSUS isn't configured | [Resolve WSUS configuration failures](#resolve-wsus-configuration-failures) |
| Indexing Failed. Could not connect to SUSDB | Maintenance against remote WID | [Review the remote WID limitation](#wsus-maintenance-fails-on-a-remote-software-update-point-that-uses-wid) |

## Resolve authentication and proxy issues

Use this procedure when `WCM.log` contains HTTP status 401, 403, 407, or 502. Also use it when the log reports that the connection was refused.

To resolve these errors:

1. Verify that the software update point FQDN resolves and is reachable from the site server.
1. Verify the proxy settings and credentials on both the site system and software update point role.

   :::image type="content" source="media/verify-proxy-settings-credentials-site-system.png" alt-text="Screenshot of the proxy settings and credentials for a site system.":::

   ```cmd
   netsh winhttp show proxy
   ```

   > [!NOTE]
   > Configuration Manager components run under the local system account. If the proxy configuration differs by account, verify the WinHTTP settings in the system context.

   > [!NOTE]
   > When a proxy separates WSUS from the upstream update source, configure the proxy for both the site system and the software update point role. All roles on the site system use its proxy settings.

1. If you use a software update point connection account, verify that the account is a local administrator and a member of the **WSUS Administrators** group on the WSUS server.
1. If the software update point uses HTTPS, [check the SSL configuration](troubleshoot-software-update-scan-failures.md#check-ssl-configuration).
1. Review `WSUSCtrl.log` for WSUS health errors.
1. In IIS Manager, verify that the site server computer account or software update point connection account can access the `ApiRemoting30` virtual directory:

   1. Open **IIS Manager** (`inetmgr`).
   1. Expand **Sites** > **WSUS Administration** (or the website hosting WSUS).
   1. Right-click **ApiRemoting30** > **Edit Permissions**.

      :::image type="content" source="media/edit-permissions-apiremoting30.png" alt-text="Screenshot of IIS Manager showing Edit Permissions for ApiRemoting30 under WSUS Administration.":::

   1. Select the **Security** tab.
   1. Select the identity Configuration Manager uses:
      - **SYSTEM:** If WSUS is installed locally on the site server.
      - **Site server computer account:** `DOMAIN\SiteServerName$` if WSUS is installed on a remote system.
      - **Software update point connection account:** The configured `DOMAIN\UserName` if the SUP uses an account to connect to WSUS.
   1. Verify that **Read & execute**, **List folder contents**, and **Read** are allowed. The account need not appear explicitly on the **Security** tab; it could be part of a group with the corresponding permissions.

      :::image type="content" source="media/verify-permissions-for-apiremoting30.png" alt-text="Screenshot of the ApiRemoting30 Security tab showing Read and execute, List folder contents, and Read permissions allowed for SYSTEM.":::

## Resolve web service issues

HTTP 500 and 503 errors usually indicate a problem with WSUS or its IIS application pools and web services.

1. Run a [Prerequisite verification.](#verify-prerequisites)
1. Review the IIS logs and Windows Application event log for the failing WSUS web service. Open `SoftwareDistribution.log` and search for matching errors related to failed WSUS web service.
1. Review `WSUSCtrl.log` for component health errors.

## Resolve SSL issues

If `WCM.log` or `WSyncMgr.log` reports an SSL/TLS trust failure, verify the following configuration:

- The certificate bound to the WSUS Administration website is valid and hasn't expired.
- The site system FQDN matches the FQDN in the certificate.
- WSUS and the Configuration Manager software update point are both configured to use SSL.
- The WSUS website bindings and software update point port settings match.

For more information, see [Configure a software update point to use TLS/SSL with a PKI certificate](/intune/configmgr/sum/get-started/software-update-point-ssl).

## Resolve EULA content issues

If the Microsoft Software License Terms for an update don't download completely, `WSyncMgr.log` reports an error similar to the following example:

```output
Failed to sync update <UpdateID>. Error: The Microsoft Software License Terms have not been completely downloaded and cannot be accepted.
```

To resolve the failure:

1. Search `SoftwareDistribution.log` for `.txt` entries associated with the affected update.
1. Verify that the WSUS server can access the required Microsoft Update endpoints.
1. Verify the proxy settings for the site system and software update point role.
1. In an elevated Command Prompt on the WSUS server, reset WSUS content to redownload missing files.

   ```cmd
   "%ProgramFiles%\Update Services\Tools\wsusutil.exe" reset
   ```

1. Use the following SQL query against the WSUS database to determine whether the reset is still running. A result of `0` indicates that the reset has stopped.

   ```sql
   SELECT ResetStateMachineNeeded
   FROM tbSingletonData;
   ```

1. Monitor `SoftwareDistribution.log` and confirm that `ContentSyncAgent` downloads and verifies the missing EULA files.

## Resolve Microsoft Update communication issues

`WSyncMgr.log` might contain one of the following errors:

```output
A connection attempt failed because the connected party did not properly respond after a period of time.
0x80072EFE - The connection with the server was terminated abnormally.
```

To resolve these errors:

1. Verify that the top-level WSUS server can connect to the internet.
1. Verify that the firewall allows WSUS to connect to the [required Microsoft Update endpoints](/windows-server/administration/windows-server-update-services/deploy/2-configure-wsus#211-connection-from-the-wsus-server-to-the-internet).
1. If you synchronize Microsoft 365 Apps updates, allow the required Office content delivery network endpoints.
1. Verify the proxy settings and credentials.
1. Check for TLS inspection, connection resets, or recent firewall and proxy changes.

## Resolve WSUS configuration failures

`WCM` configures WSUS once every hour so that the WSUS settings match the software update point settings. If `WCM` can't configure WSUS, `WSyncMgr.log` contains entries similar to the following example:

```output
Sync failed: WSUS server not configured. Refer to WCM.log for configuration error details.
Sync failed. Will retry in 60 minutes.
```

Review `WCM.log` and use the underlying error to select the appropriate remediation:

| Error | Remediation |
| --- | --- |
| HTTP 401, 403, 407, or 502 | [Resolve authentication and proxy issues](#resolve-authentication-and-proxy-issues) |
| HTTP 500 or 503 | [Resolve web service issues](#resolve-web-service-issues) |
| Connection refused | [Resolve authentication and proxy issues](#resolve-authentication-and-proxy-issues) |
| Transport stream closed | [Resolve SSL issues](#resolve-ssl-issues) |

## WSUS Control Manager reports an error

WSUS Control Manager (`WSUSCtrl`) runs on the software update point. On a remote software update point, `WSUSCtrl.log` is on that server instead of the site server. `WSUSCtrl` periodically verifies WSUS component health and database connectivity.

If `WSUSCtrl.log` is healthy but `WCM.log` or `WSyncMgr.log` reports connection errors, troubleshoot the connection from the site server to WSUS.

Run a WSUS health check on the WSUS server:

```cmd
"%ProgramFiles%\Update Services\Tools\wsusutil.exe" checkhealth
```

Then review the Windows Application event log for WSUS errors.

### Test connectivity from the site server to WSUS

If WSUS is on a remote software update point, install the WSUS Administration console on the site server. The console installs the administration APIs that Configuration Manager uses to connect to WSUS.

To test the connection:

1. On the site server, open the WSUS Administration console.
1. Right-click **Update Services**, and then select **Connect to Server**.
1. Enter the WSUS server FQDN and port number.
1. Select **Connect**.

If the console can't connect, [identify the error signature](#identify-the-error-signature) and resolve the underlying issue before retrying synchronization.

## WSUS maintenance fails on a remote software update point that uses WID

Configuration Manager WSUS maintenance tasks can fail on a remote software update point that uses Windows Internal Database (WID). The failures affect tasks that require a direct connection to `SUSDB`, including adding nonclustered indexes and removing obsolete updates.

Configuration Manager runs these tasks from the site server. **WID doesn't support remote SQL connections**, so the site server can't connect directly to the remote `SUSDB` instance.

Run WSUS database maintenance locally on the remote software update point instead of relying on the Configuration Manager maintenance options. For more information, see:

- [Software updates maintenance](/intune/configmgr/sum/deploy-use/software-updates-maintenance#known-issue)
- [WSUS maintenance guide](/troubleshoot/mem/configmgr/update-management/wsus-maintenance-guide)

## Verify synchronization after remediation

After you apply a fix:

1. In the Configuration Manager console, start software update synchronization.
1. Confirm that `WSyncMgr.log` records successful synchronization and status message ID 6702.
1. Confirm that `WCM.log` doesn't contain recurring configuration failures.
1. Confirm that `WSUSCtrl.log` reports healthy WSUS components.
1. In the **Monitoring** workspace, review the software update point synchronization status.

## Common configuration problems

- The software update point ports don't match the WSUS IIS bindings.
- SSL is enabled in Configuration Manager but not configured end to end in WSUS and IIS.
- The upstream WSUS server name isn't an FQDN.
- The WSUS Administration console isn't installed on a site server that uses a remote software update point.
- The proxy account lacks access to the required Microsoft endpoints.
- The first software update point at a top-level or primary site is incorrectly configured as a replica.

## Related content

- [Software updates synchronization](/intune/configmgr/sum/understand/software-updates-introduction#bkmk_synchronization)
- [Troubleshoot WSUS synchronization and import issues](/troubleshoot/mem/configmgr/update-management/troubleshoot-wsus-import-sync-issues)
- [Troubleshoot WSUS connection failures](/troubleshoot/mem/configmgr/update-management/troubleshoot-wsus-connection-failures)
- [Troubleshoot high CPU usage on a WSUS server](/troubleshoot/mem/configmgr/update-management/troubleshoot-wsus-server-high-cpu-usage)
- [Troubleshoot WSUS synchronization failures with SoapException](/troubleshoot/mem/configmgr/update-management/wsus-synchronization-fails-with-soapexception)
