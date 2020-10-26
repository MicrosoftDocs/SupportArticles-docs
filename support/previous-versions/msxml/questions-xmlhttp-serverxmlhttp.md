---
title: Questions about XMLHTTP and ServerXMLHTTP
description: This article describes the frequently asked questions about the XMLHTTP and ServerXMLHTTP objects.
ms.date: 10/20/2020
ms.prod-support-area-path: 
---
# Frequently asked questions about ServerXMLHTTP

This article describes the frequently asked questions about the XMLHTTP and ServerXMLHTTP objects.

_Original product version:_ &nbsp; Microsoft XML Parser  
_Original KB number:_ &nbsp; 290761

## Summary

This article answers some of the frequently asked questions about the `ServerXMLHTTP` object.

## More information

1. What is `ServerXMLHTTP`?

   `ServerXMLHTTP` provides methods and properties for server-safe HTTP access between different Web servers. You can use this object to exchange XML data between different Web servers.

1. How do you install `ServerXMLHTTP`?

   `ServerXMLHTTP` is included with the Microsoft XML Parser (MSXML) version 3.0 or later. You can download and install MSXML 3.0 from the Web site: [MSXML (Microsoft XML Parser) 3.0 Software Development Kit (SDK)](https://www.microsoft.com/download/details.aspx?id=4608).

1. What are the platform requirements for `ServerXMLHTTP`?

   `ServerXMLHTTP` support is only available on computers that have Windows 2000 installed or on computers that have Windows NT 4.0 with Internet Explorer 5.01 (or later) installed. It fails on other platforms, such as Windows 95 and Windows 98.

   Using `XMLHTTP` in server-side applications like Active Server Pages (ASP), in components that are hosted in COM+, in components that are used in ASP, or in Windows Services is not supported because `XMLHTTP` uses WinInet internally. For additional information, see [WinInet is not supported in a service or an IIS application](/troubleshoot/browsers/wininet-not-supported-in-services).

1. What is the difference between `XMLHTTP` and `ServerXMLHTTP`?

   `XMLHTTP` is designed for client applications and relies on URLMon, which is built upon Microsoft Win32 Internet (WinInet). `ServerXMLHTTP` is designed for server applications and relies on a new HTTP client stack, WinHTTP. `ServerXMLHTTP` offers reliability and security and is server-safe. For more information, see the MSXML Software Development Kit (SDK) documentation.

1. How do you choose between `XMLHTTP` and `ServerXMLHTTP`?

   As the name suggests, `ServerXMLHTTP` is recommended for server applications and `XMLHTTP` is recommended for client applications. `XMLHTTP` has some advantages such as caching and autodiscovery of proxy settings support. It can be used on Windows 95 and Windows 98 platforms, and it is well suited for single-user desktop applications.

1. What is the Proxy Configuration Utility?

   The WinHTTP Proxy Configuration Utility, Proxycfg.exe, allows you to configure WinHTTP to access HTTP and HTTPS servers through a proxy server. Because the `ServerXMLHTTP` component depends on WinHTTP proxy settings, an administrator can use the Proxycfg.exe utility as part of the deployment and installation process of an application that uses WinHTTP.

1. Does `ServerXMLHTTP` support SSL and Digital Certificates?

   The `ServerXMLHTTP` and `XMLHTTP` components have limited HTTPS support in MSXML3. Specifically, they do not fully support Secure Sockets Layer (SSL) certificates, which are used for authentication. The components do support the HTTPS protocol, but the request fails if the server requires a client certificate.

   `ServerXMLHTTP` includes SSL certificate support in MSXML 3.0 Service Pack 1.

1. What are the benefits of `ServerXMLHTTP`?

   - By using `ServerXMLHTTP`, XML data can be exchanged between local and remote systems as a stream or as XML documents.

   - Because the underlying protocol is HTTP or HTTPS, data can be exchanged between the systems that are behind firewalls.

   - `ServerXMLHTTP` can be used to send HTTP requests from different environments such as Active Server Pages (ASP), Visual Basic, and Visual C++.

1. What are the limitations of `ServerXMLHTTP`?

   The number of instances of `ServerXMLHTTP` that can exist simultaneously within a single process primarily depends upon the amount of memory available for applications on the system. However, other factors, such as CPU processing capacity, or available socket connections can further limit the number of instances that can be active simultaneously.

   With MSXML 3.0, the maximum number of instances that can exist simultaneously within a single process is 5,460.

1. Where can I find more information on `ServerXMLHTTP`?

   Most of the information in this article is gathered from the MSXML SDK, which can be downloaded from the XML section of the following MSDN Web site:

   [System.Xml Namespace](/dotnet/api/system.xml)

   This site has the latest information on MSXML technologies.
