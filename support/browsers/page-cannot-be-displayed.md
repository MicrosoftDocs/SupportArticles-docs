---
title: Page Cannot be Displayed error
description: Microsoft identified an issue with how server connection failures can affect proxy server use by the web browser. You may receive a 'Page Cannot be Displayed' error message in a corporate network. This article provides temporary workarounds to restore connectivity.
ms.prod-support-area-path: Internet Explorer
ms.date: 02/14/2020
---
# Internet Explorer "Page Cannot be Displayed" error due to bad proxy server timeout

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 2551554

Microsoft identified an issue with how server connection failures can affect proxy server use by the web browser. You may receive a **Page Cannot be Displayed** error message in a corporate network. This article provides temporary workarounds to restore connectivity.

[!INCLUDE[Visual eye catcher for legacy KB](../includes/kb-letters-blue.md)]

## Symptoms

In rare scenarios, it is possible for certain server connection errors to result in proxy servers being added to the bad proxy list incorrectly, causing Internet Explorer to rotate through the specified list of proxy servers until all are temporarily disabled. At this point, Internet Explorer will show a “Page Cannot be Displayed” error until the bad proxy list is cleared (30 minutes later by default).

## Cause

For performance reasons, in the event that Internet Explorer cannot establish a connection to a proxy server, that proxy server is added to a list of bad proxy servers so that it is not reused for a period of time. This period of time is 30 minutes by default. If an automatic proxy configuration script returns a PROXY list that specifies multiple proxy servers, a connection to the next proxy in the list will be attempted. If that connection fails, then the process repeats until a connection is established or the list is exhausted. If the list is exhausted and no connection was established, the user will receive a "Page Cannot Be Displayed" error message in Internet Explorer.

Microsoft is investigating the issue and available options. If you encounter this issue, there are temporary workarounds that can restore connectivity.

## Workaround

To work around this issue, restart Internet Explorer to clear the list of bad proxy servers.

Also, you can set a registry key to prevent Internet Explorer from adding proxy server to the bad proxy list.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. Set a custom-retry interval for bad proxy servers under the following registry key:  
   `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings`

2. Create a **DWORD** value in this key named **BadProxyExpiresTime**, and assign a value of **0**. Note that this value is in seconds. Setting this value to 0 will prevent proxy servers from being added to the bad proxy list.

## More Information

BadProxyExpiresTime was introduced with Internet Explorer 5.01. For more information, see the following article:

- [Internet Explorer does not retry bad proxy server for 30 minutes](https://support.microsoft.com/help/320507)
