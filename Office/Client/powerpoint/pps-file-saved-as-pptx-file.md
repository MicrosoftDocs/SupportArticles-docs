---
title: A PowerPoint Show .pps file is saved as a PowerPoint .pptx file
description: Describes an issue when you edit and save changes to a PowerPoint Show .pps file in your web browser. The file is saved as a PowerPoint Presentation .pptx file. Workarounds are provided.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: jeffhuan
search.appverid: 
- MET150
appliesto:
- PowerPoint 2013
- PowerPoint 2010
- PowerPoint for the web
---

# A PowerPoint Show .pps file is saved as a PowerPoint .pptx file when you save changes after you edit it in your web browser

## Symptoms

Consider the following scenarios.

Scenario 1

- You upload a Microsoft PowerPoint Show .pps file to a Microsoft SharePoint site on a server that is running Microsoft PowerPoint Online, or you save a PowerPoint Show .pps file to the SharePoint site by using Microsoft PowerPoint.   
- In your web browser, you locate the .pps file on the SharePoint site, and then you click **View in Browser** to view the file.   
- You click **Edit in Browser**, and then you click **Convert** to open the file for editing.   

Scenario 2

- You upload a PowerPoint Show .pps file to a OneDrive folder, or you save a PowerPoint Show .pps file to a OneDrive folder by using Microsoft PowerPoint.   
- In a web browser, you locate the OneDrive folder, and then you click the **View** link to open the .pps file.   
- You click **Edit in Browser**, and then you click **Convert** to open the file for editing.   

In these scenarios, the PowerPoint Show .pps file is saved as a PowerPoint Presentation (.pptx) file when you save changes to the file instead of the PowerPoint Show (.ppsx) file that you expect.

## Workaround

To work around this issue, you must save the converted file as **PowerPoint Show (*.ppsx)**. To do this, use one of the following workarounds, as appropriate for your situation.

Workaround for scenario 1

1. In your web browser, locate the .pptx file on the SharePoint site, and then click **Edit in Microsoft PowerPoint** to open the file in PowerPoint on your computer.

   **Note** The file that you open has a name that resembles "file_name - converted.pptx."

2. Press **F12** to open the **Save As** dialog box.   
3. In the **Save as type** box, click **PowerPoint Show (*.ppsx)**, and then click **Save** to save the file to the same location on the SharePoint site.   

Workaround for scenario 2

1. In your web browser, open the OneDrive folder, and then locate the .pptx file.   
2. Click **View** to open the file in the PowerPoint Web application.

   **Note** The file that you open has a name that resembles "file_name - converted.pptx."

3. Click the **Open in PowerPoint** button to open the file in PowerPoint on your computer.   
4. Press **F12** to open the **Save As** dialog box.   
5. In the **Save as type** box, click **PowerPoint Show (*.ppsx)**, and then click **Save** to save the file to the same location in the OneDrive folder.   
