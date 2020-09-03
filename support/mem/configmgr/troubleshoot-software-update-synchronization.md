---
title: Troubleshooting software update synchronization
description: Helps diagnose and resolve some common issues with software update synchronization in Configuration Manager.
ms.date: 05/25/2020
ms.prod-support-area-path: Software update point synchronization
---
# Troubleshooting software update synchronization in Configuration Manager

This article helps you diagnose and resolve some common issues with software update synchronization in Configuration Manager.

We'll begin by asking if the prerequisites for software update synchronization are met. If the prerequisites are met and you're still facing the issue, we'll take you through a series of steps to resolve your issue.

_Original product version:_ &nbsp; Configuration Manager (current branch), Microsoft System Center 2012 R2 Configuration Manager, Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 4505439

## Verify the Prerequisites

The first step in troubleshooting synchronization issues is to verify that the following prerequisites are met:

- Verify that [Prerequisites for software updates in Configuration Manager](/mem/configmgr/sum/plan-design/prerequisites-for-software-updates) are met.
- When the software update point is installed on a remote site system server, the WSUS Administration Console must be installed on the site server.
- Verify that WSUS running on a software update point is **not** configured to be a replica.

    To check this, open the WSUS console on the software update point and click **Options** in the console tree pane, then select **Update Source and Proxy Server** in the display pane.

- Verify that the **Update Services** service is running on the WSUS server.
- Verify that the default website or WSUS administration website is running on the WSUS server.

## Synchronization fails due to authentication and proxy issues

WSUS Configuration Manager (WCM) configures the WSUS server once every hour in order to ensure that the settings configured in WSUS match the setting specified in the Configuration Manager console.

If WCM fails to configure the WSUS server properly, synchronization attempts can fail with an error similar to the following screenshot:

:::image type="content" source="media/troubleshoot-software-update-synchronization/fail-error.png" alt-text="Fail error in Status Message Details." border="false":::

You will also find the following error in the WsyncMgr.log file on the site server (located in `\Logs`):

> Sync failed: WSUS server not configured. Please refer to WCM.log for configuration error details. Source: CWSyncMgr::DoSync
>
> Sync failed. Will retry in 60 minutes

Synchronization may fail due to authentication or proxy issues. When this occurs, you will see an error similar to the following error in the WCM.log file:

> System.Net.WebException: The request failed with **HTTP status 502**  

The error may not always be HTTP status 502, and may in fact be one of the following errors:

- HTTP Status 401 Unauthorized
- HTTP Status 403 Forbidden
- HTTP Status 407 Proxy Authentication Required
- HTTP Status 502 Proxy Error
- No connection could be made because the target machine actively refused it
- Authentication failed because the remote party has closed the transport stream

### Resolution

To fix authentication or proxy issues, do the following actions:

- Verify that the **Update Services** service is running on the WSUS server.
- Verify that the default website or WSUS administration website is running on the WSUS server.
- Verify that the fully qualified domain name (FQDN) for the software update point site system server is correct and accessible from the site server.
- If the software update point is remote from the site server, verify that you can connect to the WSUS server from the site server. To do this, connect to the remote WSUS server using the WSUS Administration Console.
- Check the port settings configured for the software update point, and verify that they are the same as the port settings configured for the web site used by WSUS running on the software update point.
- Verify that the proxy and account settings are properly configured for the software update point.
- Verify that the software update point connection account is configured (if necessary) and that it has rights to connect to the WSUS server.
- Verify that the permissions on the ApiRemoting30 virtual directory are set correctly in IIS.
- If the software update point is configured for SSL, verify that WSUS is properly configured for SSL. For more information, see [Secure WSUS with the Secure Sockets Layer Protocol](/windows-server/administration/windows-server-update-services/deploy/2-configure-wsus#25-secure-wsus-with-the-secure-sockets-layer-protocol).

## Synchronization fails due to web service issues

Synchronization may be failing due to issues with the web service. When this occurs, you will see an error similar to the following errors in the WCM.log file:

> System.Net.WebException: The request failed with **HTTP status 500**  

> System.Net.WebException: The request failed with **HTTP status 503**  

### Resolution

To fix web service issues, do the following:

- Verify that the **Update Services** service is running on the WSUS server.
- Verify that the default website or WSUS administration website is running on the WSUS server.
- Check the port settings configured for the software update point and verify that they are the same as the port settings configured for the web site used by WSUS running on the software update point
- Check the status of the **WsusPool Application Pool** and the **Private Memory Limit (KB)** for the application pool.

## Synchronization fails due to SSL issues

If you are using SSL, verify the following settings:

- Verify that the certificate configured for the WSUS website is configured with the proper FQDN. If the certificate doesn't have the proper FQDN, see [How to add a subject alternative name to a secure LDAP certificate](https://support.microsoft.com/help/931351).
- Verify that the certificate has not expired.
- Verify that WSUS is properly configured for SSL. For more information, see [Secure WSUS with the Secure Sockets Layer Protocol](/windows-server/administration/windows-server-update-services/deploy/2-configure-wsus#25-secure-wsus-with-the-secure-sockets-layer-protocol).

## Synchronization fails due to issues with the EULA

Synchronization issues can often be traced back to issues relating to the End User Licensing Agreement (EULA). To verify whether this is your issue, do the following actions:

1. Review the SoftwareDistribution.log file on the WSUS server to find out if the EULAs are not getting downloaded, and if so, why. Look for *.txt* in the log to find relevant entries.
2. Verify that the firewall is configured to allow communication with Microsoft Update. For more information, see [Connection from the WSUS server to the Internet](/windows-server/administration/windows-server-update-services/deploy/2-configure-wsus#211-connection-from-the-wsus-server-to-the-internet).
3. Verify the [Proxy server settings](/mem/configmgr/sum/get-started/install-a-software-update-point#proxy-server-settings).
4. Run the following command from a Command Prompt to have WSUS redownload the missing content, including EULAs:

    `%ProgramFiles%\Update Services\Tools\wsusutil.exe reset`

## Synchronization fails due to errors communicating with Microsoft Update

When this issue occurs, you usually receive errors similar to the following error:

> A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond.
>
> 0x80072EFE - The connection with the server was terminated abnormally

### Resolution

To fix this issue, do the following actions:

- Verify that the WSUS server can connect to the Internet.
- Verify that the firewall is configured to allow communication with Microsoft Update. For more information, see [Connection from the WSUS server to the Internet](/windows-server/administration/windows-server-update-services/deploy/2-configure-wsus#211-connection-from-the-wsus-server-to-the-internet).
- Verify the [Proxy server settings](/mem/configmgr/sum/get-started/install-a-software-update-point#proxy-server-settings).

## More information

- For more information about software update synchronization process, see [Software updates synchronization](/mem/configmgr/sum/understand/software-updates-introduction#BKMK_Synchronization).
- You can also post a question in our Configuration Manager support forum for security, updates, and compliance [here](https://social.technet.microsoft.com/Forums/en-US/home?forum=ConfigMgrCompliance).
- Visit [our blog](https://techcommunity.microsoft.com/t5/Configuration-Manager-Blog/bg-p/ConfigurationManagerBlog) for all the latest news, information, and tech tips on Configuration Manager.
