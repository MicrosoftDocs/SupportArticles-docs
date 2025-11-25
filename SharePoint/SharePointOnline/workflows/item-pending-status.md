---
title: SharePoint item that requires content approval reverts to Pending status
description: Describes an issue in which a SharePoint item that requires content approval reverts to Pending status, and provides a solution.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Workflows and Automation\Other
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# SharePoint Online item that requires content approval reverts to "Pending" status

> [!CAUTION]
> SharePoint 2013 workflows are scheduled for retirement in April 2024. For more information, see: [SharePoint 2013 workflow retirement](https://support.microsoft.com/office/sharepoint-2013-workflow-retirement-4613d9cf-69aa-40f7-b6bf-6e7831c9691e).

## Problem

Consider the following scenario:

- In a Microsoft SharePoint Online library, the **Require content approval for submitted items?** option under **Library Settings, Versioning settings** is set to ***Yes***.

- You run a Microsoft SharePoint 2013 workflow on an item in the library.

- After the workflow is finished, the **Approval Status** of the item changes to ***Pending***.

## Solution

To work around this issue, disable automatic updating of the workflow status to the current stage name. To do so, follow these steps:

1. Open the affected workflow in SharePoint Designer 2013.

1. On the **Workflow Settings** page for the workflow, clear the **Automatically update the workflow status to the current stage name** check box.

1. Save the workflow, and then and publish it to the SharePoint website.

## More information

The status of the item changes when the workflow is run and the **Automatically update the workflow status to the current stage name** is enabled for the workflow. It starts the approval process for the affected item.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
