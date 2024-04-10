---
title: Dynamics CRM for Outlook is disabled
description: Provides a solution to an issue where CRM for Outlook is disabled and appears grayed out.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Microsoft Dynamics CRM for Outlook is disabled after CRM instance is updated

This article provides a solution to an issue where CRM for Outlook is disabled and appears grayed out after your CRM instance is updated to a different major version.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2016, Microsoft CRM client for Microsoft Office Outlook, Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 3182213

## Symptoms

After your CRM instance is updated to a different major version, CRM for Outlook is disabled and appears grayed out. If you attempt to access one of the CRM folders, you receive the following error message:

> "You are running a version of Microsoft Dynamics CRM for Outlook that is incompatible with this Microsoft Dynamics CRM organization (\<version number>)."

## Cause

It can occur if your CRM for Outlook version isn't compatible with the updated version of your CRM instance. CRM for Outlook is only compatible with a CRM instance that is the same major version or one major version higher. For example: CRM 2013 for Outlook is compatible with a CRM 2013 or CRM 2015 instance. If your CRM instance is updated to CRM 2016, CRM 2013 for Outlook wouldn't be compatible. You would need [CRM 2015 for Outlook](https://www.microsoft.com/download/details.aspx?id=45015) or [CRM 2016 for Outlook](https://www.microsoft.com/download/details.aspx?id=50370) (recommended).

- CRM 2013 = version 6.x
- CRM 2015 = version 7.x
- CRM 2016 = version 8.x

## Resolution

Upgrade CRM for Outlook to be the same major version of your CRM instance or a maximum of one major version lower. If you're using CRM 2013 for Outlook and want to upgrade to CRM 2016 for Outlook, you either need to first upgrade to CRM 2015 for Outlook or uninstall CRM 2013 for Outlook before installing CRM 2016 for Outlook.

## More information

If you still meet issues installing, enabling, or connecting CRM for Outlook with a CRM Online organization, run the [Microsoft Support and Recovery Assistant](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant).
