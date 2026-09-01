---
title: Troubleshoot software update synchronization
description: Helps diagnose and resolve some common issues that affect software update synchronization in Configuration Manager, including authentication, proxy, and communication issues.
ms.date: 08/31/2026
ai-usage: ai-assisted
ms.custom: sap:Software Update Management (SUM)\Software Update Synchronization
ms.reviewer: kaushika
---
# Troubleshoot software update synchronization in Configuration Manager

_Original product version:_ &nbsp; Configuration Manager (current branch), Microsoft System Center 2012 R2 Configuration Manager, Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 4505439

## Summary

This article helps you diagnose and resolve some common issues that affect software update synchronization in Configuration Manager. The first two sections guide you through checking the prerequisite configurations and the relevant Windows Server Update Services (WSUS) settings. The subsequent sections address the most common causes of synchronization failure and common WSUS issues, and how to resolve them.

## Verify the prerequisites

The first step in troubleshooting synchronization issues is to verify that your system meets the following prerequisites:

- Verify that your system meets the [prerequisites for software updates in Configuration Manager](/mem/configmgr/sum/plan-design/prerequisites-for-software-updates).
- When you install the software update point on a remote site system server, install the WSUS Administration console on the site server.
- Verify that WSUS running on a software update point isn't configured to be a replica.

    To verify it, open the WSUS console on the software update point. Select **Options** in the console tree pane, and then select **Update Source and Proxy Server** in the display pane.

- Verify that the **Update Services** service is running on the WSUS server.
- Verify that the Default website or WSUS Administration website is running on the WSUS server.

## Check the Update Source settings in WSUS

Check the Update Source settings in the WSUS console on the software update point site system server. WSUS Configuration Manager (WCM) automatically sets these settings. If these settings don't match, review the WCM.log file.

To check the update source settings in WSUS, open the WSUS console on the software update point site system server. Select **Options** in the console tree pane, and then select **Update Source and Proxy Server** in the display pane.

Verify that the following settings are configured correctly:

- **Synchronize from Microsoft Update**
  
  Select this setting when you're in the WSUS console on the software update point for the top-level site. Starting with Configuration Manager 2012 SP1, you can specify an existing WSUS server as the upstream synchronization source location for the top-level site. If you specify an existing WSUS server as the upstream source location, don't select this setting.
