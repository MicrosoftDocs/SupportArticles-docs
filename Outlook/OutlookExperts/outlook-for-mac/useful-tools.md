---
title: Outlook for Mac support tools.
description: Describes some useful tools for Microsoft Outlook for Mac.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto:
- Outlook for Mac for Office 365
---

# Outlook for Mac support tools

## Summary

This article describes some useful tools for Microsoft Outlook for Mac. 

## More information

### Outlook Search Repair

The Outlook Search Repair tool repairs search results within Outlook. 

> [!IMPORTANT]
> Due to some changes in macOS Mojave, this tool no longer works in 10.14 and higher. If you are on macOS Mojave (10.14), you can follow the steps below to reindex Spotlight for Outlook for Mac.
> 
> 1. Choose **Apple menu**, then **System Preferences**, and then **Spotlight**.
> 1. Select the **Privacy** tab.
> 1. In Finder:
>     1. On the Go menu, select **Go to Folder...**
>     1. Copy and paste the following location into the "Go to the folder:" dialog box and select **Go**:
> 
>        > ~/Library/Group Containers/UBF8T346G9.Office/Outlook/Outlook 15 Profiles/
> 1. Drag the "Main Profile" folder to the **Privacy** tab. Once added, remove the folder, and Spotlight will re-index the folder.
> 
>     You must perform this step for any additional profile folders you have.
> 
> See the following article from Apple to learn more: [How to rebuild the Spotlight index on your Mac](https://support.apple.com/HT201716). 

#### When to use the tool 

Use this tool if search results within Outlook show nothing or return older items only. For example, if you search for an email message that you already have open and that message isn't displayed in the search results.

#### How to use the tool

1. Download and open the [Outlook Search Repair tool](https://download.microsoft.com/download/4/C/8/4C8BF360-635A-42F9-80EE-7AADFE37CC1A/OutlookSearchRepair.zip).
1. Follow the instructions.

   **Note** The tool searches for duplicate installations of Outlook. If no duplicates are detected, go to step 3. If duplicates are detected, remove the duplicate Outlook installations, and then restart the system. After your system is restarted, the Outlook Search Repair tool may reopen. If it does reopen, exit and restart the tool.

1. Select **Reindex**.

    **Note** The Outlook Search Repair tool displays a "Reindexing, please wait" message while it works. Wait for this process to finish. This may require an hour or more, depending on the size of your Outlook profile. Outlook doesn't have to be open when the repair occurs. A spotlight search will be slower and may not finish while the index is being repaired.
1. Exit the Outlook Search Repair tool when you receive the following message after the repair is completed:

    > **Done! Reindexing has completed!**

### OutlookResetPreferences

The Outlook Reset Preferences tool resets all Outlook preferences to their default settings.

#### When to use the tool 

Use this tool to reset any customizations that you've made to Outlook by using the **Preferences** option on the **Outlook** menu. This tool also stores the settings for the Outlook window size and position. This tool shouldn't be needed most of the time. But it can be useful.

**Note** The Outlook Preferences file doesn't contain all the preferences for the application. Also, resetting Outlook preferences doesn't remove email messages or account settings.

#### How to use the tool

1. Download and open the [Outlook Reset Preferences tool](https://download.microsoft.com/download/6/C/3/6C3CF698-61C1-4A6D-9F15-104BE03BC303/OutlookResetPreferences.zip).
1. Click the **Reset Now!** button. This closes Outlook if it's open, and then resets the preferences to their default settings.
1. Exit the Outlook Reset Preferences tool.

### SetDefaultMailApp

The Default Mail Application tool lets you easily make Outlook the default mail application.

#### When to use the tool

Use this tool if you want Outlook to open a new email message when you click a **mailto:** link in an email message or on a website. Selecting a **mailto:** link opens the default email application. Outlook isn't the default email application until you change that setting.

#### How to use the tool

1. Download and open the [Default Mail Application tool](https://download.microsoft.com/download/7/D/5/7D52637E-1E80-4AEF-A63A-0D7B4B7CD626/SetDefaultMailApp.zip).
1. In the **Default Mail Application** dialog box, select **com.microsoft.outlook**, and then click **Make Default**.
1. Exit the Default Mail Application tool.

### ResetRecentAddresses

The Reset Recent Addresses tool lets you reset recent addresses that Outlook stores. This tool deletes all recent addresses instead of you having to manually delete addresses one at a time.

#### When to use the tool

When you compose an email message and add people on the **To**, **Cc**, or **Bcc** line, Outlook suggests names as you type characters. The list of names that Outlook uses is a combination of stored contacts, the company directory, and recent contacts. Recent contacts have an "X" character next to each name. Without this tool, you have to click the "X" on each contact to remove that contact from the Recent Address List. The Reset Recent Addresses tool cleans out all recent addresses at the same time.

#### How to use the tool

1. Download and open the [ResetRecentAddresses tool](https://download.microsoft.com/download/D/B/D/DBDE37DD-7955-47A6-8E1A-C993F91C5753/OutlookResetRecentAddresses.zip).
1. Click the **Reset Now!** button.
1. Exit the Reset Outlook Recent Addresses tool.