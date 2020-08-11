---
title: Add Section command is unavailable
description: Describes a known issue with PowerPoint sections, new in Office 2010.
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: CSSTroubleshoot
ms.reviewer: adrianp
search.appverid: 
- MET150
appliesto:
- PowerPoint 2010
- PowerPoint 2013
- Office Home and Business 2010
- Office Home and Business 2013
- Office Home and Student 2010
- Office Home and Student 2013
- Office Professional 2010
- Office Professional 2013
- Office Professional Academic 2010
- Office Professional Plus 2010
- Office Professional Plus 2013
- Office Professional Plus 2010 Home Use Program
- Office Standard 2010
- Office Standard 2013
- Office Starter 2010
---

# 'Add Section' command is unavailable in PowerPoint 2010

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

##  Symptoms

When you try to add sections by clicking the Home tab, in the Slides group, click on Section, the Add Section command is unavailable (grayed out). The command is also unavailable if you right-click inside of the slides pane in Normal View or right-click inside of Slide Sorter View.

##  Cause

The presentation is in Compatibility Mode. The file was saved as PowerPoint 97-2003Presentation (*.ppt) format. If you look at the Title Bar of the PowerPoint application (bar across the top of the PowerPoint window) it will read filename [Compatibility Mode] and the file extension is *.ppt.

##  Resolution

Convert the presentation to a native PowerPoint 2010 presentation by clicking on the File tab, and in the Info section click the Convert button and save the file as PowerPoint Presentation (*.pptx).

##  More Information

Once you convert the presentation to a PowerPoint Presentation (*.pptx) and open the file in previous versions of PowerPoint, you will no longer have the sections visible. However, if you reopen the file in PowerPoint 2010 the sections will be available.

For more information on slide sections in PowerPoint 2010 read the following help article on the Office website:

[Organize your PowerPoint slides into sections](https://office.microsoft.com/powerpoint-help/organize-your-slides-into-sections-ha010344969.aspx).