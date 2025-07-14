---
title: Cannot use object linking and embedding error in Excel 2016 for Mac
description: Describes an issue that triggers a Cannot use object linking and embedding error in Excel 2016 for Mac. A workaround is provided.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Open\OLEError
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Excel 2016 for Mac
ms.date: 05/26/2025
---

# "Cannot use object linking and embedding" error in Excel 2016 for Mac

## Symptoms

In Microsoft Excel 2016 for Mac, you receive the following error message:

> Cannot use object linking and embedding

## Workaround

To work around this issue, follow these steps:

1. Exit all Microsoft Office applications.   
2. In the Finder, navigate to the following location:

   Users/\<username>/Library/Group Containers/UBF8T346G9.Office

3. Select one of the following folders, depending on which one you have:

   ComRPC

   **ComRPC32**

4. On the **File** menu, click **Move to Trash**.   
5. Close the Finder window.
