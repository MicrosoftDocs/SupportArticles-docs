---
title: Status codes 401 and 200 with MAPI over HTTP
description: Works around an expected behavior in which 401 and 200 HTTP status codes are continually logged in the server's IIS log or the network capture of client traffic.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: meerak, jonl, gbratton, mhaque, v-lianna
appliesto: 
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Repeated status codes "401" and "200" when using MAPI over HTTP

## Symptoms

Assume that you configure the [MAPI over HTTP](/exchange/clients/mapi-over-http/mapi-over-http) transport protocol in a Microsoft Exchange Server 2016 on-premises environment. After you start using a proxy auto-configuration (`.pac`) file that uses the Negotiate authentication in Outlook for Microsoft 365, HTTP response status codes [401 and 200](/troubleshoot/iis/http-status-code) are continually logged in the server's Internet Information Services (IIS) log or in the network capture of client traffic.

## Cause

MAPI over HTTP uses two client-server sessions, one for change notifications that is opened when Outlook starts, and one for sending/receiving data that is established on demand. The MAPI and HTTP sessions are on different layers. When the "send data" or "receive data" MAPI sessions are established, a new HTTP session is created, and authentication occurs at the beginning of the HTTP session.

The [HTTP sessions authentication](https://datatracker.ietf.org/doc/html/rfc4559) Request for Comment (RFC) describes the expected protocol sequence. This includes sending an empty authentication request so that the server responds by using the authentication protocols that it supports. This lets the client choose the appropriate authentication type. The repeated "401" and "200" status codes are expected as part of this process.

## Workaround

You can disable the automatic proxy setting to reduce the number of HTTP "401" responses. To do this, change or add the following registry value:

**Key**: `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Internet\`  
**Value name**: EnableHttpAccessTypeAutomaticProxy  
**Type**: REG_DWORD  
**Value data**: 0

After you set this registry value, proxy configuration is handled by Outlook instead of Microsoft Windows HTTP Services (WinHTTP). This enables Outlook to retain the server configuration and pre-authenticate future requests.
