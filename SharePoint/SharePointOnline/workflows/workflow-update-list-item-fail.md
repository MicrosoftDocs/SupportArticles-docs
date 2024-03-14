---
title: Workflow that uses the Update List Item action fails to update a Person or Group column
description: This article describes an issue where SharePoint Online workflow that uses the Update List Item action fails to update a Person or Group column, and provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# SharePoint Online workflow that uses the Update List Item action fails to update a Person or Group column

## Problem

Consider the following scenario:

- You have a workflow that uses the SharePoint 2013 workflow platform type in SharePoint Online.

- The workflow is configured to use the Update List Item action to update a Person or Group column based on the data from a Single line of text column.

- The Single line of text column contains an apostrophe (').

When you run the workflow, the workflow doesn't update the Person or Group column with the value from the Single line of text column.

## Solution/Workaround

To work around this issue, do one of the following:

- Use a **Person or Group** column instead of a **Single Line of text** column as the source for the **Person or Group** column.

- Return the field as **Login Name**, not **Display Name**, when you use the **Update List Item** action to copy from one **Person or Group** column to another column.

## More information

This is a known issue in SharePoint Online. This issue occurs when you update a **Person or Group** column by using a value from a **Single line of text** column that contains an apostrophe (').

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
