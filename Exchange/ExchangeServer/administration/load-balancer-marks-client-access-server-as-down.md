---
title: Load balancer marks Exchange server as down
description: Resolves an issue in which a Client Access server is down after you install Cumulative Update 6 in an Exchange Server 2013 environment.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# Load balancer marks Client Access server as down in an Exchange Server 2013 Cumulative Update 6 environment

_Original KB number:_ &nbsp; 3002351

## Symptoms

Assume that hardware load balancing is configured to monitor Exchange Server 2013 through the default website (such as https://**CAS**.**server_example**.com). You install [Cumulative Update 6](https://support.microsoft.com/help/2961810) for Exchange Server 2013 on the Client Access server. In this situation, the load balancer marks the server as down, and then it stops sending requests to the server.

Additionally, an HTTP proxy log entry that resembles the following is logged on the Client Access server:

```console
date time s-ip cs-method cs-uri-stem cs-uri-query s-port cs-username c-ip cs(User-Agent) cs(Referer) sc-status
sc-substatus sc-win32-status time-taken
2014-07-13 00:00:01 10.20.28.13 GET / Owa301RedirectUri=https://10.20.28.13/owa/ 443 - 10.20.123.249
- - 301 0 0 15
2014-07-13 00:00:04 10.20.28.13 GET / Owa301RedirectUri=https://10.20.28.13/owa/ 443 - 10.20.123.250
- - 301 0 0 0
2014-07-13 00:00:06 10.20.28.13 GET / Owa301RedirectUri=https://10.20.28.13/owa/ 443 - 10.20.123.249
- - 301 0 0 0
```

## Cause

This issue occurs because of a design change in Cumulative Update 6. If you try to access the default website of the Client Access server, the server that is running Exchange Server returns status 302, and then redirects you to the Outlook Web App (OWA) website.

## Resolution

To resolve this issue, configure the monitor to use a website that resembles https://**CAS**/**protocol**/healthcheck.htm.

For example, you can use the following website to monitor OWA on the Client Access server:  
https://**CAS.server_example.com**/owa/healthcheck.htm

## Status

Microsoft regularly releases software updates to address specific problems. If Microsoft releases a software update to resolve this problem, this article will be updated with additional information.
