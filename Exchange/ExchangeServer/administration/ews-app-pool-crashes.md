---
title: EWS Application pool crashes because the Exchange Server OAuth certificate is expired
description: Describes how to fix an issue in which the EWS application pool crashes every 10 to 15 minutes on all servers, and EWS applications encounter an HTTP 503 error.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Exchange Service or Server Crashed/Stopped, Cluster service issues
  - Exchange Server
  - CSSTroubleshoot
  - CI 122417
  - CI 9823
  - CI 10005
ms.reviewer: Andreig, v-six, v-kccross
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 07/28/2026
---

# EWS application pool crashes because the Exchange Server OAuth certificate expired

## Summary

Users might experience the Exchange Web Services (EWS) application pool crashing or generating errors. This problem occurs when the Exchange Server Open Authentication (OAuth) certificate expires.

## Symptoms

The Exchange Web Services (EWS) application pool crashes every 10 to 15 minutes on all servers, and EWS applications encounter an HTTP 503 error. The application and system logs record events that you can view in the Event Viewer.

### Example: Events logged in the application log

```
Log Name:      Application
Source:        MSExchange Common
Date:          <Data time>
Event ID:      4999
Task Category: General
Level:         Error
Keywords:      Classic
User:          N/A
Computer:      Exchange2016.contoso.com
Description:
Watson report about to be sent for process id: 63200, with parameters: E12IIS, c-RTL-AMD64, 15.01.1979.003, w3wp#MSExchangeServicesAppPool, M.Exchange.Security, M.E.S.O.V1ProfileLocalTokenIssuer..ctor, M.E.S.OAuth.OAuthTokenRequestFailedException, 6446-dumptidset, 15.01.1979.003.
ErrorReportingEnabled: False 
```

### Example: Events logged in the system log

```
Log Name:      System
Source:        Microsoft-Windows-WAS
Date:          <Data time>
Event ID:      5011
Task Category: None
Level:         Warning
Keywords:      Classic
User:          N/A
Computer:     Exchange2016.contoso.com
Description:
A process serving application pool 'MSExchangeServicesAppPool' suffered a fatal communication error with the Windows Process Activation Service. The process id was '29492'. The data field contains the error number.
```

## Cause

The Exchange Server Open Authentication (OAuth) certificate expired.

## Resolution

To renew the OAuth certificate, see [cannot-access-owa-or-ecp-if-oauth-expired.md#resolution](cannot-access-owa-or-ecp-if-oauth-expired.md#resolution). To manage your OAuth certificate, use the [MonitorExchangeAuthCertificate.ps1](https://microsoft.github.io/CSS-Exchange/Admin/MonitorExchangeAuthCertificate/) PowerShell script.
