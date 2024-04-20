---
title: Internet Explorer uses proxy server for local IP address
description: This article provides a resolution for the problem that occurs when you connect to a Web server using the Internet Protocol (IP) address or Fully Qualified Domain Name (FQDN) on the local network.
ms.date: 01/21/2021
ms.custom: sap:Connectivity and Navigation
ms.reviewer: 
ms.topic: troubleshooting
---
# Internet Explorer Uses Proxy Server for Local IP Address Even if the Bypass Proxy Server for Local Addresses Option Is Turned On

[!INCLUDE [](../../../includes/browsers-important.md)]

This article helps you resolve the problem that occurs when you connect to a Web server using the Internet Protocol (IP) address or Fully Qualified Domain Name (FQDN) on the local network.

_Applies to:_ &nbsp; Windows 7 Enterprise, Windows 7 Enterprise N, Windows 7 Home Basic, Windows 7 Home Premium, Windows 7 Professional, Windows 7 Professional N, Windows 7 Starter, Windows 7 Starter N, Windows 7 Ultimate, Windows 7 Ultimate N, Microsoft Windows Server 2003 Standard Edition (32-bit x86), Internet Explorer  
_Original KB number:_ &nbsp; 262981

## Symptoms

When you connect to a Web server using the Internet Protocol (IP) address or Fully Qualified Domain Name (FQDN) on the local network, Microsoft Internet Explorer or Windows Internet Explorer connects through an assigned proxy server even if the **Bypass proxy server for local addresses** option is turned on.

However, if you connect to a Web server using the host name (for example, `http://webserver`) instead of the IP address (for example, `http://10.0.0.1`) or FQDN (for example, `http://webserver.domainname.com`), the proxy server is bypassed and Internet Explorer connects directly to the server.

## Cause

By default, only host names are checked when the **Bypass proxy server for local addresses** option is turned on.

## Resolution

To bypass a range of IP addresses or a specific domain name, specify the addresses in the proxy exception list:

1. In Internet Explorer, on the **Tools** menu, select **Internet Options**.
2. On the **Connections** tab, select **LAN Settings**.
3. Select **Advanced**, and type the appropriate information in the **Exceptions** area.

## Status

This behavior is by design.
