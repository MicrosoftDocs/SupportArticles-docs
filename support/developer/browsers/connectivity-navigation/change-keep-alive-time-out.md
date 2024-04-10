---
title: How to change keep-alive time-out in Internet Explorer
description: Provides the steps to change the default time-out value for persistent HTTP connections in Internet Explorer.
ms.date: 03/26/2020
---
# How to change the default keep-alive time-out value in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article describes how to change the default HTTP `keep-alive` value in Microsoft Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer 11, Internet Explorer 10, Internet Explorer 9  
_Original KB number:_ &nbsp; 813827

## Summary

When Internet Explorer establishes a persistent HTTP connection with a Web server (by using `Connection: Keep-Alive` headers), Internet Explorer reuses the same TCP/IP socket that was used to receive the initial request until the socket is idle for one minute. After the connection is idle for one minute, Internet Explorer resets the connection. A new TCP/IP socket is used to receive additional requests. You may want to change the HTTP `KeepAliveTimeout` value in Internet Explorer.

If either the client browser (Internet Explorer) or the Web server has a lower `KeepAlive` value, it is the limiting factor. For example, if the client has a two-minute timeout, and the Web server has a one-minute timeout, the maximum timeout is one minute. Either the client or the server can be the limiting factor.

By default, Internet Explorer has a `KeepAliveTimeout` value of one minute and an additional limiting factor (`ServerInfoTimeout`) of two minutes. Either setting can cause Internet Explorer to reset the socket.

## More information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Window](https://support.microsoft.com/help/322756).

You may have to increase the default time-out value for persistent HTTP connections in Internet Explorer if you are using a Web program that must communicate with Internet Explorer over the same TCP/IP socket after one idle minute. To change the default time-out value for persistent HTTP connections in Internet Explorer, add a **DWORD** value that is named `KeepAliveTimeout` to the following registry key, and then set its value data to the time (in milliseconds) that you want Internet Explorer to wait before resetting an idle connection:  
`HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\InternetSetting`

To change the default time-out value for persistent HTTP connections in Internet Explorer, follow these steps:

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.

2. Locate and then click the following key in the registry:  
   `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\InternetSetting`

3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Type *KeepAliveTimeout*, and then press ENTER.
5. On the **Edit** menu, click **Modify**.

6. Type the appropriate time-out value (in milliseconds), and then click **OK**. For example, to set the time-out value to two minutes, type *120000*.

7. Restart Internet Explorer. If you set the `KeepAliveTimeout` value to less than 60,000 (one minute), you may have problems communicating with Web servers that require persistent HTTP connections. For example, you may receive a **Page cannot be displayed** error message.

If you must have a `KeepAliveTimeout` value higher than 120000 (two minutes), you must create an additional registry key and set its value equal to the `KeepAliveTimeout` value that you want. The additional registry key is `ServerInfoTimeout`. It is a **DWORD** with a value (in milliseconds) and in the same location as `KeepAliveTimeout`.

For example, to use a three-minute `KeepAliveTimeout` value, you must create the following registry keys:

```console
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\InternetSetting  
KeepAliveTimeout DWORD value 180000 (in milliseconds)  
ServerInfoTimeout DWORD value 180000 (in milliseconds)
```

By default, HTTP 1.1 is enabled in Internet Explorer except when you establish an HTTP connection through a proxy server. When HTTP 1.1 is enabled, HTTP connections remain open (or persistent) by default until the connection is idle for one minute or until the value that is specified by the `KeepAliveTimeout` value in the registry is reached. You can modify HTTP 1.1 settings in Internet Explorer by using the **Advanced** tab in the **Internet Options** dialog box.
