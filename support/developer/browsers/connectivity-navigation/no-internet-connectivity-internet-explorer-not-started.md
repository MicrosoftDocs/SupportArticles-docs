---
title: No Internet connectivity if Internet Explorer is not started
description: This article describes a problem where you may not be able to get Internet connectivity if Internet Explorer has not been started at least once in the current Windows session.
ms.date: 01/04/2021
ms.reviewer: pierrelc, aloot, andyriv
ms.topic: article
---
# No Internet connectivity if Internet Explorer is not started once

[!INCLUDE [](../../../includes/browsers-important.md)]

This article describes a problem where you may not be able to get Internet connectivity if Internet Explorer has not been started at least once in the current Windows session.

_Applies to:_ &nbsp; Internet Explorer 11  
_Original KB number:_ &nbsp; 3173620

## Symptoms

You receive multiple error messages that indicate that you don't have Internet connectivity. For example, you're prompted for authentication when you start an Office program. You notice that the problem is fixed when you start Internet Explorer and check that the proxy settings are correct in **Internet Options**.

## Cause

This problem occurs because many services use WinHTTP to access the Internet, and they must use the `WinHttpGetIEProxyConfigForCurrentUser` API to retrieve the proxy settings that are defined in Internet Explorer and used by WinINet. This API fails if the `DefaultConnectionSettings` registry value doesn't exist under the following registry subkey:

`HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Connections`

If the value doesn't exist, it's created automatically by Internet Explorer through WinINet when the browser starts for the first time in a Windows session.

## More information

To fully analyze the root cause of this problem, you must understand why your operating system installation method is using a configuration in which the `DefaultConnectionSettings` registry value doesn't exist. This is not expected because all out-of-the-box (OOB) operating system installations are configured to correctly create this registry key.

Depending on the root cause, you may have to take different actions. We don't provide general guidance for determining or fixing the root cause. However, you can work around this problem by writing a small program that uses the InternetSetOption WinINet API to create the `DefaultConnectionSettings` registry value, if the value doesn't exist. You can base the program on the following information:

> [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings]  
"AutoDetect"=1  
"AutoConfigURL"="URL"  
"ProxyEnable"=1  
"ProxyServer"="Proxy:Port"  
"ProxyOverride"="List"  

This method is explained in detail in the following article:

[Setting and Retrieving Internet Options](/windows/win32/wininet/setting-and-retrieving-internet-options)
