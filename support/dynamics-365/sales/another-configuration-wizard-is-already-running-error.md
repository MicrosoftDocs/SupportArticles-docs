---
title: Another Configuration Wizard is already running error in Dynamics CRM for Outlook
description: You receive a Another Configuration Wizard is already running error in Microsoft Dynamics CRM for Microsoft Office Outlook. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Another Configuration Wizard is already running error occurs in Microsoft Dynamics CRM for Outlook

This article provides a resolution for the issue that you may receive a **Another Configuration Wizard is already running** error in Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 3089599

## Symptoms

You encounter the following error with Microsoft Dynamics CRM for Office Outlook:

> Another Configuration Wizard is already running. Only one Configuration Wizard can run at a time. Please stop or complete the other wizard before continuing this wizard.

## Cause

Cause 1: After opening the Configuration Wizard, you opened Outlook, which resulted in another Configuration Wizard trying to initialize.

Cause 2: After selecting Configure Microsoft Dynamics CRM for Outlook within Outlook, you open the Configuration Wizard from the list of programs.

## Resolution

Complete the currently open Configuration Wizard before trying to start another instance of the Configuration Wizard. If another Configuration Wizard does not appear to be open, try closing Outlook and then start the Configuration Wizard from your list of installed programs.

## More information

If you are still encountering issues connecting Microsoft Dynamics CRM for Outlook to your CRM Online organization, a diagnostic tool is available to help diagnose the issue:

[Microsoft Support and Recovery Assistant](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant)
