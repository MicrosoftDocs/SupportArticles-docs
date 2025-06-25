---
title: Slide Library toolbar is unavailable
description: Describes and provides a workaround an issue in which the Slide Library toolbar is unavailable on a SharePoint Slide Library site when you install a version of Office 2013 other than the MSI-based version.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: adrianp, v-yilia
ms.custom: 
  - sap:Administration\Lists and libraries
  - CSSTroubleshoot
appliesto: 
  - PowerPoint 2013
  - Office Home and Business 2013
  - Office Home and Student 2013
  - Office Professional 2013
  - Office Professional Plus 2013
  - Office Standard 2013
  - Office Home and Student 2013 RT
ms.date: 12/17/2023
---

# The Slide Library toolbar on a SharePoint Slide Library site is unavailable for certain Office 2013 installations

## Summary

Assume that you install Microsoft Office 2013 through Click-to-Run installation, or you are using Microsoft Office Home and Student 2013 RT. When you use a web browser to view a Slide Library site on a SharePoint server, the Slide Library toolbar is unavailable on the site. Therefore, you cannot use the Slide Library toolbar to add a slide to a presentation from a Slide Library.

## Cause

This issue occurs because the Slide Library ActiveX control is not part of the Office Home and Student 2013 RT installation, nor is it installed when you perform an Office 2013 Click-to-Run installation.

## More Information

The Slide Library ActiveX control is used for communication between the PowerPoint 2013 client and the SharePoint server. The Slide Library toolbar is available only on a Slide Library site after you install the MSI-based version of Office 2013. Additionally, the Slide Library toolbar is only supported on Internet Explorer 8 and Internet Explorer 9.

## Workaround

For information about how to add a slide from a Slide Library to a PowerPoint 2013 presentation, go to the following Microsoft website:

[Reuse slides from another presentation](https://support.microsoft.com/office/c67671cd-386b-45dd-a1b4-1e656458bb86)

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
