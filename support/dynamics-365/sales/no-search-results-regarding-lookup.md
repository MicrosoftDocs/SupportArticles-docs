---
title: No search results in Regarding lookup
description: Provides a solution to an error that occurs when you search in the Regarding lookup field of Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# No search results returned in Regarding lookup of Microsoft Dynamics 365 App for Outlook

This article provides a solution to an error that occurs when you search in the Regarding lookup field of Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online, Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4489111

## Symptoms

When searching in the Regarding lookup field of Dynamics 365 App for Outlook, no records are returned. You see a message that says:

> "No records found. Create a new record."

## Cause

Microsoft is investigating the cause of this issue but it's typically caused by something cached on the client computer.

## Resolution

First try clearing the browser cache in Internet Explorer:

> [!NOTE]
> Although you may have other browsers installed on your computer, Outlook desktop always uses Internet Explorer when rendering web content such as inside Dynamics 365 App for Outlook.

1. Clear the cache in Internet Explorer.

    - [View and delete your browsing history in Internet Explorer](https://support.microsoft.com/topic/view-and-delete-your-browsing-history-in-internet-explorer-098ffe52-5ac9-a449-c296-c735c32c8678)

2. Close all Internet Explorer and Outlook Desktop windows and make sure through Task Manager there are no remaining Internet Explorer or Outlook processes running.

If this issue only appears in Outlook desktop and clearing the cache via Internet Options doesn't help, try clearing it via F12 chooser (not applicable for Windows 7):

1. Open Dynamics app in Outlook desktop
2. Open **IEChooser.exe** in `%WindowsFolder%\System32\F12` (example: `C:\Windows\System32\F12`)
3. Select **Dynamics 365**  
4. Select the **Network** tab and then select the **Clear cache** button.

After following the steps above, reopen Outlook and the Dynamics 365 App for Outlook to see if the issue is resolved.
