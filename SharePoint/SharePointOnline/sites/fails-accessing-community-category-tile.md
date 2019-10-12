---
title: Can't click a category tile inside a SharePoint Online community site
description: Cannot complete this action when clicking a category tile inside a community for a SharePoint Online site.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
appliesto:
- SharePoint Online
---

# "Cannot complete this action" error when you click a category tile inside a community for a SharePoint Online site

## Problem

Consider the following scenario:

- In Microsoft SharePoint Online, you save a subsite as a template by selecting the **Save site as template** option in **Site Settings**.
- The template was saved from a site that uses either a **Team Site** template for which the **Community Site Feature** is active or a **Community Site** template.
- You use the template that you saved to create a subsite.
- You create a category in the community and then click the tile for the category.

In this scenario, you receive the following error message:

**Cannot complete this action. Please try again.**

## Solution/Workaround

To work around this issue, create sites from a standard SharePoint Online template when you plan to use community categories. Categories will function correctly on a site that wasn't created from a site saved as a template.

## More information

This is a known issue in SharePoint Online.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).