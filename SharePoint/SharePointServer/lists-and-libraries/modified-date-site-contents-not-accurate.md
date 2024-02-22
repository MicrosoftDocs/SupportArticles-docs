---
title: Modified dates on the SharePoint site contents page are not accurate
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
  - SharePoint Server 2019
  - SharePoint Server 2016
  - SharePoint Server 2013
ms.custom: 
  - CI 108026
  - CSSTroubleshoot
ms.reviewer: lvaznis
description: Explains why the modified dates in a SharePoint site contents page do not reflect the correct dates.
---

# Modified dates on the SharePoint site contents page are not accurate

## Symptoms
When users browse to the site contents page in SharePoint 2016 and prior versions of the product, the modified date for inactive lists, libraries, and sites is more recent than expected since no changes were made by users to these objects.

## Cause
In SharePoint 2016 and prior versions of the product, the modified date on the site contents page reflects the value stored in the <code>ItemLastModifiedDate</code> property of the object. The value of this property reflects not only changes that are made by users, it may also be updated by system events.

## Resolution
This is expected behavior for SharePoint 2016 and prior versions. This behavior has been modified in SharePoint 2019 and SharePoint Online by introducing a new attribute (<code>LastItemUserModifiedDate</code>) to track changes that are the result of the user events. Items on the site contents page now reflect the value of this property.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
