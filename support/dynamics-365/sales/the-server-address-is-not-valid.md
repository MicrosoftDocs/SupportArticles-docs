---
title: The server address isn't valid
description: Fixes an issue in which you receive the server address (URL) is not valid when you try to configure Microsoft Dynamics CRM for Microsoft Office Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# "The server address (URL) is not valid" error when you try to configure Microsoft Dynamics CRM for Microsoft Office Outlook

This article provides a solution to an error that occurs when you try to configure Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 3123894

## Symptoms

When you try to configure Microsoft Dynamics CRM for Microsoft Office Outlook, you receive the following error message:

> "The server address (URL) is not valid"

## Cause

The URL you provided is either not valid or isn't working to access Microsoft Dynamics CRM.

## Resolution

To verify that the URL is valid and can successfully access Microsoft Dynamics CRM, try using the exact same URL to access CRM via your web browser. If you're unable to access your CRM organization via your web browser, CRM for Outlook can't access either. If you're attempting to connect to a CRM Online organization, try choosing the CRM Online option instead of typing a URL in the Microsoft Dynamics CRM for Outlook Configuration Wizard.

If you're still meeting issues connecting CRM for Outlook to your CRM Online organization, run the [Microsoft Support and Recovery Assistant](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant) to diagnose and fix the problem.
