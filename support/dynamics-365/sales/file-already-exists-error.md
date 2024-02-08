---
title: File already exists error
description: Provides a solution to an error that occurs when you configure CRM for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# File already exists error when configuring Microsoft Dynamics CRM for Microsoft Office Outlook

This article provides a solution to an error that occurs when you configure Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online, Microsoft Dynamics CRM 2016, Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2013, Microsoft CRM client for Microsoft Office Outlook  
_Original KB number:_ &nbsp; 3183053

## Symptoms

When attempting to configure Microsoft Dynamics CRM for Microsoft Office Outlook, you receive the following error:

> "There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. Try again later. If the problem persists, contact your system administrator.

> File already exists. Try using a different database name. [ File name = C:\Users\\\<USER>\AppData\Local\Microsoft\MSCRM\Client\MetadataCache-5243bc89-09f7-4d12-b578-8efd890f5d7c.sdf ]..."

## Cause

This error can occur if a database file from a previous configuration already exists for your CRM instance.

## Resolution

Option 1 (CRM Online)

1. If you're using CRM Online, you can run the [Microsoft Support and Recovery Assistant](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant), which can fix this issue for you.
2. Choose the **Dynamics CRM Online** option, and then select **I'm having trouble installing, connecting, or enabling CRM for Outlook (Outlook Client)**.
3. Continue through the wizard. The Remove cache files used by CRM for Outlook action should appear and will remove the existing file referenced in the error.
4. Run the Microsoft Dynamics CRM Configuration Wizard again.

Option 2 (Manual)

If you aren't using CRM Online or prefer to fix the issue manually, complete the following steps.

1. Close Outlook.
2. Open Windows Explorer and navigate to `<install directory>:\Users\<Your User>\AppData\Local\Microsoft\MSCRM\Client`.

    Example: `C:\Users\<username>\AppData\Local\Microsoft\MSCRM\Client`

    > [!NOTE]
    > The AppData folder is hidden by default. You can change the View settings to show Hidden items or you can copy and paste the following path into your folder path:  
    `%localappdata%\Microsoft\MSCRM\Client`

3. Delete the file referenced in the error details.
4. Run the Microsoft Dynamics CRM Configuration Wizard again.
