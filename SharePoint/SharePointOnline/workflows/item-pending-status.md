---
title: SharePoint item that requires content approval reverts to Pending status
description: This article describes an issue where SharePoint Online item that requires content approval reverts to Pending status, and provides a solution.
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

# SharePoint Online item that requires content approval reverts to "Pending" status

## Problem

Consider the following scenario.

- In a Microsoft SharePoint Online library, the **Require content approval for submitted items?** option under **Library Settings, Versioning settings** is set to ***Yes***.

- You run a Microsoft SharePoint 2013 workflow on an item that's contained in the library.

- After the workflow is finished, the **Approval Status** of the item changes to ***Pending***.

## Solution

To work around this issue, disable automatic updating of the workflow status to the current stage name. To do this, follow these steps:

1. Open the affected workflow in SharePoint Designer 2013.

1. On the **Workflow Settings** page for the workflow, clear the **Automatically update the workflow status to the current stage name** check box.

1. Save the workflow, and then and publish it to the SharePoint website.

## More information

The status of the item changes when the workflow is run and when the **Automatically update the workflow status to the current stage name** is enabled for the workflow. This starts the approval process for the affected item.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
