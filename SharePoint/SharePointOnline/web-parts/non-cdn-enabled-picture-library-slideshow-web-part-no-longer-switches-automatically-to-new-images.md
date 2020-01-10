---
title: Non-CDN-enabled SharePoint Picture Library Slideshow web part no longer switches automatically to new images
description: Describes an issue in which non-CDN-enabled SharePoint Picture Library Slideshow web part no longer switches automatically to new images.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
---

# Non-CDN-enabled SharePoint Picture Library Slideshow web part no longer switches automatically to new images

## Summary

The Picture Library Slideshow web part in Microsoft SharePoint Online lets users show a set of images from a picture library. By using the Picture Library Slideshow web part, you can enable visitors to your SharePoint page to navigate through a set of images one at a time.

A familiar functionality of the web part is the "auto rotate through images" feature. This lets visitors set an interval for the webpage to automatically cycle through through the library images.

In a recent update to Office 365 that is currently being deployed, the ability to automatically switch to new images is being deprecated for libraries that do not have a Content Delivery Network (CDN) enabled. This means that the AutoPlay functionality for existing websites will no longer function for Picture Library Slideshow web parts.

> [!NOTE]
> The manually operated **next** and **previous** buttons will continue to cycle through the images as expected regardless of whether the library is connected to a CDN-enabled Image Library.

This change takes advantage of the newly released CDN capability of SharePoint for the web part connection to picture libraries and also helps improve performance more widely across SharePoint sites.

## More information

To use the CDN together with the Picture Library Slideshow web part, your SharePoint Online tenant administrator must enable the CDN within your Office 365 tenancy.

After CDN capability is configured, you can work with your tenant administrator to enable a private CDN for the Image Library that you want to use as the source for your auto-rotating web part. To do this, the administrator must run additional scripts for the source image library.

For guidelines and instructions about how to enable the CDN and create a private CDN, see [General availability of Office 365 CDN](https://dev.office.com/blogs/general-availability-of-office-365-cdn).
