---
title: SharePoint workflow using an impersonation step doesn't complete
description: SharePoint workflow with an impersonation step that you return field values for a user account as something other than As a string does not finish when you run it.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Workflows and Automation\Other
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server 2013
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# A SharePoint workflow that uses an impersonation step doesn't complete when you return field values for a user account as something other than "As a string"

## Problem

Consider the following scenario:

- You create a workflow in SharePoint Designer 2013 by using the SharePoint 2010 Workflow Platform type in SharePoint Online, SharePoint Server 2013, or SharePoint Server 2010.
- Within the workflow, you have an impersonation step. The impersonation step is configured to do the following:

  - Return a field that has a value other than **As a string**.
  - Use the value in that field to change permissions.

- The field that you are trying to collect information from contains user accounts.

In this scenario, when you run the workflow, the workflow does not finish, and the status is displayed as **Error Occurred**.

## Solution

To resolve this problem, configure the **Return field as** value within the impersonation step to **As a string**.

## More information

This problem occurs if the person or group column allows multiple selections and if the value in that column is returned as something other than **As a string**. This configuration causes the workflow to fail.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
