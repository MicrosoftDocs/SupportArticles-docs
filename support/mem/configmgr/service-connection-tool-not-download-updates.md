---
title: Error downloading the ConfigMgr.AdminUIContent.cab file
description: Fixes an issue in which you encounter an AdminUIContentDownload error when you use ServiceConnectionTool.exe to download updates in Configuration Manager.
ms.date: 09/11/2020
ms.prod-support-area-path:
---
# The underlying connection was closed error when the service connection tool downloads the ConfigMgr.AdminUIContent.cab file

This article helps you fix an issue in which you encounter an AdminUIContentDownload error when you use ServiceConnectionTool.exe to download updates in Configuration Manager.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4561945

## Symptoms

When you use the service connection tool (ServiceConnectionTool.exe) to download and import updates in Configuration Manager current branch (version 2002 and earlier versions), the following error entry is logged in ServiceConnectionTool.log:

> ERROR:AdminUIContentDownloadDownload:DownloadManifestCab exception: The underlying connection was closed: An unexpected error occurred on a send.. There may be an issue with internet connection or the download link

## Cause

This issue occurs because TLS 1.2 isn't enabled. TLS 1.2 is required to download the .cab file.

## Workaround

To work around the issue, use either of the following methods:

- Manually download the **ConfigMgr.AdminUIContent.cab** file from [https://go.microsoft.com/fwlink/?LinkID=619849](https://go.microsoft.com/fwlink/?LinkID=619849), and save the file to the folder that's specified by the `-updatepackdest` parameter when you run th `serviceconnectiontool.exe` command. Then, rename the **ConfigMgr.AdminUIContent.cab** file to **ConfigMgr.AdminUIContent.auc**.

- On the computer that runs the service connection tool, set the following registry values, and then restart the computer:

  Subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319`

  Values:

  - `SystemDefaultTlsVersions` = **DWORD:00000001**  
  - `SchUseStrongCrypto` = **DWORD:00000001**
