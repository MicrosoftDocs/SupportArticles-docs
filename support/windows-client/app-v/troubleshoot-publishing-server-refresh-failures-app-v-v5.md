---
title: How to troubleshoot publishing server refresh failures in App-V v5
description: Describes how to troubleshoot publishing server refresh failures in App-V v5.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jeffpatt
ms.custom: sap:publishing-server-issue, csstroubleshoot
---
# How to troubleshoot publishing server refresh failures in App-V v5

This article describes how to troubleshoot publishing server refresh failures in Microsoft Application Virtualization (App-V) v5.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2778168

## Summary

Perform the steps listed below to troubleshoot this issue.

### Step 1: Verify the publishing server URL configured on the client

To verify the publishing server URL, perform the following steps:

1. On the App-V Client, open an elevated PowerShell command prompt.
2. Type *Get-AppvPublishingServer* and hit enter.
3. Verify the URL listed in the output is correct.

    If the publishing server name is PubSvr and the publishing server port is 82, the URL listed in the `Get-AppvPublishingServer` output should be: `http://PubSvr:82`or `https://PubSvr:82`

If the publishing server URL is incorrect, use the `Remove-AppvPublishingServer` cmdlet to remove the publishing server. Then use the `Add-AppvPublishingServer` cmdlet to add the publishing server with the correct URL.

Sample commands to remove and readd the publishing server:

```powershell
Remove-AppvPublishingServer -ServerId 1
Add-AppvPublishingServer -Name PublishingSever -URL http://PubSvr:82
```

Common errors that are logged on the App-V client if the publishing server URL is incorrect:

- PowerShell
    > Sync-AppvPublishingServer: Application Virtualization Service failed to complete requested operation.  
    Operation attempted: RefreshPublishingServer.  
    Internet Error: 0x80072EE7 - The server name or address could not be resolved.  
    Error module: Publishing. Internal error detail: 45500D2780072EE7.  
    Please consult AppV Client Event Log for more details.  

    > Sync-AppvPublishingServer: Application Virtualization Service failed to complete requested operation.  
    Operation attempted: RefreshPublishingServer.  
    AppV Error Code: 0500090001.  
    Error module: Shared Component. Internal error detail: 3E50110500090001.  
    Please consult AppV Client Event Log for more details.

- APP-V Event Log
    > Log Name: Microsoft-AppV-Client/Admin  
    Source: Microsoft-AppV-Client  
    Event ID: 19102  
    Task Category: Publishing Refresh  
    Level: Error  
    Description:  
    Getting server publishing data failed.  
    URL: `http://PubSvr:82/`  
    Error code: 0x45500D27 - 0x80072EE7

    > Log Name: Microsoft-AppV-Client/Admin  
    Source: Microsoft-AppV-Client  
    Event ID: 19203  
    Task Category: Publishing Refresh  
    Level: Error  
    Description:  
    HttpRequest sendRequest failed.  
    URL: `http://PubSvr:82/`  
    Error code: 0x45500D27 - 0x80072EE7

    > Log Name: Microsoft-AppV-Client/Admin  
    Source: Microsoft-AppV-Client  
    Event ID: 19205  
    Task Category: Publishing Refresh  
    Level: Error  
    Description:  
    The content from server is not valid XML for publishing.  
    URL: `http://PubSvr:82/`  
    Error code: 0x3E501105 - 0x90001

    > Log Name: Microsoft-AppV-Client/Admin  
    Source: Microsoft-AppV-Client  
    Event ID: 19102  
    Task Category: Publishing Refresh  
    Level: Error  
    Description:  
    Getting server publishing data failed.  
    URL: `http://PubSvr:82/`  
    Error code: 0x3E501105 - 0x90001

### Step 2: Add Windows Firewall exception on the publishing server  

If the Windows Firewall is enabled on the publishing server, an Inbound Rule must be added to allow inbound connections on the port used by the publishing server.

To add an **Inbound Rule**, perform the following steps:

1. On the publishing server, open the **Windows Firewall**.
2. Click **Advanced Settings**.
3. Right-click on **Inbound Rules** and select **New Rule**.
4. Select **Port** and click **Next**.
5. Select **TCP**, specify the port used by the publishing server and click **Next**.
6. Select the appropriate connection condition for your environment and click **Next**.
7. Select the appropriate profile and click **Next**.
8. Provide a name for the **Inbound Rule** and click **Finish**.

Common errors that are logged on the App-V client if the firewall port is blocked:

- PowerShell
    > Sync-AppvPublishingServer : Application Virtualization Service failed to complete requested operation.  
    Operation attempted: RefreshPublishingServer.  
    Internet Error: 0x80072EE2 - The operation timed out  
    Error module: Publishing. Internal error detail: 45500D2780072EE2.  
    Please consult AppV Client Event Log for more details.

