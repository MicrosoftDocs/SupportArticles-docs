---
title: Error occurs when running the Sync
description: Provides a solution to errors that occur when you run the Synchronize with CRM function in the Microsoft Dynamics CRM 2011 Outlook Client.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Unable to cast object of type System.DBNull to type System.String error occurs when you run the Synchronize with CRM function in the Microsoft Dynamics CRM 2011 Outlook client

This article provides a solution to errors that occur when you run the Synchronize with CRM function in the Microsoft Dynamics CRM 2011 Outlook client.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011, Microsoft CRM client for Microsoft Office Outlook  
_Original KB number:_ &nbsp; 2715605

## Symptoms

During synchronization of the Microsoft Dynamics CRM 2011 for Microsoft Office Outlook client, a user will receive the following error:

> "Microsoft CRM has encountered a problem and needs to close. We are sorry for the inconvenience."

When reviewing the error details within the error dialog box by selecting **What does this error report contain?**, the following error will be shown:

> "Unable to cast object of type 'System.DBNull' to type 'System.String'"

## Cause

The error is caused by a field in a local SQL CE database that contains a null value.

## Resolution

Use the following steps to resolve this issue on a Windows XP machine:

1. Close Microsoft Office Outlook.
2. Browse to `C:\Documents` and `Settings\<Username>\Application Data\Microsoft\MSCRM\Client` and delete the contents of this folder, which will include the local SDF files.
3. Browse to `C:\Documents` and `Settings\<Username>\Local Settings\Application Data\Microsoft\MSCRM\Client` and delete the contents of this folder, which will include the local SDF files.
4. Start Microsoft Office Outlook.
5. When you start Outlook for the first time after deleting the SDF files, you'll notice some slow performance. It's expected because the SDF files are being recreated.

Use the following steps to resolve this issue on a Windows Vista or Windows 7 machine:

1. Close Microsoft Office Outlook.
2. Browse to `C:\Users\<Username>\AppData\Roaming\Microsoft\MSCRM\Client` and delete the contents of this folder, which will include the local SDF files.
3. Browse to `C:\Users\<Username>\AppData\Local\Microsoft\MSCRM\Client` and delete the contents of this folder, which will include the local SDF files.
4. Start Microsoft Office Outlook.
5. When you start Outlook for the first time after deleting the SDF files, you'll notice some slow performance. It's expected because the SDF files are being recreated.
