---
title: How to delete a content type from the SharePoint Content Type Hub
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
  - SharePoint 2019
  - SharePoint 2016
  - SharePoint 2013
ms.custom: 
  - CI 117077
  - CSSTroubleshoot
ms.reviewer: paulpa
description: Describes how to correctly delete a content type from a SharePoint Content Type hub and the result if not deleted correctly.
---

# Deleting a content type from the SharePoint Content Type Hub

## Summary

When a content type is deleted from the SharePoint Content Type Hub, the content type will still be available in the subscriber site collection, but not on the newly created site collection. 

## More information

If a content type becomes unavailable on the content type hub, the subscribing site collections will have one of two outcomes:

- The content type will remain available for download for all site collections in every web application that consumes content types from the content type hub. Any copies of this content type will become orphaned, or:
- The content type will become unavailable for download for all site collections in every web application that consumes content types from the content type hub. Copies of this content type being used in subscribing site collections will be unsealed (set to not be read only) and made into a local content type. 

In no situation, the content type will be automatically removed from any subscribing site collections.

Once a content type is published, that content type definition for subscribing is stored in the term store database for the managed metadata service that the content type hub belongs to. The only way to change the content type definition is to manipulate the content type in the content type hub and republish it, causing an update to that item in the term store database and consequently updates to subscribing site collections' sealed copies. 

The nature of this structure means that, if you were to delete the content type from the content type hub without first unpublishing it, all copies of the content type in subscribing site collections will become orphaned—they will lose their ability to be updated while still thinking that they are subscribed. In fact, when a new site collection is created that utilizes that content type hub, that orphaned content type will appear because it is being retrieved from its item in the term store database. You will never be able to unpublish an orphaned content type, unless you follow the guidance in the blog post [How to unpublish a published content type if the published content type no longer exists](https://blog.stefan-gossner.com/2014/03/28/how-to-unpublish-a-published-content-type-if-the-published-content-type-no-longer-exists/).

If the content type is unpublished from the hub and deleted, it will still appear in the subscriber site collection.

### Deleting a content type

To correctly delete a content type, follow the steps below:
1.	Unpublish the content type.
2.	Delete the content type in the content type hub.
3.	Optionally, clean up unsealed copies of the content type in the subscribing site collections.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