- App-V Event Logs
    > Log Name: Microsoft-AppV-Client/Admin  
    Source: Microsoft-AppV-Client  
    Event ID: 19102  
    Task Category: Publishing Refresh  
    Description:  
    Getting server publishing data failed.  
    URL: `http://PubSvr:82/`  
    Error code: 0x45500D27 - 0x80072EE2

    > Log Name: Microsoft-AppV-Client/Admin  
    Source: Microsoft-AppV-Client  
    Event ID: 19203  
    Task Category: Publishing Refresh  
    Description:  
    HttpRequest sendRequest failed.  
    URL: `http://PubSvr:82/`  
    Error code: 0x45500D27 - 0x80072EE2

### Step 3: Verify the publishing server site is started on the publishing server  

To verify the publishing server site is started, perform the following steps:

1. On the publishing server, open the **IIS Manager** console.
2. Click **Sites**.
3. Verify the **Microsoft App-V Publishing Service** site is **Started**.

Common errors that are logged on the App-V client if the publishing server site is not started:

- PowerShell
    > Sync-AppvPublishingServer : Application Virtualization Service failed to complete requested operation.  
    Operation attempted: RefreshPublishingServer.  
    Internet Error: 0x80072EE2 - The operation timed out  
    Error module: Publishing. Internal error detail: 45500D2780072EE2.  
    Please consult AppV Client Event Log for more details.

- App-V Event Logs
    > Log Name: Microsoft-AppV-Client/Admin  
    Source: Microsoft-AppV-Client  
    Event ID: 19102  
    Task Category: Publishing Refresh  
    Level: Error  
    Description:  
    Getting server publishing data failed.  
    URL: `http://PubSvr:82/`  
    Error code: 0x45500D27 - 0x80072EE2

    > Log Name: Microsoft-AppV-Client/Admin
    Source: Microsoft-AppV-Client
    Event ID: 19203
    Task Category: Publishing Refresh
    Level: Error
    Description:
    HttpRequest sendRequest failed.
    URL: `http://PubSvr:82/`
    Error code: 0x45500D27 - 0x80072EE2

### Step 4: Verify the publishing server application pool is started on the publishing server

To verify the publishing server application pool is started, perform the following steps:

1. On the publishing server, open the **IIS Manager** console.
2. Click **Application Pools**.
3. Verify the **AppVPublishing application pool** is **Started**.

Common errors that are logged on the App-V client if the **AppVPublishing application pool** is not started:

- PowerShell
    > Sync-AppvPublishingServer : Application Virtualization Service failed to complete requested operation.  
    Operation attempted: RefreshPublishingServer.  
    Windows Error: 0x801901F7 -  
    Error module: Publishing. Internal error detail: 45500D27801901F7.  
    Please consult AppV Client Event Log for more details.  

- App-VEvent Logs
    > Log Name: Microsoft-AppV-Client/Admin  
    Source: Microsoft-AppV-Client  
    Event ID: 19102  
    Task Category: Publishing Refresh  
    Level: Error  
    Description:  
    Getting server publishing data failed.  
    URL: `http://PubSvr:82/`  
    Error code: 0x45500D27 - 0x801901F7

    > Log Name: Microsoft-AppV-Client/Admin  
    Source: Microsoft-AppV-Client  
    Event ID: 19203  
    Task Category: Publishing Refresh  
    Level: Error  
    Description:  
    HttpRequest sendRequest failed.  
    URL: `http://PubSvr:82/`  
    Error code: 0x45500D27 - 0x801901F7

### Step 5: Verify the publishing server URL is accessible using a web browser  

On the App-V client, access the publishing server URL (for example, `http://PubSvr:82/`) using a web browser. If the publishing server is working properly and is accessible, an XML output will be displayed which lists the applications published on the publishing server:

```xml
- <Publishing Protocol="1.0">
- <Packages>
  <Package PackageId="639138dd-a4f5-4846-bab2-02e94a87c8a6" VersionId="b29da9c2-07d1-4fac-97ca-4f081c487c79" PackageUrl="\\pubsvr\content\Office 2013 AppV Package\ProPlusVolume_VisioProVolume_ProjectProVolume_en-us_x86.appv" /> 
  </Packages>
- <NoGroup>
  <Package PackageId="639138dd-a4f5-4846-bab2-02e94a87c8a6" />
  </NoGroup>
  </Publishing>
```

In the example above, Office 2013 is the only package currently published on the publishing server.

### Step 6: Perform a publishing server refresh  

After performing the steps above, perform a manual publishing refresh to verify no errors are logged.

There are two methods to manually perform a publishing refresh:

- In PowerShell, use the `Sync-AppvPublishingServer` cmdlet.
- In the App-V client console, click **Update**.

> [!Note]
> The Update box will be greyed out if a publishing server hasn't been configured on the client machine.
