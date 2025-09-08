---
title: Document ID column isn't displayed as a column in SharePoint Online
description: Document IDs aren't assigned to items in a document library though you have enabled the Document ID Service feature on the site collection.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Lists and Libraries\Document set
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Document IDs aren't assigned to items in a document library in SharePoint Online

## Problem

Consider the following scenario:

- You have multiple custom content types that are based on a document content type. These custom content types are published from a content type hub site collection to subscriber site collections.
- On a subscriber site collection, you set one of the custom content types as the default content type on a document library.
- You enable the Document ID Service feature on the site collection.

When you go to the site collection and then view a document in a document library, the document IDs aren't assigned, and the document ID column isn't displayed as a column in a view.

## Solution

To enable the Document ID Service feature on a site collection that's subscribed to the content type hub, you must first enable the Document ID Service feature on the content type hub site collection. Then, you must republish syndicated content types so that the subscriber site collections can update their site content types.

For more information about how to publish a content type from a content type publishing hub, see [Publish a content type from a content publishing hub](https://support.office.com/article/publish-a-content-type-from-a-content-publishing-hub-58081155-118d-4e7a-9cc5-d43b5dbb7d02).

## More information

This issue occurs because a site content type that's published to a subscriber site collection is set to read-only when a content type hub publishes a content type. This occurs regardless of whether the content type that's defined on the content type hub is read-only. When the Document ID Service feature is enabled on the subscriber site collection, required columns are missing and cannot be provisioned because the site content type is read-only.

For more information about how to enable site collection features, see [Enable or disable site collection features](https://support.office.com/article/enable-or-disable-site-collection-features-a2f2a5c2-093d-4897-8b7f-37f86d83df04
).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
