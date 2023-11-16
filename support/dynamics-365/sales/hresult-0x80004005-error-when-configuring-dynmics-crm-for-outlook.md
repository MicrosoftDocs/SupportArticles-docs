---
title: HResult 0x80004005 error when configuring
description: When you try to set Microsoft Dynamics CRM for Microsoft Office Outlook, you receive the HResult 0x80004005 error. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# HResult 0x80004005 error when configuring Microsoft Dynamics CRM for Microsoft Office Outlook

This article provides a resolution for the **HResult 0x80004005** error that occurs when you try to configure Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online, Microsoft Dynamics CRM client for Microsoft Office Outlook, Microsoft Dynamics CRM 2016, Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 3182535

## Symptoms

When attempting to configure Microsoft Dynamics CRM for Microsoft Office Outlook, you receive the following error:

> "There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. Try again later. If the problem persists, contact your system administrator.
>
> HResult: 0x80004005 at Microsoft.Interop.Mapi.CRcwMsgServiceAdmin.ConfigureMsgService..."

## Cause

This error can occur if there is a problem with your installation of Outlook.

## Resolution

Repairing your Office programs may resolve this issue.

1. Close all running Office programs (such as Outlook, Word, or PowerPoint).
2. Open Windows Control Panel and select **Programs and Features**.
3. In the list of installed programs, right-click **Microsoft Office**, select **Change**, and follow the prompts.

> [!NOTE]
> If you are using Office Click-to-Run, see [Repair an Office application](https://support.microsoft.com/office/repair-an-office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b).

## More information

If you still encounter issues installing, enabling, or connecting Microsoft Dynamics CRM for Outlook with a Microsoft Dynamics CRM Online organization, run the [Microsoft Support and Recovery Assistant](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant).
