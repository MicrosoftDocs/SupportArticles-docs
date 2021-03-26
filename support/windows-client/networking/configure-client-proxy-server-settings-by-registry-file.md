---
title: Configure client proxy server settings
description: Describes how to create a Windows registry file to configure the proxy server settings on a client computer that's running Microsoft Internet Explorer or Windows Internet Explorer.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: TCP/IP communications
ms.technology: windows-client-networking
---
# Configure client proxy server settings by using a registry file

This article describes how to create a Windows registry file to configure the proxy server settings on a client computer that's running Microsoft Internet Explorer or Windows Internet Explorer.

_Original product version:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 819961

## Summary

You can automatically configure the proxy server settings on a client computer by updating the client computer registry. To do it, create a registry file that contains the registry settings you want to update. Then distribute it to the client computer by using a batch file or logon script.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

## Create a registry file

To configure the proxy server settings on a client computer, create the following .reg file to populate the registry with the proxy server information:

```console
Regedit4

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings]
"MigrateProxy"=dword:00000001
"ProxyEnable"=dword:00000001
"ProxyHttp1.1"=dword:00000000
"ProxyServer"="http://<ProxyServername>:80"
"ProxyOverride"="<local>"
```

In this file, \<ProxyServername> is the name of your proxy server.

## More information

You can also use the Internet Explorer Administration Kit (IEAK) to configure proxy server settings on client computers.
