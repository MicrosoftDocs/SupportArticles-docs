---
title: Unable to set a value for publishing column using SharePoint 2013 workflow
description: Fixes an issue in which you receive an error saying the property does not exist when setting a value for Hyperlink with formatting and constraints for publishing column.
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
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# Can't set value for "Hyperlink with formatting and constraints for publishing" column by using SharePoint 2013 workflow in SharePoint Online

## Problem

When you set a value for the **Hyperlink with formatting and constraints for publishing** column in Microsoft SharePoint Online, a SharePoint 2013 workflow is canceled. Additionally, you receive the following error message:

**The property PropertyName does not exist on type 'SP.Data.ListNameListItem'. Make sure to only use property names that are defined by the type.**

## Cause

The REST endpoint that the workflow uses is the following:

`https://tenant.sharepoint.com/sites/SiteCol/_api/web/lists(guid'GUID')/Items(N)`

But it doesn't return the field value—for the **Hyperlink with formatting and constraints for publishing** field type.

This is a limitation of the underlying REST layer that currently cannot be changed.

## Solution/Workaround

To work around this issue, use one of the following methods:

- Method 1: Work on the column from the **hyperlink or picture** type for the links.
- Method 2: Update the **Hyperlink with formatting and constraints for publishing** column value by using a SharePoint 2010 workflow (that can be called from a SharePoint 2013 workflow).

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
