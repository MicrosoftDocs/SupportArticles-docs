---
title: Silverlight web resources cannot be viewed
description: Provides a solution to an issue where Microsoft Silverlight web resources can't be viewed in the 64-bit version of the Microsoft Dynamics CRM Client for Microsoft Office Outlook.
ms.reviewer: chanson, henningp
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Microsoft SilverLight web resources can't be viewed in the 64-bit version of the Microsoft Dynamics CRM Client for Microsoft Office Outlook

This article provides a solution to an issue where Microsoft SilverLight web resources can't be viewed in the 64-bit version of the Microsoft Dynamics CRM Client for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2500373

## Symptoms 1

When you use Microsoft SilverLight together with web resources, the web resources can't be viewed in the 64-bit version of the Microsoft Dynamics CRM Client for Microsoft Office Outlook.

## Symptoms 2

If Microsoft SilverLight isn't installed on the Microsoft Dynamics CRM Client for Microsoft Office Outlook, a link to download SilverLight is provided. When you select that link, you receive one of the following error messages:

Error message 1  
> Navigation Cancelled

Error message 2  

> Permission Denied

## Cause 1

Microsoft SilverLight isn't supported in a 64-bit browser. The 64-bit version of Microsoft Dynamics CRM Client for Microsoft Office Outlook displays the browser by using a 64-bit browser. However, a 64-bit version of Microsoft SilverLight isn't available. So the web resources aren't rendered and can't be viewed.

## Cause 2

When you select the **Install Microsoft SilverLight** link, the installation is rendered inside the Outlook form and is unsuccessful.

## Resolution 1

Use the 32-bit version of Microsoft Dynamics CRM Client for Microsoft Office Outlook to view Microsoft SilverLight web resources.

## Resolution 2

Install Microsoft SilverLight by using Internet Explorer.
