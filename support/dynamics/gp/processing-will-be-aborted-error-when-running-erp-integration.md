---
title: Processing will be aborted error when running ERP Integration
description: Describes an error message when you run the ERP Integration from the Management Reporter Configuration Console. Provides a resolution.
ms.reviewer: theley, kevogt
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Management Reporter
---
# "Processing will be aborted. Error text: Compiler executable file csc.exe cannot be found" error when running ERP Integration in Management Reporter 2012

This article provides a resolution for the issue that you can't run the ERP Integration in Management Reporter 2012 due to the **Processing will be aborted** error.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP, Microsoft Dynamics SL 2011  
_Original KB number:_ &nbsp; 2800339

## Symptoms

When you run the Data Mart Integration from the Management Reporter Configuration Console, you receive the error:

> Processing will be aborted. Error text: Compiler executable file csc.exe cannot be found.

## Cause

Microsoft .NET Framework 3.5 is missing on the workstation.

## Resolution

You must install Microsoft .NET Framework 3.5 on the workstation where Management Reporter 2012 is installed. You can download .NET Framework 3.5 [here](https://www.microsoft.com/download/details.aspx?id=21).
