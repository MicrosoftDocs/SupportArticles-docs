---
title: Can't consume web services via an HTTP proxy server
description: This article provides a resolution to fix the error that occurs on a .NET client that consumes a Web service via an HTTP proxy server.
ms.date: 05/06/2020
ms.reviewer: ryankiv, sulabhs
---
# Error occurs on a .NET client that consumes a Web service through an HTTP proxy server

This article helps you resolve a problem where an error (The underlying connection was closed: The remote name could not be resolved) occurs when you use a .NET client to consume a Web service through an HTTP proxy server.

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 318140

## Symptoms

When you use a .NET client to consume a Web service through an HTTP proxy server, you may receive the following error message:

> The underlying connection was closed: The remote name could not be resolved.

## Cause

An HTTP proxy server exists between the Web service and the .NET client, and the proper proxy settings have not been configured.

## Resolution

To resolve this problem, supply the proper proxy configuration settings to the .NET client.

The following are the default settings in the *Machine.config* file:

```xml
<configuration>
    <system.net>
        <defaultProxy>
            <proxy
               usesystemdefault = "true"
            />
        </defaultProxy>
    </system.net>
</configuration>
```

If the default settings do not automatically detect the proxy server settings, set `usessystemdefault` to **false**, and then explicitly designate the proxy server. To designate the proxy server explicitly, use either the *Machine.config* or *Web.config* file, or specify the server programmatically.

To specify the proxy server, set the *Machine.config* or *Web.config* file settings as follows:

```xml
<configuration>
    <system.net>
        <defaultProxy>
            <proxy
               usesystemdefault = "false"
               proxyaddress="http://proxyserver"
               bypassonlocal="true"
            />
        </defaultProxy>
    </system.net>
</configuration>
```

To change the settings programmatically by using a `WebProxy` object, use the following sample code:

```csharp
using System.Net;
com.someserver.somewebservice.someclass MyWebServiceClass = new com.someserver.somewebservice.someclass ();
IWebProxy proxyObject = new WebProxy ("http://myproxyserver:80", true);
MyWebServiceClass.Proxy = proxyObject;
MyWebServiceClass.MyWebMethod ();
```

## Proxy servers that require NTLM authentication

To set Windows NT LAN Manager (NTLM) authentication for the proxy server, use the following sample code:

```csharp
using System.Net;
WebProxy myProxy = new WebProxy ("http://proxyserver:port", true);
myProxy.Credentials = CredentialCache.DefaultCredentials;
FindServiceSoap myFindService = new FindServiceSoap ();
myFindService.Proxy = myProxy;
```

You can also use system-wide proxy as default. To do this, use the following settings in the configuration file:

```xml
<configuration>
    <system.net>
        <defaultProxy>
            <proxy
               proxyaddress = "http://proxyserver:80"
               bypassonlocal = "true"
            />
        </defaultProxy>
    </system.net>
</configuration>
```

## References

- [IWebProxy Interface](/previous-versions/visualstudio/x2bk5xs2(v=vs.118))
- [Element](/dotnet/framework/configure-apps/file-schema/network/defaultproxy-element-network-settings)
