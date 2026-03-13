---
title: A Workflow Status error is reported when a SharePoint 2010 workflow stops
description: When a workflow instance reaches the Stop Workflow action, an error that has a Correlation ID is reported to the Workflow Status page.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Workflows and Automation\Workflow 2013
  - CSSTroubleshoot
appliesto: 
  - SharePoint Designer 2013
ms.date: 12/02/2025
---

# A Workflow Status error is reported when a SharePoint 2010 workflow stops

> [!IMPORTANT]
> SharePoint 2013 workflow has been turned off on all newly created tenants since April 2, 2024. It will be removed from all existing tenants on April 2, 2026. See [SharePoint 2013 workflow retirement](https://support.microsoft.com/office/sharepoint-2013-workflow-retirement-4613d9cf-69aa-40f7-b6bf-6e7831c9691e) for more information.

## Symptoms

As you create a Microsoft SharePoint 2010 workflow in Microsoft SharePoint Designer 2013, one of the available workflow actions is **Stop Workflow**. The **Stop Workflow** action sets the status of the workflow instance to **Completed** and optionally logs a custom message to the **Workflow History** list.

When a workflow instance reaches the **Stop Workflow** action, an error that has a Correlation ID is reported to the Workflow Status page for that workflow instance.

:::image type="content" source="./media/error-reported-in-sharepoint-2010-workflow-status/stop-workflow.png" alt-text="Screenshot that shows SharePoint 2010 Stopped Workflow information page with an error.":::!

## Cause

This behavior is by design. Although the workflow author has to specify the **Stop Workflow** action, the SharePoint 2010 workflow platform handles the **Stop Workflow** action as if an error has occurred, and then prints the corresponding diagnostic information.

## Status

This behavior is harmless and doesn't affect the execution of the workflow. The reported error can be safely ignored.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
