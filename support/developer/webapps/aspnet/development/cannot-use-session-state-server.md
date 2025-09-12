---
title: Unable to use session state server
description: This article provides resolutions for the error that occurs when you add the setting <httpRuntime enableVersionHeader ="false"/> to the state server web.config.
ms.date: 08/06/2020
ms.custom: sap:General Development
---
# Unable to use session state server because this version of ASP.NET requires session state server version 2.0 or above

This article helps you resolve the problem that occurs when you add the setting `<httpRuntime enableVersionHeader ="false"/>` to the state server web.config (master web.config) to hide the `X-AspNet-Version: 2.0.50727` header while using the session management with ASP.NET state service.

_Original product version:_ &nbsp; Microsoft ASP.NET  
_Original KB number:_ &nbsp; 2836759

## Symptoms

While using the session management with ASP.NET state service, if you add the setting `<httpRuntime enableVersionHeader ="false"/>` to the state server web.config (master web.config) to hide the `X-AspNet-Version: 2.0.50727` header, you may receive the following error:

> HttpException (0x80004005): Unable to use session state server because this version of ASP.NET requires session state server version 2.0 or above.

This exception occurs the first time the session cache is used after the application is published to the server, or after IIS is restarted, or after the application pool recycles. Subsequent uses of the session cache after the first exception is thrown do not result in an error. The session cache continues to work properly until the next application republish, IIS restart, or application pool recycle.

## Cause

The `X-AspNet-Version: 2.0.50727` header is sent by the state service to IIS. When sending the response back to the web application the state server should be including this header.

If we add the setting `<httpRuntime enableVersionHeader ="false"/>` to the state server web.config (master web.config), this header will not be sent from the state server to IIS and hence it throws the exception noted above.

## Resolution

1. Add `<httpRuntime enableVersionHeader ="true"/>` to the master web.config. The master web.config is found at `C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\CONFIG\web.config` or `C:\WINDOWS\Microsoft.NET\Framework64\v2.0.50727\CONFIG\web.config` depending on the bitness.

2. Add `<httpRuntime enableVersionHeader ="false"/>` to local web.config of the application.

    > [!NOTE]
    > Make sure you restart the state service after the configuration changes.

## More information

Since the `X-AspNet-Version: 2.0.50727` header is sent by the state server, setting `<httpRuntime enableVersionHeader ="true"/>` on the master web.config will ensure that the state server is sending the header to IIS. When `<httpRuntime enableVersionHeader ="false"/>` is set at the application level web.config, IIS will not send the header to the browser and you will not be able to see the `X-AspNet-Version: 2.0.50727` header in a network trace.

A better way to monitor the network traffic is to set just `<httpRuntime enableVersionHeader ="true"/>` in the master web.config and then you will see in a network trace the below snippet with the frame details being sent from the state server to IIS by ASPNET.

```console
00 15 5D F4 C0 6D 00 15 5D F1 3E 65 08 00 45 00 00 7A 79 D2 40 00 80 06 00 00 AC 16 F2 11 AC 16
F2 2F A5 B8 12 E4 2E 55 75 CA 57 D4 A3 18 50 18 FF 15 3C DB 00 00 32 30 30 20 4F 4B 0D 0A 58 2D
41 73 70 4E 65 74 2D 56 65 72 73 69 6F 6E 3A 20 32 2E 30 2E 35 30 37 32 37 0D 0A 43 61 63 68 65
2D 43 6F 6E 74 72 6F 6C 3A 20 70 72 69 76 61 74 65 0D 0A 43 6F 6E 74 65 6E 74 2D 4C 65 6E 67 74
68 3A 20 30 0D 0A 0D 0A

..]ôÀm..]ñ>e..E..zyÒ@.?...¬.ò.¬.ò/¥¸.ä.UuÊWÔ£.P.ÿ.<Û..200 OK..X-AspNet-Version: 2.0.50727..
Cache-Control: private..Content-Length: 0....
```
