---
title: Cannot update. Database or object is read-only error in linked SharePoint list in Access
description: Discusses that you receive a Cannot update. Database or object is read-only error message if a SharePoint list contains a hidden metadata column in Access. Provides a workaround.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Access 2016
  - Access 2010
  - Access 2013
  - Access for Microsoft 365
  - Access 2019
ms.date: 05/26/2025
---

# "Cannot update. Database or object is read-only" error in linked SharePoint list in Access

## Symptoms

When you work in a Microsoft Access table that is linked to a Microsoft SharePoint list that contains a hidden metadata column, you receive the following error message:

> Cannot update. Database or object is read-only

## Cause

This error is caused by a known issue in Microsoft Access that occurs when a table is linked to a SharePoint list that has hidden metadata.

## Workaround

To work around this problem, re-create the list without the metadata columns.

## More Information

The problem is not resolved even after you remove the managed metadata column from the existing list.

The presence of the "TaxonomyHiddenList" linked table within the database indicates that one or more of the tables that are linked to a SharePoint list reference (or used to reference) a hidden metadata column. For example, the list references or used to reference an **Enterprise Keywords** column.

In Design view, you can check whether the table contains a **Taxonomy Catch All** field. This field indicates that the SharePoint list currently has or at some time in the past had a reference to a hidden metadata column that is associated with this field.

For more information about known issues that occur when you use SharePoint lists in Access, see [Access cache formats for SharePoint lists/document libraries](https://support.microsoft.com/help/3200688).
