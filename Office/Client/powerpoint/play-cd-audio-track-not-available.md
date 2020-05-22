---
title: The Play CD Audio Track command is not available
description: Explains that the Play CD Audio Track command was removed from the Audio drop-down list on the Ribbon in PowerPoint 2010. We recommend that you transfer the CD tracks to a MP3 file for playback in PowerPoint 2010. The command Play CD Audio Track is still available by customizing the ribbon.
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
localization_priority: Normal
ms.reviewer: sandy, arykhus, kemille, richpo, debbiery
search.appverid: 
- MET150
appliesto:
- PowerPoint 2010
- PowerPoint 2013
- PowerPoint Home and Student 2010
---

# The "Play CD Audio Track" command is not available on the ribbon in PowerPoint 2010

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

##  Summary

In Microsoft PowerPoint 2010, the command **Play CD Audio Track** is not available from the **Audio** drop-down list in the **Media** group on the **Insert** tab of the ribbon. If you want to play a music track from an audio CD, we recommend that you transfer the audio track that you want to play to an MP3 audio file format. You can use Windows Media Player or another, similar program to create the MP3 file. For more information about how to transfer tracks from a CD to MP3 files, see the Windows Media Player Help topic "Rip music from a CD."

##  More Information

### How to insert an MP3 audio file into a PowerPoint presentation
To insert an MP3 audio file into your PowerPoint 2010 presentation, follow these steps:

1. On the slide to which you want to add the audio track, click the **Insert** tab, and then in the **Media** group, under **Audio**, click **Audio from File**.    
2. Select the MP3 file that contains the audio track, and then click **Insert**.    
3. Under **Audio Tools**, click the **Playback** tab.   
4. In the **Audio Options** group, on the **Start** drop-down list, select either **Automatically**, **On Click**, or **Play across slides**, depending on how you want play the file.   
5. Click to select the **Hide During Show** check box.   
6. If you want the audio track to play continuously, click to select the **Loop until stopped** check box.   

### How to add the "Play CD Audio Track" command to the "Insert" tab
If you want to add the **Play CD Audio Track** command back to the **Insert** tab, you must create a custom group and then add the command to the new group. To do this, follow these steps:

1. Click the **File** tab, and then click **Options** in the navigation pane. 
2. In the navigation pane of the **PowerPoint Options** window, click **Customize Ribbon**.   
3. In the **Customize the ribbon** column, in the **Main Tabs** list, expand **Insert**, and then select **Media**.   
4. Under the **Main Tabs** list, click **New Group**. The new group named **New Group (Custom)** is inserted under the **Media** group.   
5. Click **Rename**, type CD Audio, and then click **OK**.   
6. In the **Choose command from** drop-down list, select **All commands**.   
7. Locate and then select the **Play CD Audio Track** command, and then click the **Add** button. The command appears under the new **CD Audio** group.   
8. Click **OK**.   

The new group **CD Audio** together with the command **Play CD Audio Track** is displayed on the right side of the Media group.