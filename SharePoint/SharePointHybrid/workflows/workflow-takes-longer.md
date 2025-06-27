---
title: SharePoint 2010 workflow takes longer than expected to complete
description: Fixes an issue in which a SharePoint 2010 workflow in SharePoint Online takes longer than expected to complete or shows Please wait for about one minute.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Workflows and Automation\Performance
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# A SharePoint 2010 workflow in SharePoint Online takes longer than expected to complete or shows "Please wait" for about one minute

## Problem

When you start a SharePoint Online workflow that uses the Microsoft SharePoint 2010 Workflow platform type, you experience one of the following symptoms:

- The workflow displays a "Please wait while your workflow is started" message for about one minute.
- The workflow takes longer than expected to complete or seems slow.

Depending on the point at which you interact with the workflow, such as a web browser, through Microsoft Outlook or approving a task, the workflow takes about one minute to respond when you approve a task or do a similar action and the workflow seems slow. Examples of common situations that may experience this issue include out-of-box (OOB) workflows, such as:

- Approval
- Publishing Approval
- Collect Feedback
- Collect Signatures

## Solution/Workaround

To work around this issue, convert the workflow from the SharePoint 2010 Workflow platform type to the Microsoft SharePoint 2013 Workflow platform type.

> [!NOTE]
> This method requires you to rewrite the whole workflow. Before you use this method, review your current configuration to assess the requirements.

## More information

This problem occurs because the workflow has to be compiled before it can be processed. The workflow is cached after the compilation process runs. However, the problem may also occur on other servers. Additionally, cached workflows are cleared at least every night but can occur more frequently.

If a workflow has to complete compiling before it runs, you encounter this delay. It can cause the workflow to take longer than expected or seem slow. This is expected behavior. SharePoint 2010 workflows enable enterprises to reduce the number of unnecessary interactions between people as they run business processes. Workflows such as an approval workflow generally require human interaction because they aren't designed to immediately process an action. Therefore, you may experience the behavior that's described in the "PROBLEM" section, such as the approving of a task being slow or taking longer than expected, if the workflow has to compile.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
