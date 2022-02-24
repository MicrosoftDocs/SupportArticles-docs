---
title: Error downloading the ConfigMgr.AdminUIContent.cab file
description: An AdminUIContentDownload error occurs when you download updates for Configuration Manager by using service connection point online mode or ServiceConnectionTool.exe.
ms.date: 01/28/2022
---
# Error when downloading ConfigMgr.AdminUIContent.cab by using SMS_DMP_DOWNLOADER or ServiceConnectionTool.exe

When you use service connection point online mode or the service connection tool to download updates in Configuration Manager, you receive an AdminUIContentDownload error message.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4561945

## Symptoms

- If you have the service connection point (SMS_DMP_DOWNLOADER) set to online mode, you may notice that no new Configuration Manager releases appear in the console. Also, the following error entry is logged in the *DmpDownloader.log* file:

  > Redirected to URL `https://configmgrbits.azureedge.net/adminuicontent/ConfigMgr.AdminUIContent.cab`~~  
  > Got fwdlink and recreating the httprequest/response~~  
  > ERROR: Failed to download Admin UI content payload with exception: The underlying connection was closed: An unexpected error occurred on a send.~~  
  > Failed to call AdminUIContentDownload. error = Error -2146233079~

- You have the service connection point set to offline mode. You use the service connection tool (*ServiceConnectionTool.exe*) to download and import updates in Configuration Manager. Also, the following error entry is logged in the *ServiceConnectionTool.log* file:

  > ERROR:AdminUIContentDownloadDownload:DownloadManifestCab exception: The underlying connection was closed: An unexpected error occurred on a send. There may be an issue with internet connection or the download link.

## Cause

This issue occurs in one of the following situations:

- TLS 1.2 isn't enabled for .NET Framework on the computer that's running the online service connection point or service connection tool. TLS 1.2 is required to download the .cab file.
- The specific URLs that are required by the service connection point aren't included in the allowlist on your firewall or proxy server.

## Resolution
- If you don't have already, Please consider upgrading the server to Server 2016 or above, 
- Please make sure you have all the internet rules and exceptions in place for your proxy/firewall to allow the traffic, 
- Related docs
[Internet Access Requirement](https://docs.microsoft.com/en-us/mem/configmgr/core/plan-design/network/internet-endpoints). 
[ConfigMgr Proxy Exceptions](https://docs.microsoft.com/en-us/archive/blogs/configmgrdogs/configuration-manager-proxy-exceptions)


On the computer that runs the online service connection point or service connection tool, [enable TLS 1.2](/mem/configmgr/core/plan-design/security/enable-tls-1-2-server).
In particular, if .NET Framework updates are installed, set the following registry values, and then restart the computer:

   Subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319`

   Values:
   - `SystemDefaultTlsVersions` = **DWORD:00000001**  
   - `SchUseStrongCrypto` = **DWORD:00000001**

For more information about the specific URLs that are required by the service connection point, see [Service connection point](/mem/configmgr/core/plan-design/network/internet-endpoints#service-connection-point).

## Workaround
From the error on the DMPDownloader.log, Take the URL and manually download the cab file, Then copy the cab file over to <ConfigMgr Install Dir>\Inboxes\HMAN.box\CFD folder
Watch HMAN.log for processing details.


