---
title: A workflow configured to send an email message to users at a time doesn't work
description: A SharePoint workflow that's set to send a custom email message to more than 200 users at a time, more than 10,000 recipients per day, or more than 30 messages per minute cannot run.
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
ms.date: 12/17/2023
---

# "Daily email limit has exceeded and your workflow has been suspended" or "Unable to send to a recipient" error in a SharePoint Online workflow

## Problem

Consider the following scenario:

- You have a workflow in SharePoint Online that's using the SharePoint 2010 or SharePoint 2013 workflow platform type.
- The workflow is configured to send a custom email message to more than 200 users at a time, more than 10,000 recipients per day, or more than 30 messages per minute.
- When you run the workflow, the email message isn't sent, and you notice the following behavior:

  - For a workflow using the SharePoint 2013 platform type, you browse to the Workflow Status page. On the **Workflow Status** page, the **Internal Status** is set to **Suspended**, and the information balloon displays the following message:
   
    **Daily email limit has exceeded and your workflow has been suspended.**

  - For a workflow using the SharePoint 2010 platform type, you browse to the Workflow Status page, and the page shows that the workflow is completed. However, you find that the email message was not sent. You may also notice additional information on the page stating that the email message was not sent.

- When you run the workflow, multiple email messages are received until you terminate the workflow and you notice the following behavior:

  - For a workflow using the SharePoint 2013 platform type, you browse to the **Workflow Status** page. On the **Workflow Status** page, the **Internal Status** is set to **Started**, and the information balloon displays the following message:

    **Unable to send to a recipient**

## Solution/Workaround

To work around this issue, configure your workflow to send email messages without exceeding the Exchange Online sender limits. For example, use a pause in the workflow, send the email to a Microsoft 365 group, a distribution group or mail enabled security group, or send the message to fewer than 200 recipients at a time.

> [!NOTE]
> It's considered a best practice to send the email to a Microsoft 365 group, distribution group or mail enabled security group.

## More information

This issue occurs when you exceed the Exchange Online message limits configured for SharePoint Online outgoing emails. 

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
