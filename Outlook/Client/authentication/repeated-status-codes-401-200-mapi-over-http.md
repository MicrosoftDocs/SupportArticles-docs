---
title: Repeated status codes 401 and 200 when using MAPI over HTTP
description: Describes an expected behavior. Repeated HTTP status codes 401 and 200 are received in the server's Internet Information Services (IIS) log, or in the network capture of a client traffic. Provides a mitigation method.
author: v-lianna
ms.author: v-lianna
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CSSTroubleshoot
ms.reviewer: meerak, jonl, gbratton, mhaque
appliesto:
- Outlook for Office 365
search.appverid: MET150
---
# Repeated status codes 401 and 200 when using MAPI over HTTP

## Symptoms

Assume that you configure the [MAPI over HTTP](/exchange/clients/mapi-over-http/mapi-over-http) transport protocol in an Exchange Server 2016 on-premises environment. When you use a proxy auto-configuration (\.pac) file with the Negotiate authentication in Outlook for Microsoft 365, you receive HTTP response status codes [401 and 200](/troubleshoot/iis/http-status-code) repeatedly in the server's Internet Information Services (IIS) log or in the network capture of a client traffic.

## Cause

MAPI over HTTP uses two client/server sessions, one for change notifications that is opened when Outlook starts, and the other one for sending and receiving data, which is established on demand. The MAPI and HTTP sessions are on different layers. When the send/receive data MAPI sessions are established, a new HTTP session is created, and authentication occurs at the beginning of the HTTP session.

The [HTTP sessions authentication](https://datatracker.ietf.org/doc/html/rfc4559) Requests for Comment (RFC) describe the expected protocol sequence, which includes sending an empty authentication request, so the server will respond with the authentication protocols it supports. That enables the client to choose the appropriate authentication type. The repeated status codes 401 and 200 are expected as part of this process.

## Workaround

You can disable the automatic proxy setting to reduce the number of HTTP 401 responses. To do this, change or add the following registry value:

**Key**: `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Internet\`  
**Value name**: EnableHttpAccessTypeAutomaticProxy  
**Type**: REG_DWORD  
**Value data**: *0*

With this registry value, proxy configuration is handled by Outlook instead of Microsoft Windows HTTP Services (WinHTTP) so that Outlook can retain the server configuration and pre-authenticate future requests.