- **Synchronize from another Windows Server Update Services server**

  Select this setting when you're in the WSUS console for:

  - Software update points for top-level site if you specify an upstream source location instead of Microsoft Update.
  - Software update points for a primary site.
  - Other software update points installed in the primary site.
  - Internet-based software update points.
  - Software update points for a secondary site.

  **Server name**: Use the fully qualified domain name (FQDN) of the upstream update source.

  - For the first software update point in the primary site, use the software update point for the parent site.
  - For other software update points in the site, use the first software update point on the same site.
  - For an Internet-based software update point, use the first software update point on the same site.

  **Port number**: Use the port number for the upstream WSUS server. To determine the port number on the upstream WSUS server, see [Determine the port settings used by WSUS and the software update point](troubleshoot-software-update-scan-failures.md#determine-the-port-settings-used-by-wsus-and-the-software-update-point).

  **Use SSL when synchronizing update information**: When the software update point is in HTTPS mode, select this setting. When you use Secure Sockets Layer (SSL) for software updates, several requirements apply. For more information, see [Check SSL configuration](troubleshoot-software-update-scan-failures.md#check-ssl-configuration).

  **This server is a replica of the upstream server**: Never select this setting on the software update point for the top-level site or the first software update point for the primary site. Select this setting on:

  - Internet-based software update points
  - Other software update points for the primary site.
  - Software update points for a secondary site.

## Synchronization fails because of authentication and proxy issues

WSUS Configuration Manager configures the WSUS server once every hour. It does so to ensure that the settings configured in WSUS match the setting specified in the Configuration Manager console.

If WCM fails to configure the WSUS server properly, synchronization attempts can fail with an error similar to the following screenshot:

:::image type="content" source="media/troubleshoot-software-update-synchronization/fail-error.png" alt-text="Screenshot of the synchronization error message in the Status Message Details dialog box." border="false":::

You'll also find the following error in the WsyncMgr.log file on the site server (located in the \\Logs folder):

```output
Sync failed: WSUS server not configured. Please refer to WCM.log for configuration error details. Source: CWSyncMgr::DoSync

Sync failed. Will retry in 60 minutes
```

Synchronization may fail because of authentication or proxy issues. When this issue occurs, you'll see an error similar to the following error in the WCM.log file:

```output
System.Net.WebException: The request failed with **HTTP status 502**  
```

The error might not always be HTTP status `502`. It might be one of the following errors:

- `HTTP Status 401 Unauthorized`
- `HTTP Status 403 Forbidden`
- `HTTP Status 407 Proxy Authentication Required`
- `HTTP Status 502 Proxy Error`
- `No connection could be made because the target machine actively refused it`
- `Authentication failed because the remote party closed the transport stream`

To troubleshoot authentication or proxy issues, follow these steps:

1. Verify that the **Update Services** service is running on the WSUS server.
1. Verify that the Default website or WSUS Administration website is running on the WSUS server.
1. Verify that the fully qualified domain name (FQDN) for the software update point site system server is correct and accessible from the site server.
1. If the software update point is remote from the site server, verify that you can connect to the WSUS server from the site server. For more information, see [Check connectivity from the site server to the WSUS server](#check-connectivity-from-the-site-server-to-the-wsus-server).
1. Check the port settings configured for the software update point. Verify that they're the same as the port settings configured for the website used by WSUS running on the software update point. For more information, see [Determine the port settings used by WSUS and the software update point](troubleshoot-software-update-scan-failures.md#determine-the-port-settings-used-by-wsus-and-the-software-update-point).
1. Verify that the proxy and account settings are correctly configured for the software update point. For more information, see [Proxy server settings](/intune/configmgr/sum/get-started/install-a-software-update-point#proxy-server-settings).
1. Verify that the software update point connection account is configured (if necessary). And verify that it has permissions to connect to the WSUS server. For more information, see [WSUS Server Connection Account](/intune/configmgr/sum/get-started/install-a-software-update-point#wsus-server-connection-account).
1. Verify that the permissions on the `ApiRemoting30` virtual directory are set correctly in IIS. When WSUS Synchronization Manager starts synchronization, the computer and Administrator accounts must have access to the `ApiRemoting30` virtual directory under the WSUS website in IIS. To check permissions on the `ApiRemoting30` virtual directory:
   1. On the WSUS server, open IIS Manager.
   1. Expand **Sites**, expand the website for the WSUS server, right-click the `ApiRemoting30` virtual directory, and then select **Edit Permissions**.
1. If the software update point is configured for SSL (HTTPS), verify that WSUS is correctly configured for SSL. For more information, see [Check SSL configuration](troubleshoot-software-update-scan-failures.md#check-ssl-configuration).
1. Review WSUSCtrl.log for errors. For more information, see [WSUS Control Manager reports an error](#wsus-control-manager-reports-an-error).

## Synchronization fails because of web service issues

Synchronization might fail because of issues with the web service. When this issue occurs, you see an error similar to the following errors in the WCM.log file:

```output
System.Net.WebException: The request failed with HTTP status 500

System.Net.WebException: The request failed with HTTP status 503
```

To troubleshoot web service issues, follow these steps:

1. Verify that the **Update Services** service is running on the WSUS server.
1. Verify that the Default website or WSUS Administration website is running on the WSUS server.
1. Check the port settings configured for the software update point. Verify that they're the same as the port settings configured for the website used by WSUS running on the software update point. For more information, see [Determine the port settings used by WSUS and the software update point](troubleshoot-software-update-scan-failures.md#determine-the-port-settings-used-by-wsus-and-the-software-update-point).
1. Review WSUSCtrl.log for errors. For more information, see [WSUS Control Manager reports an error](#wsus-control-manager-reports-an-error).

## Synchronization fails because of SSL issues

If you're using SSL, verify the following settings:

- Verify that the certificate configured for the WSUS website is configured with the correct FQDN. If the certificate doesn't have the correct FQDN, see [Add a subject alternative name to a secure LDAP certificate](../../../windows-server/windows-security/add-san-to-secure-ldap-certificate.md).
- Verify that the certificate hasn't expired.
- Verify that WSUS is correctly configured for SSL. For more information, see [Check SSL configuration](troubleshoot-software-update-scan-failures.md#check-ssl-configuration).

## Synchronization fails because of issues with the EULA

Synchronization issues can often be traced back to issues that relate to the End User Licensing Agreement (EULA). To verify whether this issue affects you, follow these steps:

1. Review the SoftwareDistribution.log file on the WSUS server to find out why the EULAs aren't downloading. Look for `.txt` in the log to find relevant entries.
1. Verify that the firewall is configured to allow communication with Microsoft Update. For more information, see [Connection from the WSUS server to the Internet](/windows-server/administration/windows-server-update-services/deploy/2-configure-wsus#211-connection-from-the-wsus-server-to-the-internet).
1. Verify the [proxy server settings](/intune/configmgr/sum/get-started/install-a-software-update-point#proxy-server-settings).
1. Run the following command from a Command Prompt to have WSUS download the missing content again, including EULAs:

```cmd
   %ProgramFiles%\Update Services\Tools\wsusutil.exe reset
```

## Synchronization fails because of errors communicating with Microsoft Update

When this issue occurs, you usually receive the following errors:

> A connection attempt failed because the connected party didn't properly respond after a period of time, or established connection failed because connected host didn't respond.
>
> 0x80072EFE - The connection with the server was terminated abnormally

To troubleshoot this issue, follow these steps:

1. Verify that the WSUS server can connect to the Internet.
1. Verify that the firewall is configured to allow communication with Microsoft Update. For more information, see [Connection from the WSUS server to the Internet](/windows-server/administration/windows-server-update-services/deploy/2-configure-wsus#211-connection-from-the-wsus-server-to-the-internet).
1. Verify the [proxy server settings](/intune/configmgr/sum/get-started/install-a-software-update-point#proxy-server-settings).

## WSUS Control Manager reports an error

Unlike WCM and WSyncMgr, WSUS Control Manager (WSUSCtrl) runs on the software update point (SUP) itself. If the SUP is remote, WSUSCtrl.log runs on the SUP instead of on the site server. WSUS Control Manager periodically checks WSUS to make sure that WSUS components are healthy. If WSUS components are unhealthy, WCM and WSyncMgr can't communicate with WSUS. In most cases, errors in WCM.log resemble the errors in WsyncMgr.log. However, an exception could be when the SUP is remote from the site server. If WSUS components are healthy, WSUSCtrl.log on the remote SUP doesn't report any errors. However, if the site server can't connect to the WSUS server remotely, you'll see errors in WCM.log and WSyncMgr.log even though WSUS itself is healthy.

To check whether WSUS is functioning as expected, run the following command on the WSUS server. Then review the Application log in Event Viewer for errors:

```cmd
%ProgramFiles%\Update Services\Tools\wsusutil.exe checkhealth
```

### Check connectivity from the site server to the WSUS server

If the WSUS server is remote from the site server, you must install the WSUS Administration console on the site server. The console installs the required APIs that Configuration Manager uses to connect to the WSUS server. To test whether Configuration Manager can connect to the WSUS server, use the locally installed WSUS Administration console.

To connect to the remote WSUS server by using the WSUS Administration console, follow these steps:

1. Start the WSUS Administration console.
1. Right-click **Update Services** in the tree view, and select **Connect to Server**.
1. Specify the **Server Name** and **Port Number** of the remote WSUS server, and then select **Connect**. Make sure that you specify the FQDN of the WSUS server and the correct port number.

## WSUS connection failures

For more information, see [Troubleshoot WSUS connection failures](troubleshoot-wsus-connection-failures.md).

## More information

- For more information about the software update synchronization process, see [Software updates synchronization](/mem/configmgr/sum/understand/software-updates-introduction#BKMK_Synchronization).
- You can also post a question in the [Configuration Manager support forum](https://techcommunity.microsoft.com/category/microsoftintune/discussions/configurationmanager).
- Visit [our blog](https://techcommunity.microsoft.com/t5/Configuration-Manager-Blog/bg-p/ConfigurationManagerBlog) for all the latest news, information, and tech tips on Configuration Manager.
