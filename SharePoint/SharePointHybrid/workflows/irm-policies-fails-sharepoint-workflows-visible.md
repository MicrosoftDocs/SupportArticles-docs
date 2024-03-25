---
title: SharePoint 2013 workflow isn't visible in IRM retention policy
description: You cannot view SharePoint 2013 workflows created by using the SharePoint 2013 Workflow Platform content type in IRM policies.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Workflows and Automation\Workflow 2013
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
  - SharePoint Server
ms.date: 12/17/2023
---

# SharePoint 2013 workflows aren't available for IRM policies in SharePoint Online or SharePoint Server on-premises

## Problem

You create a Microsoft SharePoint 2013 workflow by using the SharePoint 2013 Workflow Platform content type on a list or a library in SharePoint Server 2013 on-premises or SharePoint Online. However, the workflow isn't visible in Information Rights Management (IRM) Retention Policy.

## Solution

To work around this issue, use the SharePoint 2010 Workflow Platform content type when you create the workflow.

## More information

SharePoint 2010 workflow associations are the only kind of workflow that's surfaced by the IRM Retention Policy. The **SPWorkflowAssociation** class is the only class that's enumerated on the list or content type level that's displayed on the workflow drop-down menu.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
