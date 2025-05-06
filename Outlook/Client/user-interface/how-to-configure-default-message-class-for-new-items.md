---
title: How to configure default message class for new items
description: Describes how to configure the default message class for new items in an Outlook folder.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:User Interface features and Configuration\Navigation Pane
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans, aruiz
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 03/19/2025
---
# How to configure the default message class for new items in an Outlook folder

_Original KB number:_ &nbsp; 2697986

Some custom or third-party solutions change the default message class that is used when new items are created in a Microsoft Outlook folder. The message class is associated with each item in a folder. Additionally, it defines which form to display when the item is opened. If a custom solution changes the default message class for an Outlook folder, uninstalling that solution may not reset the folder's new-item message class to the default configuration. In this situation, various issues can occur in Outlook, because the default new-item message class for a folder was changed from the default value. For example, if you select the **New** button to open a new item for the folder, the form does not seem to be the original default form that was installed by Outlook.

If you are not using a custom Outlook solution that requires a custom message class for new items in a folder, we recommend that you use the default message class for at least the following primary Outlook folders:

- Calendar
- Contacts
- Tasks

The following table lists the main default folders in Outlook in which custom messages classes are sometimes found. The second column in the table provides the default message class that is used for the folder.

|Folder|Default message class|
|---|---|
|Calendar|IPM.Appointment|
|Contacts|IPM.Contact|
|Tasks|IPM.Task|

To determine the currently configured default message class for new items on a folder, follow these steps:

1. Right-click the folder, and then select **Properties**.
2. Select the **General** tab.
3. Inspect the value that appears in the **When posting to this folder, use** list.
4. If you want to change the default message class for new items that you add to the folder, select the **When posting to this folder, use** list, and then select the appropriate message class for the folder. (See the table.)

> [!NOTE]
> If you already created items in the folder by using a custom message class, changing the **When posting to this folder, use** value does not change the message class on these *existing* items. When you change the **When posting to this folder, use** value, only items that are created after the change will use the newly configured message class.
