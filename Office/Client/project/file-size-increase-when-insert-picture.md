---
title: File size increases greatly
description: Provides the workaround to resolve the file size increases greatly issue after you insert a picture ino a project plan.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: v-dahedm
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Office Project Standard 2003
  - Project Professional 2010
  - Project Standard 2010
  - Project Professional 2013
  - Project 2013 Standard
ms.date: 03/31/2022
---

# File size increases greatly when you insert a picture into a Project plan

## Symptoms

When you insert a picture into a Microsoft Project task, into a Microsoft Project resource, or into a Microsoft Project assignment note and then you save your Microsoft Project plan, the size of your Microsoft Project file may increase more than you expect it to. 

## Cause

The RichEdit control (Riched20.dll) causes this problem. This problem may occur when you insert the picture into another container (for example, a WordPad document) and then you insert that container in your Microsoft Project file. Typically , the RichEdit control stores the container as Rich Text Format (RTF) in your Microsoft Project file so that both the container and the picture can be seen. The size of the RTF information may cause a large increase in file size.

## Workaround

To work around this behavior, insert the picture directly into your Microsoft Project task, into your Microsoft Project task resource, or into your Microsoft Project task assignment note. 

If you are using Project 98 through Project 2007, use the following steps:

1. In a Microsoft Project task, in a Microsoft Project resource, or in a Microsoft Project assignment note, click **Object** on the **Insert** menu.   
2. In the **Insert Object** dialog box, click **Create from File**.   
3. Click **Browse**, and then select the picture that you want to insert.   
4. Click **Insert**, and then click **OK**.   

If you are using Project 2013 or 2010, use the following steps:

1. Add the Object command to the Ribbon. If the Object command has already been added to the Ribbon bar, please proceed to Step 2.
   1. In Project, right-click the ribbon and select Customize the Ribbon.   
   2. Below the right column, click New Group after determining which level you would like it created at in the list above. If you wish to modify the name, click Rename.   
   3. In the left column, change the Choose commands from to All Commands.   
   4. Locate and select Object from the list in the left column.   
   5. With the new custom group selected, click the Add button to move Object from the left column into the right column   
   6. Click OK.   

2. In a Microsoft Project task, in a Microsoft Project resource, or in a Microsoft Project assignment note, click Object on the Ribbon bar. The location may vary based on the location you place the custom group you created in the steps above.   
3. In the Insert Object dialog box, click Create from File.   
4. Click Browse, and then select the picture that you want to insert.   
5. Click Insert, and then click OK.
