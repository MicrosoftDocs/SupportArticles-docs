---
title: EWS Application pool crashes because the Exchange Server OAuth certificate is expired
description: Fixes an issue in which the EWS Application pool crashes every 10 – 15 minutes on all servers, and EWS applications throw HTTP 503 error.
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
ms.reviewer: Andreig, v-six
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
search.appverid: MET150
ms.date: 01/24/2024
---

# EWS Application pool crashes because the Exchange Server OAuth certificate is expired

## Symptoms

The Exchange Web Services (EWS) Application pool crashes every 10 – 15 minutes on all servers, and EWS applications throw HTTP 503 error. These events are logged in the Event Viewer:

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

The Exchange Server Open Authentication (OAuth) certificate is expired.

## Resolution

Refer to [this article](cannot-access-owa-or-ecp-if-oauth-expired.md#resolution) to renew the OAuth certificate.
