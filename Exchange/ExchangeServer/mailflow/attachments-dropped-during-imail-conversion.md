---
title: Attachments dropped during IMAIL conversion
description: Email messages with attachments sent to Exchange users are intermittently dropped during IMAIL conversion. Provides a resolution.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Need Help with Configuring Mailflow, Mail routing (Connectors, Domains)
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: michlee, v-six
appliesto: 
  - Exchange Server
search.appverid: MET150
---
# Attachments intermittently dropped during IMAIL conversion

_Original KB number:_ &nbsp; 2249287

## Symptoms

E-mails with attachments sent to Exchange Server users are intermittently dropped during IMAIL conversion.

The following events may be recorded as a result of the IMAIL conversion failure:

Event ID: 12003

> Product: Exchange  
Event ID: 12003  
Source: MSExchangeIS  
Version: 6.0  
Component: Information Store  
Symbolic Name: msgidIMAILGenericFailure3  
Message: Error {error code} occurred while processing message {message id} with subject '{subject}' from '{host name}'.  
[https://www.microsoft.com/technet/support/ee/transform.aspx?ProdName=Exchange&ProdVer=6.0&EvtID=12003&EvtSrc=MSExchangeIS&LCID=1033](https://www.microsoft.com/technet/support/ee/transform.aspx?ProdName=Exchange&ProdVer=6.0&EvtID=12003&EvtSrc=MSExchangeIS&LCID=1033)

Event ID: 327

> Product: Exchange  
Event ID: 327  
Source: MSExchangeTransport  
Version: 6.5.6940.0  
Component: Microsoft Exchange Transport  
Message: The following call : \<function name> to the store failed. Error code : \<error code>. MDB : \<value>. FID : \<value>. MID : \<value>. File : \<value>.  
[https://www.microsoft.com/technet/support/ee/transform.aspx?ProdName=Exchange&ProdVer=6.5.6940.0&EvtID=327&EvtSrc=MSExchangeTransport&LCID=1033](https://www.microsoft.com/technet/support/ee/transform.aspx?ProdName=Exchange&ProdVer=6.5.6940.0&EvtID=327&EvtSrc=MSExchangeTransport&LCID=1033)

## Cause

This issue is exposed during IMAIL conversion. While converting attachments, the Store will use either the `working directory` or the `Temporary File Path` to process the attachment.

If the value for the parameter `Temporary File Path` does not point to a valid location on the system drive, IMAIL conversion will fail.

Example:

```console
Key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MSExchangeIS\ParametersSystem`
Value name: Temporary File Path
Value type: REG_SZ
Value data: D:\Exchsrvr\Mdbdata
```

## Resolution

To resolve this issue, inspect the registry key:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MSExchangeIS\ParameterSystem\`

1. If the parameter `Temporary File Path` exists, ensure it is pointing to a valid path and the Local System Account has full access to the folder.

2. If the above parameter does not exist, ensure the parameter `Working Directory` exists and pointing to a valid path and the Local System Account has full access to the folder.

> [!NOTE]
> Since these settings are stored in String Values, it possible to have trailing spaces in these values that could also cause this issue.
