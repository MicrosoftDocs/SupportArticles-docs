---
title: RDS License server logs Event 44 in Windows Server 2016 and 2012
description: Address the Event 44 on a Remote Desktop Services (RDS) licensing server that's running Windows Server 2016 and Windows Server 2012.
ms.date: 12/04/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Event 44 on an RDS licensing server running Windows Server 2016 or Windows Server 2012

[View the products that this article applies to.](#applies) 

On a Remote Desktop Services (RDS) licensing server that's running Windows Server 2016 or Windows Server 2012, the following entry for Event 44 is entered in the event log:
Event ID: 44
Log Name: System
Source: Microsoft-Windows-TerminalServices-Licensing
Date:
Event ID: 44
Task Category: None
Level: Error
Keywords: Classic
Computer: rds1.contoso.com
Description:
The following general database error has occurred: "ESE error -1316 JET_errInvalidObject, Object is invalid for operation.

_Original product version:_ &nbsp;   
_Original KB number:_ &nbsp; 4078299

## Cause

This event occurs because of a call on an object that's already opened.

## Resolution

This event can be safely ignored.

## Status

Microsoft is researching this issue and will post more information in this article when the information becomes available.

#### Applies to:


- Windows Server 2016
- Windows Server 2012
