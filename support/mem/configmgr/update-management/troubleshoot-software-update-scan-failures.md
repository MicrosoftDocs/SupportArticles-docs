---
title: Troubleshoot software update scan failures
description: Describes how to troubleshoot software update scan failures in Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Troubleshoot software update scan failures in Configuration Manager

This article describes how to troubleshoot software update scan failures in Configuration Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 3090184

## Summary

There are several reasons that a software update scan could fail. Most problems involve communication or firewall issues between the client and the software update point computer. We describe some of the most common error conditions and their associated resolutions and troubleshooting tips here. For more information about Windows Update common errors, see [Windows Update common errors and mitigation](/windows/deployment/update/windows-update-errors).

For more information about software updates in Configuration Manager, see [Software updates introduction](software-updates-introduction.md).

When you troubleshoot software update scan failures, focus on the WUAHandler.log and WindowsUpdate.log files. WUAHandler just reports what the Windows Update Agent reported. So the error in the WUAHandler.log file would be the same error that was reported by the Windows Update Agent itself. Most information about the error will likely be found in the WindowsUpdate.log file. For more information about how to read the WindowsUpdate.log file, see [Windows Update log files](/windows/deployment/update/windows-update-logs).

## Scan failures due to missing or corrupted components

Errors 0x80245003, 0x80070514, 0x8DDD0018, 0x80246008, 0x80200013, 0x80004015, 0x800A0046, 0x800A01AD, 0x80070424, 0x800B0100, and 0x80248011 are caused by missing or corrupted components.

