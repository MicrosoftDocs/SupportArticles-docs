---
title: Inconsistent performance when working with contacts
description: Describes an issue in which performance is inconsistent when you work with contacts.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: ninob
appliesto: 
  - Exchange Online
  - Outlook
search.appverid: 
  - MET150
ms.date: 01/24/2024
---
# Inconsistent performance when working with contacts

## Symptoms

When you work with contacts, you experience symptoms such as the following:

- Calls from Microsoft Graph to run operations on the *Contacts* folder fail and return a "503" or "504" error message.

- Mail clients experience performance issues or stop responding.

## Cause

We strongly recommend that you have no more than 10,000 items in your *Contacts* folder. This is because of the high input and output activity that occurs when you work with contacts. Although the 10,000-item limit is not enforced by Exchange Online, you might experience performance issues if you exceed this number.

## Resolution

Use Microsoft Outlook to check the number of items in the *Contacts* folder in [Cached Exchange mode](https://support.microsoft.com/office/7885af08-9a60-4ec3-850a-e221c1ed0c1c). If the amount exceeds 10,000, delete some contacts to help mitigate performance issues.

1. To determine the number of items in the *Contacts* folder, follow these steps:

    1. Open the **People** pane in Outlook, then right-click **Contacts**.

    1. Select **Properties**.

    1. On the **General** tab, select **Show total number of items**.

    1. Select the **Synchronization** tab.

    The number of items in the folder is displayed in the **Statistics for this folder** section.

1. To delete contacts, use either Outlook or Outlook on the web. If you receive an error message when you try to delete multiple contacts simultaneously, select fewer contacts, and then try again.
