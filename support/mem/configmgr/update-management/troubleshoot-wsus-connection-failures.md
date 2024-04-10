---
title: Troubleshoot WSUS connection failures
description: Introduce several methods to troubleshoot WSUS issues.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Software Update Management (SUM)\WSUS Installation or Configuration
---
# How to troubleshoot WSUS connection failures

This article introduces several procedures for troubleshooting Windows Server Update Service (WSUS) connection failures.

> [!NOTE]
> **Home users**: This article is intended only for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com/).

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4025764

## Verify the prerequisites

- If you are using WSUS 3.0 SP2 on Windows Server 2008 R2, you must have update [4039929](https://support.microsoft.com/help/4039929) or a later-version update package installed on the WSUS server.

  To verify the server version, follow these steps:

  1. Open the WSUS console.
  2. Click the server name.
  3. Locate the version number under **Overview** > **Connection** > **Server Version**.
  4. Check whether the version is **3.2.7600.283** or a later version.

- If you are using WSUS on Windows Server 2012 or a later version, you must have one of the following Security Quality Monthly Rollups or a later-version rollup installed on the WSUS server:

  - Windows Server 2012 - [KB4039873](https://support.microsoft.com/help/4039873)
  - Windows Server 2012 R2 - [KB4039871](https://support.microsoft.com/help/4039871)
  - Windows Server 2016 - [KB4039396](https://support.microsoft.com/help/4039396/)

> [!NOTE]
> If you're using Configuration Manager and the software update point is installed on a remote site system server, the WSUS Administration Console must be installed on the site server. For WSUS 3.0 SP2, [KB 4039929](https://support.microsoft.com/help/4039929) or a later update must also be installed on the WSUS Administration console. After you install [4039929](https://support.microsoft.com/help/4039929) (remotely or locally), a server restart is required. After the restart, check whether the issue persists.

## Troubleshoot connection failures

To troubleshoot connection failures, follow these steps:

1. Verify that the **Update Services** service and the **World Wide Web Publishing Service** are running on the WSUS server.
2. Verify that the Default website or WSUS Administration website is running on the WSUS server.
3. Review the IIS logs for the WSUS Administration website (`c:\inetpub\logfiles`), and check for errors.

## Code definitions

The following table defines common error codes. For more information about HTTP status code in IIS, see [The HTTP status code in IIS 7 and later versions](https://support.microsoft.com/help/943891).

|ID|Explanation|
|---|---|
|200|Success|
|206|Continuation: OK|
|401|Authorization: OK if followed by 200|
|403|Access failure: Certificate issues or incorrect IIS configuration.|
|404|Not found: Missing Virtual directory or IIS configuration|
|500|Service not available|
|503|Busy: This can be caused by a WSUS application pool memory issue or just too many client connections. To fix the issue, increase the WSUS Application Pool Private memory limit to 4-8 GB. Some environments may require more than 8 GB; adjust this setting as needed. See [Configure an Application Pool to Recycle after Reaching Maximum Used Memory (IIS 7)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc725749(v=ws.10)?redirectedfrom=MSDN).|
  
> [!NOTE]
> Accessing most WSUS URLs in a browser will return a **403** error.  

**503** errors in IIS may be accompanied by _xxxx2ee2_ errors in the `c:\windows\windowsupdate.log` file on clients.

To resolve **503** IIS errors, a client time-out, or a large number of roundtrip errors, see [The complete guide to WSUS and Configuration Manager SUP maintenance](./wsus-maintenance-guide.md).

If a client's IP address doesn't appear in the IIS logs, verify that the client is set to connect to the correct WSUS server. This situation may also occur because of network blocking or because the server logs a special error.

- On the WSUS server, check the `C:\windows\system32\logfiles\httperr` logs for errors.
- On the client, check the following registry subkey to determine whether the correct FQDN of the WSUS server is set:

  `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate`

> [!NOTE]
> For Configuration Manager clients, check the `ccm\logs\locationservices.log` file for a WSUS entry to verify that the client is getting the correct server URL. You may have to force the Configuration Manager client to run another scan by using the Software Updates Scan Cycle from the agent in order for the service to log this entry.