Several issues can be caused by missing or corrupted files or registry keys, component registrations, and so on. A good place to start is to run the [Windows Update Troubleshooter](https://support.microsoft.com/help/4027322/windows-update-troubleshooter) to detect and fix these issues automatically.

It's also a good idea to make sure that you're running [the latest version of the Windows Update Agent](https://support.microsoft.com/help/949104/how-to-update-the-windows-update-agent-to-the-latest-version).

If running the Windows Update Troubleshooter doesn't fix the problem, reset the Windows Update Agent data store on the client by following these steps:

1. Stop the Windows Update service by running the following command:

   ```console
   net stop wuauserv
   ```

2. Rename the `C:\Windows\SoftwareDistribution` folder to `C:\Windows\SoftwareDistribution.old`.
3. Start the Windows Update service by running the following command:

   ```console
   net start wuauserv
   ```

4. Start a software update scan cycle.

## Scan failures due to proxy-related issues

Errors 0x80244021, 0x8024401B, 0x80240030, and 0x8024402C are caused by proxy-related issues.

Verify the proxy settings on the client, and make sure that they are configured correctly. The Windows Update Agent uses WinHTTP to scan for available updates. When there's a proxy server between the client and the WSUS computer, the proxy settings must be configured correctly on the clients to enable them to communicate with WSUS by using the computer's FQDN.

For proxy issues, WindowsUpdate.log may report errors that resemble the following ones:

> 0x80244021 or HTTP Error 502 - Bad gateway

> 0x8024401B or HTTP Error 407 - Proxy Authentication Required

> 0x80240030 - The format of the proxy list was invalid

> 0x8024402C - The proxy server or target server name cannot be resolved

In most cases, you can bypass the proxy for local addresses because the WSUS computer is located within the intranet. But if the client is connected to the Internet, you must make sure that the proxy server is configured to enable that communication.

To view WinHTTP proxy settings, run one of the following commands:

- On Windows XP: `proxycfg.exe`
- On Windows Vista and later versions: `netsh winhttp show proxy`

Proxy settings that are configured in Internet Explorer are part of the WinINET proxy settings. WinHTTP proxy settings aren't necessarily the same as the proxy settings that are configured in Internet Explorer. However, if the proxy settings are set correctly in Internet Explorer, you can import the proxy configuration from Internet Explorer. To import proxy configuration from Internet Explorer, run one of the following commands:

- On Windows XP: `proxycfg.exe -u`
- On Windows Vista and later versions: `netsh winhttp import proxy source =ie`

For more information, see [How the Windows Update client determines which proxy server to use to connect to the Windows Update website](https://support.microsoft.com/help/900935).

## Scan failures related to HTTP time-out or authentication

Errors: 0x80072ee2, 0x8024401C, 0x80244023, or 0x80244017 (HTTP Status 401), 0x80244018 (HTTP Status 403)

Verify connectivity with the WSUS computer. During a scan, the Windows Update Agent must communicate with the `ClientWebService` and `SimpleAuthWebService` virtual directories on the WSUS computer to run a scan. If the client can't communicate with the WSUS computer, the scan fails. This issue can occur for several reasons, including:

- port configuration
- proxy configuration
- firewall issues
- network connectivity

First, find the URL of the WSUS computer by checking the following registry key:

`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate`

Try to access the URL to verify connectivity between the client and the WSUS computer. For example, the URL you use should resemble the following URL:  
`http://SUPSERVER.CONTOSO.COM:8530/Selfupdate/wuident.cab`

Then check whether the client can access the `ClientWebService` virtual directory. The URL should resemble the following URL:  
`http://SUPSERVER.CONTOSO.COM:8530/ClientWebService/wusserverversion.xml`

Finally, check whether the client can access the `SimpleAuthWebService` virtual directory. The URL should resemble the following URL:
`http://SUPSERVER.CONTOSO.COM:8530/SimpleAuthWebService/SimpleAuth.asmx`

If these tests are successful, review the Internet Information Services (IIS) logs on the WSUS computer to confirm that the HTTP errors are being returned from WSUS. If the WSUS computer doesn't return the error, the issue is probably with an intermediate firewall or proxy.

If any of these tests fails, check for name resolution issues on the client. Verify that you can resolve the FQDN of the WSUS computer.

Also verify the proxy settings on the client to make sure that they are configured correctly. For more information, see the [Scan failures due to proxy-related issues](#scan-failures-due-to-proxy-related-issues) section.

Finally, verify that the WSUS ports can be accessed. WSUS can be configured to use any of the following ports:

- 80
- 443
- 8530
- 8531

For clients to communicate with the WSUS computer, the appropriate ports must be enabled on any firewall between the client and the WSUS computer.

### Determine the port settings used by WSUS and the software update point

Port settings are configured when the software update point site system role is created. These port settings must be the same as the port settings that are used by the WSUS website. Otherwise, WSUS Synchronization Manager won't connect to the WSUS computer that's running on the software update point to request synchronization. The following procedures show how to verify the port settings that are used by WSUS and the software update point.

#### Determine the WSUS port settings in IIS 6.0

1. On the WSUS server, open Internet Information Services (IIS) Manager.
2. Expand **Web Sites**, right-click the website for the WSUS server, and then select **Properties**.
3. Select the **Web Site** tab.
4. The HTTP port setting is displayed in **TCP port**, and the HTTPS port setting is displayed in **SSL port**.

#### Determine the WSUS port settings in IIS 7.0 and later versions

1. On the WSUS server, open Internet Information Services (IIS) Manager.
2. Expand **Sites**, right-click the website for the WSUS server, and then select **Edit Bindings**.
3. In the **Site Bindings** dialog box, the HTTP and HTTPS port values are displayed in the **Port** column.

#### Verify and configure ports for the software update point

1. In the Configuration Manager console, go to **Administration** > **Site Configuration** > **Servers and Site System Roles**, and then select **\<SiteSystemName>** in the right pane.
2. In the bottom pane, right-click **Software Update Point** and then click **Properties**.
3. On the **General** tab, specify or verify the WSUS configuration port numbers.

After the ports are verified and configured correctly, you should check port connectivity from the client by running the following command:

```console
telnet SUPSERVER.CONTOSO.COM <PortNumber>
```

If the port is inaccessible, telnet returns an error that resembles the following.

> Could not open connection to the host, on port \<PortNumber>

This error suggests that firewall rules must be configured to enable communication for the WSUS Server ports.

## Scan fails with error 0x80072f0c

Error 0x80072f0c translates to **A certificate is required to complete client authentication**. This error should occur only if the WSUS computer is configured to use SSL. As part of the SSL configuration, WSUS virtual directories must be configured to use SSL, and they must be set to ignore client certificates. If the WSUS website or any of the virtual directories that were mentioned previously are configured incorrectly to **Accept** or **Require** client certificates, you receive this error.

### Check SSL configuration

When the site is configured in **HTTPS only** mode, the software update point is automatically configured to use SSL. When the site is in **HTTPS or HTTP** mode, you can choose whether to configure the software update point to use SSL. When the software update point is configured to use SSL, the WSUS computer must also be explicitly configured to use SSL. Before you configure SSL, you should review the [certificate requirements](/previous-versions/system-center/system-center-2012-R2/gg699362(v=technet.10)). And make sure that a server authentication certificate is installed on the software update point server.

#### Verify that the software update point is configured for SSL

1. On the Configuration Manager console, go to **Administration** > **Site Configuration** > **Servers and Site System Roles**, and then select **\<SiteSystemName>** in the right pane.
2. In the bottom pane, right-click **Software Update Point**, and then select **Properties**.
3. On the **General** tab, verify that the following option is enabled:  
    **Require SSL communication to the WSUS Server**

#### Verify that the WSUS computer is configured for SSL

1. Open the WSUS console on the software update point for the site.
2. In the console tree pane, select **Options**.
3. In the display pane, select **Update Source and Proxy Server**.
4. Verify that the **Use SSL when synchronizing update information** option is selected.

#### Add the server authentication certificate to the WSUS Administration website

1. On the WSUS computer, start Internet Information Services (IIS) Manager.
2. Expand **Sites**, right-click **Default Web Site** or the WSUS Administration website if WSUS is configured to use a custom website, and then select **Edit Bindings**.
3. Select the **HTTPS** entry, and then select **Edit**.
4. In the **Edit Site Binding** dialog box, select the server authentication certificate, and then select **OK**.
5. In the **Edit Site Binding** dialog box, select **OK**, and then select **Close**.
6. Exit IIS Manager.

> [!IMPORTANT]
> Make sure that the FQDN that is specified in the Site System properties matches the FQDN that is specified in the certificate. If the software update point accepts connections from the intranet only, the **Subject Name** or **Subject Alternative Name** must contain the intranet FQDN. When the software update point accepts client connections from the Internet only, the certificate must still contain both the Internet FQDN and the intranet FQDN, because WCM and WSyncMgr still use the intranet FQDN to connect to the software update point. If the software update point accepts connections from both the Internet and the intranet, both the Internet FQDN and the intranet FQDN must be specified by using the ampersand (&) symbol delimiter between the two names.

#### Verify that SSL is configured on the WSUS computer

For more information, see [Configure SSL on the WSUS server](/windows-server/administration/windows-server-update-services/deploy/2-configure-wsus#configure-ssl-on-the-wsus-server).

> [!IMPORTANT]
> You cannot configure the whole WSUS website to require SSL, because then all traffic to the WSUS site would have to be encrypted. WSUS encrypts update metadata only. If a computer tries to retrieve update files on the HTTPS port, the transfer will fail.

## Group Policy overrides the correct WSUS configuration information

The Software Updates feature automatically configures a local Group Policy setting for the Configuration Manager client, so that it's configured to use the software update point source location and port number. Both the server name and the port number are required for the client to find the software update point.

If an Active Directory Group Policy setting is applied to computers for software update point client installation, it overrides the local Group Policy setting. Unless the value of the setting that's defined in Group Policy is identical to the one that's being set by Configuration Manager (server name and port), the Configuration Manager software update scan will fail on the client. In this case, the WUAHandler.log file shows the following entry:

```output
Group policy settings were overwritten by a higher authority (Domain Controller) to: Server http://server and Policy ENABLED
```

To fix this issue, the software update point for client installation and software updates must be the same server. And it must be specified in the Active Directory Group Policy setting by using the correct name format and port information. For example, if the software update point was using the default website, the software update point would be *`http://server1.contoso.com:80`*.

## Clients can't find the WSUS server location

1. To understand how clients obtain the WSUS server location, see [WSUS server location](track-software-update-compliance-assessment.md#wsus-server-location). And review the client and management point logs.
2. [Enable verbose and debug logging on the client and management point](enable-verbose-logging.md#enable-verbose-and-debug-logging-on-the-client-and-management-point).
3. Verify that there are no communication errors in CcmMessaging.log on the client.
4. If the management point returns an empty WSUS location response, there may be a mismatch in the Content Version of WSUS. It could be a result of failed synchronization. To find the Content Version of the software update point, in Configuration Manager console, select **Monitoring** > **Software Update Point Synchronization Status**.
5. Review the data in `CI_UpdateSources`, `WSUSServerLocations` and `Update_SyncStatus` tables, verify that the Update Source Unique ID and Content Version match across these tables.

## Compliance results unknown

1. Review the PolicyAgent.log file on the client to verify that the client is receiving policies.
2. Verify that software update synchronization is successful on the software update point. If synchronization fails, [troubleshoot synchronization issues](troubleshoot-software-update-synchronization.md).
3. If the WUAHandler.log file doesn't exist and isn't created after you start a scan cycle, the issue most likely occurs because of one of the following reasons:
   - The [software update scan policy](track-software-update-compliance-assessment.md#software-update-scan-policy) isn't available
   - Clients can't find the [WSUS server location](track-software-update-compliance-assessment.md#wsus-server-location)
4. Verify that there are no communication errors in the CcmMessaging.log file on the client.
5. If the scan is successful, the client should send state messages to the management point to indicate the update status. To understand how state messages processing works, see [state message processing flow](track-software-update-compliance-assessment.md#state-message-processing-flow).

## Other issues

For more information, see [Troubleshoot client software update scanning](troubleshoot-software-update-management.md#troubleshoot-issues-in-step-1).
