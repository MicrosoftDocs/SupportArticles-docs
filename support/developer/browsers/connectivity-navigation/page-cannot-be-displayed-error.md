---
title: Page Cannot be Displayed error
description: Microsoft identified an issue with how server connection failures can affect proxy server use by the web browser. You may receive a Page Cannot be Displayed error message in a corporate network. This article provides temporary workarounds to restore connectivity.
ms.date: 02/29/2020
---
# Page Cannot be Displayed error due to bad proxy server timeout

[!INCLUDE [](../../../includes/browsers-important.md)]

Microsoft identified an issue with how server connection failures can affect proxy server use by the web browser. You may receive a **Page Cannot be Displayed** error message in a corporate network. This article provides temporary workarounds to restore connectivity.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 2551554

## Symptoms

In rare scenarios, certain errors in a server connection can cause proxy servers to be added inappropriately to the list of bad proxy servers. These inappropriate additions cause Internet Explorer to rotate through the specified list of proxy servers, until all proxy servers are temporarily disabled. Then Internet Explorer displays the error saying **Page Cannot be Displayed**. The error remains until the bad proxy list is cleared. The list is cleared in 30 minutes, unless the default was overridden.

## Cause

Sometimes Internet Explorer cannot establish a connection to a given proxy server. When this happens, the server is added to a list of bad proxy servers. This addition prevents the proxy server from being reused until a period of time has passed. The default value for this period is 30 minutes.

Suppose an automatic proxy configuration script returns a PROXY list that specifies multiple proxy servers. In this case, a connection to the next proxy in the list is attempted. The process continues through the list until either a connection is established or the list is exhausted. The user receives a **Page Cannot Be Displayed** error message in Internet Explorer if the list is exhausted and no connection was established.

This entire process is designed to improve overall performance.

## Workaround

To work around this issue, restart Internet Explorer to clear the list of bad proxy servers.

Also, you can set a registry key to prevent Internet Explorer from adding proxy servers to the bad proxy list.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. Set a custom-retry interval for bad proxy servers under the following registry key:  
   `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings`

2. Create a **DWORD** value in this key named `BadProxyExpiresTime`, and assign a value of **0**. This value is in seconds. Setting this value to **0** prevents proxy servers from being added to the bad proxy list.

## More information

The `BadProxyExpiresTime` registry key was introduced with Internet Explorer 5.01, around April 2002. For more information, see [Internet Explorer does not retry bad proxy server for 30 minutes](https://support.microsoft.com/help/320507).
