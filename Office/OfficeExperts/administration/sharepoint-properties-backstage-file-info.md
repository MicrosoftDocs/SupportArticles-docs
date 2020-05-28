---
title: Properties of type (lookup – multi select) don't work on Office Backstage
description: You can't see and set SharePoint metadata properties of type on the Office Backstage area
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-solutions
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: warrenr
appliesto:
- Office 365
- Office 2019
- Office 2016
---

# SharePoint properties of type (lookup – multi select) don't work on Office Backstage

This article was written by [Warren Rath](https://social.technet.microsoft.com/profile/Warren_R_Msft), Support Escalation Engineer.

## Symptoms

In Microsoft Office 365, Office 2019, or Office 2016, when you try to open a document from SharePoint that has SharePoint metadata properties of type (for example, **Lookup** type > Multiple value selections), you don't see and set these properties on the Office Backstage area (**File** > **Info**).

## Cause

This is a current design limitation of Office, and there are no current plans to change this behavior.

## Workaround

If you use Word, you can use the SharePoint properties screen (through **View** tab > **Properties**) or use the properties page from the SharePoint web UI.

![SharePoint properties screen through the View tab](./media/sharepoint-properties-backstage-file-info/properties.png)