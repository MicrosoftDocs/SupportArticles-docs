---
title: RDS License server logs Event 44 in Windows Server 2016 and 2012
description: Address the Event 44 on a Remote Desktop Services (RDS) licensing server that's running Windows Server 2016 and Windows Server 2012.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, robertvi, v-jesits
ms.custom: sap:Remote Desktop Services and Terminal Services\Licensing for Remote Desktop Services (Terminal Services), csstroubleshoot
---
# Event 44 on an RDS licensing server running Windows Server

This article describes the Event 44 on a Remote Desktop Licensing (RD Licensing) server that runs a supported version of Windows Server.

_Applies to:_ &nbsp; All supported versions of Windows Server  
_Original KB number:_ &nbsp; 4078299

[View the products that this article applies to.](#applies-to)

An RD Licensing server that's running a supported version of Windows Server records the following entry in the event log:  

> Event ID: 44  
> Log Name: System  
> Source: Microsoft-Windows-TerminalServices-Licensing  
> Date:  
> Event ID: 44  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> Computer: `rds1.contoso.com`  
> Description:  
> The following general database error has occurred: "ESE error -1316 JET_errInvalidObject, Object is invalid for operation.

## Cause

This event occurs because of a call on an object that's already opened.

## Resolution

You can safely ignore this event.

## Status

Microsoft is researching this issue and will post more information in this article when the information becomes available.

### Applies to

- All supported versions of Windows Server

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#terminal-server-licensing).
