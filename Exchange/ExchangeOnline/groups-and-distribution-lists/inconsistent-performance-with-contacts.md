---
title: 
description: .
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 3/3/2023
---
# Inconsistent performance when working with contacts

## Symptoms

When working with contacts, you might experience symptoms such as the following:

- Calls from Microsoft Graph to perform operations against the Contacts folder may fail with a 503 or 504 error.

- Mail clients might experience performance issues or stop responding when working with contacts.

## Cause

We strongly recommend that you have no more than 10,000 items in your Contacts folder. This is because of the high input/output activity involved when working with contacts. Although 10,000 is NOT a limit that is enforced by Exchange Online, exceeding this number might cause performance issues.

## Resolution

You can use Microsoft Outlook to check the number of items in the Contacts folder in [Cached Exchange mode](https://support.microsoft.com/office/7885af08-9a60-4ec3-850a-e221c1ed0c1c). If it exceeds 10,000, delete some contacts to help mitigate the performance issues.

1. To determine the number of items in the Contacts folder, follow these steps:

    1. Open the People pane in Outlook, then right-click **Contacts**.

    1. Select **Properties**.

    1. On the **General** tab, select **Show total number of items**.

    1. Select the **Synchronization** tab.

    The number of items in the folder is displayed in the **Statistics for this folder** section.

1. To delete contacts, use either Outlook or Outlook on the Web. If you receive an error when attempting to delete multiple contacts at one time, select fewer contacts and try again.
