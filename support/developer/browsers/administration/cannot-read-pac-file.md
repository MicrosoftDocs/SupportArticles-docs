---
title: Can't read PAC files referenced by file protocol
description: Describes an issue in which Windows 10 doesn't read automatic proxy configuration file referenced using the file protocol.
ms.date: 03/26/2020
ms.reviewer: Aloot, pierrelc
---
# Windows 10 doesn't read a PAC file referenced by a file protocol

[!INCLUDE [](../../../includes/browsers-important.md)]

This article solves an issue where Internet Explorer or Microsoft Edge can't read a proxy auto-configuration (PAC) file referenced by a file protocol.

_Original product version:_ &nbsp; Windows 10, Microsoft Edge, Internet Explorer 11  
_Original KB number:_ &nbsp; 4025058

## Symptoms

Consider the following scenario:

- You configured Microsoft Internet Explorer 11 or Microsoft Edge on Windows 10 to use the **Use Automatic Configuration script** option.
- You're testing or deploying a PAC file. You're storing the file in a local location, such as *C:\temp\proxy.pac*.
- You specified the file location in the **Use Automatic Configuration script** option in **Internet Setting** by using the file protocol.
- You created the following registry subkey:

    ```console
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\  
    Value: EnableLegacyAutoProxyFeature  
    Type:REG_DWORD  
    Data:1
    ```

In this scenario, the PAC file isn't read by Internet Explorer or Microsoft Edge.

## Cause

This issue occurs because Internet Explorer and Microsoft Edge on Windows 10-based computers use the WinHttp proxy service to retrieve proxy server information. The WinHttp Proxy service doesn't support using the `ftp://` or `file://` protocol for a PAC file.

## Resolution

To resolve this issue, host the PAC file on a web server, and then refer to it by using the http protocol.

> [!NOTE]
> The **application/x-ns-proxy-autoconfig** MIME type has to be specified for the PAC file on the web server in order for the WinHttp proxy service to consume the PAC file.  
> If not, the extension of the PAC file has to be *.dat*, *.js*, *.pac*, or *.jvs*.
