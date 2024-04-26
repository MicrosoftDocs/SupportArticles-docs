---
title: DirectAccess clients may be unable to connect when a static proxy is configured
description: Describes an issue that occurs when you have the Remote Access role installed on a Windows Server 2012 R2-based server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika,AJAYPS, TODE, AMANJAIN
ms.custom: sap:Network Connectivity and File Sharing\TCP/IP Connectivity (TCP Protocol, NLA, WinHTTP), csstroubleshoot
---
# DirectAccess clients may be unable to connect when a static proxy is configured

This article provides workarounds for an issue that occurs when you have the Remote Access role installed on a Windows server.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 3017472

## Symptoms

Consider the following scenario:

- You have the Remote Access (DirectAccess) role installed on a Windows Server 2012 R2-based server.
- Windows 8 or Windows 8.1 clients connect to this DirectAccess server for corporate connectivity when they are outside the corporate network.
- You have a static proxy server that is configured on the DirectAccess clients.
- The static proxy server is manually configured or is set by using Group Policy. The configuration may also be a static path of a .pac proxy configuration file.  

In this scenario, DirectAccess clients may be unable to connect to the DirectAccess server for corporate connectivity and may be stuck at a "Connecting" status. Removing the static proxy settings from the client and then restarting the client enables the DirectAccess client to be connected.

## Cause

This issue occurs because the IP Helper service cancels the connection to the DirectAccess server as soon as it detects that there is a static proxy configured.

To work around this issue, use one of the following methods.

## Workaround 1

If you have DirectAccess clients that roam to locations where they will not be using a proxy server, you can use WPAD on your intranet to obtain a proxy setting for the clients. This enables the DirectAccess client not to use a proxy when the client is roaming and has to connect to the DirectAccess server.

## Workaround 2

You can add an exception for the DirectAccess server in the advanced settings to skip the proxy for just the DirectAccess server address. For example, you could add `directaccess.contoso.com` as an exception for the DirectAccess server, or you could add *.directaccess.contoso.com if there are multiple DirectAccess servers.
