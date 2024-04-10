---
title: .NET Runtime Optimization Service Event 1101
description: This article describes that after Domain Controller promotion, .NET Runtime Optimization Service event 1101 error occurs.
ms.date: 05/06/2020
ms.reviewer: sabinn
---
# .NET Runtime Optimization Service event 1101 errors after Domain Controller promotion

This article helps you resolve the .NET Runtime Optimization Service event 1101 error that occurs after Domain Controller promotion.

_Original product version:_ &nbsp; Windows Server 2008 R2  
_Original KB number:_ &nbsp; 2002607

## Symptoms

A newly promoted Windows Server 2008 R2 Domain Controller writes the following two Application Event Log errors after its first reboot:

- .NET Runtime Optimization Service (clr_optimization_v2.0.50727_64)

    > Log Name: Application  
    > Source: .NET Runtime Optimization Service  
    > Date: 8/11/2009 1:53:26 PM  
    > Event ID: 1101  
    > Task Category: None  
    > Level: Error  
    > Keywords: Classic  
    > User: N/A  
    > Computer: computer_name.domain.com  
    > Description:  
    > .NET Runtime Optimization Service (clr_optimization_v2.0.50727_64) - Failed to compile: Microsoft.GroupPolicy.Targeting.Interop, Version=2.0.0.0, Culture=Neutral, PublicKeyToken=31bf3856ad364e35, processorArchitecture=amd64 . Error code = 0x800700b6

- .NET Runtime Optimization Service (clr_optimization_v2.0.50727_32)

    > Log Name: Application  
    > Source: .NET Runtime Optimization Service  
    > Date: 8/11/2009 1:51:29 PM  
    > Event ID: 1101  
    > Task Category: None  
    > Level: Error  
    > Keywords: Classic  
    > User: N/A  
    > Computer: computer_name.domain.com  
    > Description:  
    > .NET Runtime Optimization Service (clr_optimization_v2.0.50727_32) - Failed to compile: Microsoft.GroupPolicy.Targeting.Interop, Version=2.0.0.0, Culture=Neutral, PublicKeyToken=31bf3856ad364e35, processorArchitecture=x86 . Error code = 0x800700b6

The two errors only occur once and never repeat on the server again. The computer name in the above example is from a Microsoft training domain and will be different on your computer.

## Cause

This is caused by a managed code manifest linking defect with gppref.dll and comctl32.dll.

## Resolution

Ignore these two errors unless they occur under different circumstances than described in the [Symptoms](#symptoms) section. These errors are benign and cosmetic; they do not affect the functionality of any applications or of group policy processing.
