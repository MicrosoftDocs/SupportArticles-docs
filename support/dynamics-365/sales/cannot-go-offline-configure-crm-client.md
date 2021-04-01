---
title: Cannot go offline or configure CRM Client
description: Provides a solution to errors that occur after you rename the computer.
ms.reviewer: chanson, henningp
ms.topic: troubleshooting
ms.date: 
---
# You cannot go offline or configure the Microsoft Dynamics CRM Client for Microsoft Office Outlook after you rename the computer

This article provides a solution to errors that occur after you rename the computer.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2500376

## Symptoms

After you rename the computer, you experience one of the following symptoms.

### Symptoms 1

When you select the **Go Offline** button in Microsoft Dynamics CRM, you receive the following error messages:

> An error occurred during installing database. Contact your Microsoft Dynamics CRM administrator for assistance and try going offline again.
>
>Platform Trace errors:
>
> Exception occurred in dbInstaller.Install. Detaching and removing indeterminate database files. Logon failure: unknown user name or bad password.
>
> Crm Exception: Message: An error occurred during installing database, ErrorCode: -2147204571

### Symptoms 2

When you configure the Microsoft Dynamics CRM Client for Microsoft Office Outlook, you receive the following error message:

> Network path not found.

## Cause

This problem occurs because the name of the computer is changed while the Microsoft Dynamics CRM Client for Microsoft Office Outlook is installed.

## Resolution

If you renamed your computer, follow these steps:

1. Uninstall Microsoft SQL Express and the Microsoft Dynamics CRM Client for Microsoft Office Outlook.
2. Reinstall the Microsoft Dynamics CRM Client for Microsoft Office Outlook.

If you intend to rename your computer, follow these steps:

1. Uninstall Microsoft SQL Express and the Microsoft Dynamics CRM Client for Microsoft Office Outlook before you rename your computer.
2. Reinstall the Microsoft Dynamics CRM Client for Microsoft Office Outlook.
