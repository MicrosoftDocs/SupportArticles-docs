---
title: STOREDRV.Deliver.Exception:ObjectNotFoundException.MapiExceptionNotFound
description: Describes an issue that returns a "554.5.2.0 Cannot get ID from name" nondelivery report when users send mail to a distribution group in Exchange Online. Provides a workaround.
author: simonxjx
audience: ITPro
ms.service: exchange-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
---

# "554 5.2.0 STOREDRV.Deliver.Exception:ObjectNotFoundException.MapiExceptionNotFound" NDR when users send mail in Exchange Online

## Problem 

When users send messages to a specific mailbox in Exchange Online, they receive a nondelivery report that contains the following error code:

**554 5.2.0 STOREDRV.Deliver.Exception:ObjectNotFoundException.MapiExceptionNotFound; Failed to process message due to a permanent exception with message Cannot get ID from name**

For example, users may experience this issue when they send mail to a distribution group. 

## Cause 

This issue occurs if the Clutter feature is enabled for the user but the Clutter folder is missing in the user’s mailbox. 

## Workaround 

To work around this issue, turn off Clutter for the user. To do this, use one of the following methods.

### Method 1: Use Outlook on the web

1. In Outlook on the web, click **Settings** in the upper-right corner.   
2. Click **My app settings**, click **Mail**, and then click **Clutter**.    
3. Clear the **Separate items identified as clutter **check box, and then click **Save**.    

For more information about how to turn Clutter on or off, see [Use Clutter to sort low priority messages in Outlook 2016 for Windows](https://support.office.com/article/use-clutter-to-sort-low-priority-messages-in-outlook-2016-for-windows-7b50c5db-7704-4e55-8a1b-dfc7bf1eafa0).

### Method 2: Use Exchange Online PowerShell

1. Connect to Exchange Online by using PowerShell. For more information, see [Connect to Exchange Online using remote PowerShell](https://technet.microsoft.com/library/jj984289%28v=exchg.160%29.aspx).   
2. Run the following command:

    ```powershell
    Get-Mailbox user@contoso.com | Set-Clutter -Enable $false
    ```

For more information about how to use the Set-Clutter cmdlet to turn Clutter on or off, see [Set-Clutter](https://technet.microsoft.com/library/mt586787%28v=exchg.160%29.aspx). 

## MORE INFORMATION 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).