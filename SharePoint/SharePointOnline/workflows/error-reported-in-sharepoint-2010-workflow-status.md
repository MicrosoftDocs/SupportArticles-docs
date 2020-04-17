---
title: A Workflow Status error is reported when a SharePoint 2010 workflow stops
description: When a workflow instance reaches the Stop Workflow action, an error that has a Correlation ID is reported to the Workflow Status page.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-solutions
ms.topic: article
ms.author: v-maqiu
ms.custom: CSSTroubleshoot
localization_priority: Normal
appliesto:
- SharePoint Designer 2013
---

# A Workflow Status error is reported when a SharePoint 2010 workflow stops

## Symptoms

As you create a Microsoft SharePoint 2010 workflow in Microsoft SharePoint Designer 2013, one of the available workflow actions is **Stop Workflow**. The **Stop Workflow** action sets the status of the workflow instance to **Completed** and optionally logs a custom message to the **Workflow History** list.

When a workflow instance reaches the **Stop Workflow** action, an error that has a Correlation ID is reported to the Workflow Status page for that workflow instance.

![SharePoint 2010 Stopped Workflow information page with an error](./media/error-reported-in-sharepoint-2010-workflow-status/stop-workflow.png)

## Cause

This behavior is by design. Although the workflow author has to specify the **Stop Workflow** action, the SharePoint 2010 workflow platform handles the **Stop Workflow** action as if an error has occurred, and then prints the corresponding diagnostic information.

## Status

This behavior is harmless and doesn't affect the execution of the workflow. The reported error can be safely ignored.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
