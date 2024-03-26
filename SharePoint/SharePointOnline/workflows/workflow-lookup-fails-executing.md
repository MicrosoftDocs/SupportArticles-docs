---
title: The SharePoint workflow lookup column field is not supported in query
description: SharePoint workflow is configured to use a site column that performs a lookup doesn't execute with the error saying the field is not supported in query.
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
ms.date: 12/17/2023
---

# A SharePoint workflow that uses a site column to perform a lookup on a list on a different site doesn't execute

## Problem

Consider the following scenario:

- You create a workflow in Microsoft SharePoint Online or Microsoft SharePoint Server 2013.
- The workflow uses the SharePoint 2013 Workflow platform type.
- The workflow is configured to use a site column that performs a lookup to a list in a site that differs from where the workflow executes.

In this scenario, the workflow doesn't execute, and you receive the following error message:

**The field *lookup column name* is not supported in query. The lookup list is in another web.**

> [!NOTE]
> In this message, the placeholder <**lookup column name**> represents the name of the specific column.

## Solution

This is expected behavior in a workflow that uses the SharePoint 2013 Workflow platform type in either SharePoint Online or SharePoint Server 2013.

The SharePoint 2013 workflows use the REST endpoints to perform their work. The RESTful endpoint that's responsible for making this query isn't able to pull queries across subsites.

> [!NOTE]
> SharePoint 2010 workflows execute correctly in this scenario.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
