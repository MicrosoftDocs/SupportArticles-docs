---
title: Workflow reports a status of Failed on Start (retrying)
description: A Collect Feedback – SharePoint 2010 workflow reports a status of Failed on Start (retrying) in SharePoint Online or SharePoint Server.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Workflows and Automation\Other
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - SharePoint Online
  - SharePoint Server
ms.date: 12/17/2023
---

# "Failed on Start (retrying)" status for a "Collect Feedback in SharePoint 2010" workflow in SharePoint Online or SharePoint Server

## Problem

Consider the following scenario:

- You're using a **Collect Feedback – SharePoint 2010** workflow in SharePoint Online or SharePoint Server.
- The tasks list where the feedback items are tracked for the workflow has a column or columns for which the **Enforce unique values** option is set to **Yes**. For example, this option may apply to the **Start Date** column.
- You start the workflow and select multiple users in the **Assign To** field, and then you select **All at once (parallel)** for the **Order** setting.

In this scenario, the workflow doesn't start the feedback process, and instead it reports a status of **Failed on Start (retrying)**.

## Solution

To work around this issue, use one of the following methods:

- Select **One at a time (serial)** for the Order setting when you start the workflow.
- Set the **Enforce unique values** setting to **No** for the affected tasks list column or columns in which the workflow tasks are stored.

## More information

When you start the workflow by using **All at once (parallel)** for the **Order** setting and when **Enforce unique values** is set to **Yes**, the workflow doesn't start because the values for the column aren't unique.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
