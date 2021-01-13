---
title: Error downloading the ConfigMgr.AdminUIContent.cab file
description: Fixes an issue in which you encounter an AdminUIContentDownload error when you download updates for Configuration Manager either via Online Service Connection Point or ServiceConnectionTool.exe.
ms.date: 09/11/2020
ms.prod-support-area-path:
---
# The underlying connection was closed error when the SMS_DMP_DOWNLOADER component or Service Connection Tool downloads the ConfigMgr.AdminUIContent.cab file

This article helps you fix an issue in which you encounter an AdminUIContentDownload error when you use Online Service Connection Point or ServiceConnectionTool.exe to download updates in Configuration Manager.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4561945

## Symptoms

When you use the Service Connection Point set to Online mode, you may notice that no new Configuration manager releases appear in the console and the following error entry is logged in the DmpDownloader.log:

>Redirected to URL https://configmgrbits.azureedge.net/adminuicontent/ConfigMgr.AdminUIContent.cab~~

>Got fwdlink and recreating the httprequest/response~~

>ERROR: Failed to download Admin UI content payload with exception: The underlying connection was closed: An unexpected error occurred on a send.~~

>Failed to call AdminUIContentDownload. error = Error -2146233079~

When you use the Service Connection Point set to Offline mode and run a Service Connection Tool (ServiceConnectionTool.exe) to download and import updates in Configuration Manager current branch, the similar error entry is logged in ServiceConnectionTool.log:

> ERROR:AdminUIContentDownloadDownload:DownloadManifestCab exception: The underlying connection was closed: An unexpected error occurred on a send.. There may be an issue with internet connection or the download link

## Cause

This issue occurs because TLS 1.2 isn't enabled for .NET on the machine running Online Service Connection Point or Service Connection Tool. TLS 1.2 is required to download the .cab file.

## Resolution

To resolve the issue, use the following method:

- On the computer that runs the Online Service Connection Point or Service Connection Tool, make sure that the actions from the following docs article are performed: https://docs.microsoft.com/en-us/mem/configmgr/core/plan-design/security/enable-tls-1-2-server. In particular, if .NET updates are installed, set the following registry values, and then restart the computer:

  Subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319`

  Values:

  - `SystemDefaultTlsVersions` = **DWORD:00000001**  
  - `SchUseStrongCrypto` = **DWORD:00000001**

- As a workaround, if you use a Service Connection Tool, manually download the **ConfigMgr.AdminUIContent.cab** file from [https://go.microsoft.com/fwlink/?LinkID=619849](https://go.microsoft.com/fwlink/?LinkID=619849), and save the file to the folder that's specified by the `-updatepackdest` parameter when you run the `serviceconnectiontool.exe` command. Then, rename the **ConfigMgr.AdminUIContent.cab** file to **ConfigMgr.AdminUIContent.auc**.


