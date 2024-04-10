---
title: Error when installing CRM 2016 for Outlook
description: Provides a solution to an error that occurs when you try to install Microsoft Dynamics CRM 2016 for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-client-outlook
---
# Your version of Microsoft Dynamics CRM for Outlook isn't supported for upgrading to CRM 2016 for Outlook

This article provides a solution to an error that occurs when you try to install Microsoft Dynamics CRM 2016 for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2016, Microsoft  Dynamics CRM Online  
_Original KB number:_ &nbsp; 3182010

## Symptoms

When you attempt to install Microsoft Dynamics CRM 2016 for Outlook, you receive the following error:

> "Your version of Microsoft Dynamics CRM for Outlook isn't supported for upgrading to CRM 2016 for Outlook. You must first upgrade CRM for Outlook to a version that is supported for upgrading to CRM 2016 for Outlook."

## Cause

You can only upgrade to CRM 2016 for Outlook if you currently have CRM 2015 for Outlook.

## Resolution

If you want to upgrade CRM 2013 for Outlook to CRM 2016 for Outlook, you have two options:

Option 1: First upgrade to [CRM 2015 for Outlook](https://www.microsoft.com/download/details.aspx?id=45015). After upgrading to CRM 2015 for Outlook, upgrade to [CRM 2016 for Outlook](https://www.microsoft.com/download/details.aspx?id=50370).

Option 2: Uninstall Microsoft Dynamics CRM 2013 for Microsoft Office Outlook using **Add/Remove Programs** from within Control Panel. After uninstalling CRM 2013 for Outlook, install [CRM 2016 for Outlook](https://www.microsoft.com/download/details.aspx?id=50370).

## More information

If you still meet issues installing or connecting CRM for Outlook to a CRM Online organization, run the [Microsoft Support and Recovery Assistant](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant).
