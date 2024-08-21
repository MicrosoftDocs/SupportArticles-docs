---
title: SharePoint workflow isn't visible in IRM retention policy
description: You can't view SharePoint workflows that are created by using the SharePoint Server 2013 Workflow Platform content type in IRM policies.
author: helenclu
manager: dcscontentpm
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

# SharePoint Server 2013 workflows aren't available for IRM policies in SharePoint Online or SharePoint Server on-premises

## Problem

In SharePoint Server 2013 on-premises or SharePoint Online, you create a Microsoft SharePoint 2013 workflow by using the SharePoint 2013 Workflow Platform content type on a list or a library. However, the workflow isn't visible in Information Rights Management (IRM) Retention Policy.

## Solution

To work around this issue, use the SharePoint Server 2013 Workflow Platform content type when you create the workflow.

## More information

SharePoint Server 2013 workflow associations are the only workflow that the IRM Retention Policy surfaces. The **SPWorkflowAssociation** class is the only class enumerated on the list or content type level that the workflow drop-down menu displays.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
