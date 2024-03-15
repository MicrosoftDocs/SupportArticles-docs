---
title: Outlook 2013 doesn't respond when you approve a SharePoint workflow
description: You created a workflow that contains at least one Start Approval Process action, however, Outlook 2013 doesn't respond when you approve the workflow.
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

# Outlook 2013 doesn't respond when you approve a SharePoint Online approval workflow in Microsoft 365

## Problem

Consider the following scenario.

- You a created a **List Workflow** in SharePoint Designer 2013 by using the SharePoint 2010 Workflow Platform Type.
- The workflow contains at least one **Start Approval Process** action.
- As expected, each workflow instance sends a notification email message to the approvers. Each approver opens the notification email message in Outlook 2013, and then clicks **Open this Task**.
- In the **Approval Task** dialog box, the approver clicks the **Approve** button.

In this scenario, Outlook 2013 does not respond for about 30 seconds, and then becomes responsive again.

## Solution/Workaround

To work around this issue, perform one of the following actions, as appropriate:

- In the approval notification email message, add a hyperlink to the task. Instruct users to click the hyperlink in the message and then approve the item by using the web browser within SharePoint Online instead of approving the item by using Outlook 2013.
- Convert the workflow from the SharePoint 2010 Workflow Platform Type to the SharePoint 2013 Workflow Platform Type.

  > [!NOTE]
  > This method involves rewriting the whole workflow. Before you use this method, review your current configuration to assess the requirements.

## More information

This is a known issue in SharePoint Online. This issue occurs because each SharePoint 2010 Workflow is compiled before it's executed. The more complex the SharePoint Designer 2010 workflow is, the longer this compilation requires to finish (up to about 30 seconds).

For more information about approval workflows, go to [Understand approval workflows in SharePoint Server](https://support.office.com/article/understand-approval-workflows-in-sharepoint-server-a24bcd14-0e3c-4449-b936-267d6c478579).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
