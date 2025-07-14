---
title: Workflow contains blank values in output from Multiple lines of text column
description: A Workflow designed to collect information from the Multiple lines of text column contains blank values in output.
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
  - SharePoint Server
ms.date: 12/17/2023
---

# Workflow that uses the SharePoint 2013 Workflow Platform Type contains blank values in output from the "Multiple lines of text" column

## Problem

Consider the following scenario:

- In SharePoint Online or SharePoint Server 2013, you use the SharePoint 2013 Workflow Platform Type to create a workflow in SharePoint Designer 2013.
- The workflow is designed to collect information from a column during list item creation or update. The column type is set to **Multiple lines of text**, and the **Append Changes to Existing Text** option for the column is set to ***Yes***.
- The workflow is configured to include the collected information in an action such as **Send An Email or Log To History List**.

When you view the output email message or logged information in this scenario, the value is empty and doesn't include the value from the **Multiple lines of text** column.

## Solution

To work around this issue, disable automatic updating of the workflow status to the current stage name. To do this, follow these steps:

1. Open the affected workflow in Microsoft SharePoint Designer 2013.
1. On the **Workflow Settings** page for the workflow, clear the **Automatically update the workflow status to the current stage name** check box.
1. Save the workflow, and then and publish it to the SharePoint website.
1. Run the workflow again.

> [!NOTE]
> - When you clear this setting, you may want to use the **Set Workflow Status** action as part of the workflow to update the **Workflow Status** field if that appears to be necessary. Otherwise, the status won't be listed.
> - You may also want to consider saving the value of the **Multiple lines of text** column in a workflow variable if you plan to update the list item within the workflow logic.
> - In this scenario, the value from the **Multiple Lines of text** column will be blank if you edit the list item but don't change the **Multiple Lines of Text** column.

## More information

This issue occurs because the **Multiple lines of text** column that has the **Append Changes to Existing Text** setting applied to it updates itself internally with an empty value when you update another column in the list item by using a workflow. When the workflow updates the **Status** column during execution in this scenario, the value of the **Multiple lines of text** becomes blank in the output.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
