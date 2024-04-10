---
title: WinInet not supported in services
description: Win32 Internet Functions (exported from WinInet.dll) are not supported in services. This article discusses using the WinInet.dll in a service or in Internet Information Server applications.
ms.date: 02/27/2020
ms.reviewer: leonbr
---
# WinInet is not supported in a service or an IIS application

[!INCLUDE [](../../../includes/browsers-important.md)]

The Microsoft Win32 Internet Functions (exported from WinInet.dll) are not supported when run from a service or an Internet Information Server (IIS) application (also a service). This article discusses using the WinInet.dll in a service or in IIS applications.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 238425

## More Information

Because IIS is a service, you will have the same set of problems running WinInet in an Internet Server Application Program Interface (ISAPI) extension or in a COM DLL--ActiveX DLL used by Active Server Pages (ASP)--as in running WinInet in a service. Running WinInet in an IIS application also has a unique set of problems.

The problem with running WinInet in a service is that WinInet uses settings from the registry for SSL information, proxy information, and more. Services do not load the `HKEY_CURRENT_USER` registry hive, so this information is not available.

> [!WARNING]
> Microsoft does not support using WinInet APIs within the context of a System Service.

WinInet APIs report access violations when used from the service over the SSL with Internet Explorer 5.0 installed.

In order to understand the limitations unique to using WinInet in a server environment, it is necessary to understand WinInet's history. WinInet was developed for use by Internet Explorer. In fact, to use later versions of WinInet, you must load a minimal installation of Internet Explorer. WinInet also exposes APIs for use by other client applications that wish to access resources on the Internet (or intranet). It is important to recognize the environment in which WinInet was developed and tested in order to understand the appropriate use for the DLL. WinInet was developed for use in a client environment. Although it is still acting as a client when it is running in an ISAPI DLL, it is running in a server environment in this case.

Client Environment: A person running the Internet Explorer

- Relatively low number of requests
- Requests made relatively consecutively
- Host application lifetime is short (length of browser session)

Server Environment: A Web server (such as `https://www.microsoft.com`)

- High number of requests per second
- Multiple threads making requests concurrently
- Must run for weeks or months

The preferred solution is to use WinHttp, which is designed to run in a service environment, and because it is a server-side HTTP stack, it is not bound to the two connection limit that is imposed by RFC 2616 that client-side HTTP stacks. This API set is similar in usage to WinInet so those familiar to WinInet will find it easy to adapt to.

Another solution is to use sockets directly the Platform SDK includes a sample that demonstrates how to use the WinSock over the SSL. You'll find a sample in the `\Microsoft Platform SDK\Samples\Winbase\Security\Ssl` folder of the SDK.

Another problem to be aware of when using WinInet in a server environment is the two-connection limit imposed by Internet Explorer.

While is possible to use WinInet in a service and in a server environment, it is not recommended nor is it supported by Microsoft. WinInet has not been tested in this configuration and problems do exist.
