---
title: The document preview and content type icon aren't displayed
description: This article describes an issue where the document preview and content type icon aren't displayed in a SharePoint search when you change the search result types display template, and provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
  - SharePoint Server
ms.date: 12/17/2023
---

# The document preview and content type icon aren't displayed when you change the search result types display template

## Problem

Consider the following scenario:

- In Microsoft SharePoint Server 2013 or Microsoft SharePoint Online in Microsoft 365, you change your search result types by specifying a display template other than the default template.

- You perform a search and then view the results that are returned.

In this scenario, the document type icon isn't displayed, and the document preview doesn't work.

## Solution

For document previews to work after templates are changed, you must follow these steps:

1. Create a new template for each different document search result type that you want to use.

1. In the **Result Types** section, and create a new copy of each affected result type that points to the new templates that you created.

This lets the search result Web Part select the correct template based on the kind of document. The Web Part will use templates that have previews for the file types that can display previews. 

For more information about result types and templates, see [About configuring result types](https://support.office.com/article/89c412f0-e248-41ef-ad43-5471ef4ed997).

## More information

This behavior is by design, depending on which template is used. For example, the **Default Item** template is usually used when a file of unknown type (such as source-code instead of a PowerPoint deck) is encountered. Therefore, this template doesn't show document previews.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
