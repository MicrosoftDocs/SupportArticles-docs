---
title: Track Changes functionality is disabled when RMS is applied
description:  Describes that the Track Changes functionality is disabled when Rights Management Services (RMS) is applied, and provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Word for Office 365
- Word 2019
- Word 2016
- Word 2013
---

# Word Track Changes functionality disabled when Rights Management Services (RMS) is applied

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

You are editing a Microsoft Word document that has Rights Management Services (RMS) applied to it and includes tracked changes. You notice that you cannot use Word's Track Changes feature. The Track Changes control, as well as the Accept and Reject changes controls are disabled. 

This applies when the RMS is applied to individual documents or when RMS is applied to a SharePoint site library.  

## Cause

You will see this behavior when you don't have "Full control" provided by Rights Management Services (RMS) for the user. A Microsoft Word file that contains tracked changes has the changes stored in a log within the file. In order to preserve the tracked changes log in a less than full control permissions scenario, the Track Changes and Accept Changes features are disabled for users who do not have "Full control" in the My Permission dialog for the RMS protected document.  

## Resolution

This behavior is by design. To use Word's track changes feature with RMS, provide access level under RMS as "Full control" for a user on an individual Word document or provide "Full Control" for the user in the SharePoint document library permissions.  

## More Information

The following reviewing features are only available with "Full control" permissions: 
 
- Turning on or off Track Changes    
- Delete Comments    
- The Accept dropdown    
- The Reject dropdown    
 
Within the Track Changes dropdown, the Track Changes Options will be enabled, but within that dialog, the following two options will be disabled unless the user has Full Control permissions: 
 
- Track moves    
- Track formatting    
