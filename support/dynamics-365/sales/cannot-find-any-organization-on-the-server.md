---
title: Cannot find any organization on the server when connecting CRM for Outlook
description: Provides a solution to an issue in which you receive Cannot find any organizations on the server when you try to connect Microsoft Dynamics CRM for Office Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Cannot find any organizations on the server error when attempting to connect Microsoft Dynamics CRM for Office Outlook

This article provides a solution to an error that occurs when you try to connect Microsoft Dynamics CRM for Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 3089671

## Symptoms

When you attempt to connect Microsoft Dynamics CRM for Microsoft Office Outlook, you receive the following error:

> Cannot find any organizations on the server. Try entering the URL again. If the problem persists, contact your system administrator.

## Cause

It doesn't necessarily mean there are no CRM organizations at the URL you specified. It means no CRM organizations were found for your user record that aren't already configured with Microsoft Dynamics CRM for Office Outlook already. Which could appear for one of the following reasons:

1. You don't have access to any of the organizations for the specified CRM deployment.
2. The organizations you have access to are already configured for this Microsoft Dynamics CRM for Office Outlook installation.

## Resolution

Make sure you can access the wanted CRM organization using your web browser with the same username and password. If you can't access using your web browser, contact your Microsoft Dynamics CRM administrator. If you can access the CRM organization using your web browser with the same username and password and you're using the CRM Online option, try connecting using that same URL instead of choosing CRM Online in the Configuration Wizard.

If the CRM organization is already configured but you want to configure to that organization as a different user, first delete the existing organization from within the Microsoft Dynamics CRM for Outlook Configuration Manager.

## More information

If you're still meeting issues connecting CRM for Outlook to your CRM Online organization, [a diagnostic tool](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant) is available to help diagnose the issue.
