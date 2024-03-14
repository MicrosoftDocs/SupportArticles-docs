---
title: Can't open a document created through SharePoint 2013 Workflow Platform
description: Fixes an issue in which You are unable to open a document created as part of a workflow that uses SharePoint 2013 Workflow Platform Type in SharePoint Online.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# Document that was created through the SharePoint 2013 Workflow Platform doesn't open in SharePoint Online

## Problem

Consider the following scenario:

- You create a content type in Microsoft SharePoint Online, and then you associate a template with the content type.
- You associate the content type with a list.
- You use the SharePoint 2013 Workflow Platform Type to create a workflow in Microsoft SharePoint Designer 2013.

You configure the workflow to create a document that uses the content type with the associated template.

When you click the document that was created as part of the workflow, you receive the following message if the document opens in the Microsoft Word for the web:

**Sorry, Word for the web ran into a problem opening this document. To view this document please open it in Microsoft Word.**

When you try to open the document in Microsoft Word by clicking **Open in Word**, the document is blank.

## Solution/Workaround

To work around this issue, use the SharePoint 2010 Workflow Platform Type to create the workflow in SharePoint Designer 2013.

> [!NOTE]
> The template that's used for the content type must be based on the .docx Word document format.

## More information

This issue occurs when workflows that use the SharePoint 2013 Workflow Platform Type create a document in a list that's based on a template from a content type.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
