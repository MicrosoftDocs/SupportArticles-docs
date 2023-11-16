---
title: It looks like the app is not installed for your Outlook mailbox error
description: We're sorry. It looks like the app isn't installed for your Outlook mailbox. You may receive this error when using Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# It looks like the app isn't installed for your Outlook mailbox error occurs when using Dynamics 365 App for Outlook

This article provides a resolution for the issue that you can't open the Microsoft Dynamics 365 App for Outlook on a Mac due to the **It looks like the app isn't installed for your Outlook mailbox** error.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4295094

## Symptoms

When you open the Microsoft Dynamics 365 App for Outlook on a Mac, you encounter the following error message:

> We're sorry. It looks like the app isn't installed for your Outlook mailbox. Please contact your system administrator.

## Cause

This error can be caused by stale data in the Outlook for Mac web browser cache.

## Resolution

Fully clear the cache using the following steps:

1. Start the Finder application.
1. Hold the **Option** button down and then select the **Go** menu. The **Library** option should appear as one of the available options.
1. Select the **Library** menu option. The Library folder view will appear.
1. Under the Library folder, locate the Containers folder and expand it.
1. Under the Containers folder, locate the com.MicrosoftOsfWebHost folder and expand it.
1. To clear the web browser cache, you must move the following to the Trash:
   - com.Microsoft.OsfWebHost/Data/Library/Caches/com.Microsoft.OsfWebHost (whole folder)
   - com.Microsoft.OsfWebHost/Data Library/Cookies/Cookies.binarycookies (file)
1. Restart Outlook and restart the Microsoft Dynamics 365 App for Outlook.
