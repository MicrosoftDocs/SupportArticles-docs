---
title: FP cannot close table
description: Provides a solution to an error that occurs when you print any report or open any window.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "FP Can't Close Table" Error message displays when accessing windows or reports in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you print any report or open any window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2019355

## Symptoms

When you print any report or open any window, you receive the message:  

> FP can't close table.

## Cause

One cause can be the Anti-virus program you're using is setup to scan the Microsoft Dynamics GP folder on the workstation and/or scan the SQL or Microsoft Dynamics GP folder on the Server workstation.

## Resolution

Most Anti-virus programs have a setting where you can exclude certain directories within your workstation. The directories that you'll want to exclude are listed below:

On the Server Workstation:

- Microsoft Dynamics GP or Great Plains folder
- SQL folder
- Shared Drive that contains the Reports.dic or Forms.dic files
- %TEMP% folder

On the Client or Citrix/Terminal Workstation:

- Microsoft Dynamics GP or Great Plains folder
- %TEMP% folder  

> [!NOTE]
> If you have questions on how to set this up, you will want to contact the provider of the Anti-Virus program you are running.

## More information

It could also be related to Network issues if you see the message:
> "Error Accessing SQL"
