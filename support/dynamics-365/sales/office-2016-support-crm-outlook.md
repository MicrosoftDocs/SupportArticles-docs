---
title: Office 2016 support for CRM for Outlook
description: Office 2016 support for CRM for Outlook 2013.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Office 2016 support for CRM for Outlook 2013

This article provides a solution to an error that occurs when the CRM 2013 for Outlook client is failing to install in Outlook 2016.

_Applies to:_ &nbsp; Microsoft CRM client for Microsoft Office Outlook, Microsoft Dynamics CRM 2016, Microsoft Dynamics CRM 2016 Service Pack 1  
_Original KB number:_ &nbsp; 3204403

## Symptoms

The CRM 2013 for Outlook client is failing to install in Outlook 2016 with the following error message:

> "The installation has failed. Setup cannot continue because Microsoft Office Outlook is not installed"

## Resolution

To resolve, follow the steps below:

Step 1: Install [Dynamics CRM 2013 for Microsoft Office Outlook (Outlook Client)](https://www.microsoft.com/download/details.aspx?id=40344)

Step 2: Install [Service Pack 1 for Microsoft Dynamics CRM 2013](https://www.microsoft.com/download/details.aspx?id=43109)

Step 3: Install [Update Rollup 4 for Microsoft Dynamics CRM 2013 Service Pack 1](https://www.microsoft.com/download/details.aspx?id=51185)

Step 4: Install [Critical Update for Microsoft Dynamics CRM 2013 Service Pack 1](https://www.microsoft.com/download/details.aspx?id=54123)

## More information

The following error will appear in the CRM for Outlook logs:

> 15:51:03| Info| Error while obtaining outlook.exe path from MSI component information: 1607.
>
> 15:51:03| Info| Error while obtaining outlook.exe path from MSI component information: 1607.
>
> 15:51:03|Warning| Error OutlookError
>
> 15:51:03| Info| Setup cannot continue because Microsoft Office Outlook is not installed.
