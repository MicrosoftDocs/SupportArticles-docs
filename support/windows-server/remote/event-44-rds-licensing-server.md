---
title: RDS License server logs Event 44 in Windows Server 2016 and 2012
description: Address the Event 44 on a Remote Desktop Services (RDS) licensing server that's running Windows Server 2016 and Windows Server 2012.
ms.date: 12/04/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, robertvi, v-jesits
ms.prod-support-area-path: Remote Desktop Services (Terminal Services) licensing
ms.technology: windows-server-rds
---
# Event 44 on an RDS licensing server running Windows Server 2016 or Windows Server 2012

This article describes the Event 44 on an RDS licensing server running Windows Server 2016 or Windows Server 2012.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4078299

[View the products that this article applies to.](#applies-to)

On a Remote Desktop Services (RDS) licensing server that's running Windows Server 2016 or Windows Server 2012, the following entry for Event 44 is entered in the event log:
> Event ID: 44  
Log Name: System  
Source: Microsoft-Windows-TerminalServices-Licensing  
Date:  
Event ID: 44  
Task Category: None  
Level: Error  
Keywords: Classic  
Computer: `rds1.contoso.com`  
Description:  
The following general database error has occurred: "ESE error -1316 JET_errInvalidObject, Object is invalid for operation.

## Cause

This event occurs because of a call on an object that's already opened.

## Resolution

This event can be safely ignored.

## Status

Microsoft is researching this issue and will post more information in this article when the information becomes available.

### Applies to

- Windows Server 2016
- Windows Server 2012
